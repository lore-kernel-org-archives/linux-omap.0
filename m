From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 03/13] DSPBRIDGE: Moving functions from mem.c to drv.c
Date: Wed, 21 Apr 2010 18:57:47 -0500
Message-ID: <4BCF90FB.4080108@ti.com>
References: <818EF96F5A7CC84789DD014773DB09548F6481CF@dlee01.ent.ti.com> <20100416103658.GA18995@lit.local.igalia.com> <8F7AF80515AF0D4D93307E594F3CB40E4B21669A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070602090206050404010807"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49588 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab0DUX6V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 19:58:21 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B21669A@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: =?ISO-8859-1?Q?=22V=EDctor_M=2E_J=E1quez_L=2E=22?= <vjaquez@igalia.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>

--------------070602090206050404010807
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Kanigeri, Hari had written, on 04/16/2010 06:46 AM, the following:
> Ivan,
> 
>> In the commit 702b94bff3c50542a6e4ab9a4f4cef093262fe65 (2.6.34) the
>> functions
>> dmac_inv_range and dmac_clean_range were removed.
>>
>> I'm wondering how to fix this in order to rebase to 2.6.34.
>>
>> Thanks
> 
Sharing with a wider audience my experiments:

> 2 options:
> 
> 1. Replace dmac_inv_range and dmac_clean_range functions with the new dma map 
 >and unmap functions. These are supposed to be the new functions to do 
the same
 > functionality, but in our limited testing some time ago, the 
dma_unmap function
 > wasn't invalidating the cache. You can check this at your end.

I tried doing this with pm-wip-opp(.34-rc4) branch in kevin's tree with 
the attached patch on SDP3430.

result log.txt - test results using just the userspace from
http://dev.omapzoom.org/?p=tidspbridge/userspace-dspbridge.git;a=summary
short story:
ping - pass
dmmcopy - fail - this is inline with what Hari mentioned - in short, 
using map/unmap as a direct replacement is a no-go,

> 
> 2. Revert the patch that deprecated these APIs to unblock you temporarily.
git revert 702b94bff3c50542a6e4ab9a4f4cef093262fe65 works.. but ofcourse 
would be a temporary hack for those interested in moving on..

Will leave Hari/Omar to summarize some of the ideas they have.

-- 
Regards,
Nishanth Menon

--------------070602090206050404010807
Content-Type: text/x-patch;
	name="0001-DSPBRIDGE-mem-no-more-cache-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-DSPBRIDGE-mem-no-more-cache-handling.patch"

>From ea35037b8bf9af0ef068248f74ce6c9dcde4df6c Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Wed, 21 Apr 2010 14:49:28 -0500
Subject: [PATCH] DSPBRIDGE: mem: no more cache handling

quick hack to use map and unmap to handle invalid and clean ops

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/dsp/bridge/services/mem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 916a49f..49033e7 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -224,13 +224,13 @@ void mem_flush_cache(void *pMemBuf, u32 byte_size, s32 FlushType)
 	switch (FlushType) {
 		/* invalidate only */
 	case PROC_INVALIDATE_MEM:
-		dmac_inv_range(pMemBuf, pMemBuf + byte_size);
+		dmac_unmap_area(pMemBuf, byte_size, DMA_TO_DEVICE);
 		outer_inv_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
 							  byte_size));
 		break;
 		/* writeback only */
 	case PROC_WRITEBACK_MEM:
-		dmac_clean_range(pMemBuf, pMemBuf + byte_size);
+		dmac_map_area(pMemBuf, byte_size, DMA_FROM_DEVICE);
 		outer_clean_range(__pa((u32) pMemBuf), __pa((u32) pMemBuf +
 							    byte_size));
 		break;
-- 
1.6.3.3


--------------070602090206050404010807
Content-Type: text/plain; name="log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="log.txt"

# ./cexec.out ddspbase_tiomap3430.dof64P
DSP device detected !! 
proc_load: Processor Loaded ddspbase_tiomap3430.dof64P
omap mailbox rev 4.0
proc_start: dsp in running state
DSPProcessor_Start succeeded.procwrap_detach: deprecated dspbridge ioctl

Hit any key to terminate cexec.

# ./cexec.out dynbase_tiomap3430.dof64P
DSP device detected !! 
proc_load: Processor Loaded dynbase_tiomap3430.dof64P
omap mailbox rev 4.0
proc_start: dsp in running state
DSPProcessor_Start succeeded.procwrap_detach: deprecated dspbridge ioctl

Hit any key to terminate cexec.

# ./dynreg.out -r pingdyn_3430.dll64P
# ./ping.out 
DSP device detected !! 
DSPNodeCreate succeeded 
DSPNode_registerNotify succeeded 
DSPNode_run succeeded 
Ping: Id 1.000000 Msg 0.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 1.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 2.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 3.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 4.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 5.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 6.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 7.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 8.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 9.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 10.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 11.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 12.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 13.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 14.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 15.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 16.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 17.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 18.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 19.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 20.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 21.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 22.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 23.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 24.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 25.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 26.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 27.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 28.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 29.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 30.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 31.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 32.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 33.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 34.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 35.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 36.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 37.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 38.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 39.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 40.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 41.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 42.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 43.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 44.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 45.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 46.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 47.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 48.000000 Mem 14816.000000
Ping: Id 1.000000 Msg 49.000000 Mem 14816.000000
procwrap_detach: deprecated dspbridge ioctl

# ./dynreg.out -r dmmcopydyn_3430.dll64P
# du -h /dspbridge/test-input
10.0M	/dspbridge/test-input

# ./dmmcopy.out /dspbridge/test-input /dspbridge/test-output
DSP device detected !! 
DSPProcessor_Attach succeeded.
DSPNode_Allocate succeeded.
DSPNode_Create succeeded.
DSPNode_Run succeeded.
DSPProcessor_ReserveMemory succeeded. dspAddrSend= 0x203f0000 
DSPProcessor_ReserveMemory succeeded. dspAddrdRecv= 0x2040a000 
DSPProcessor_Map succeeded.
DSPProcessor_Map succeeded.
Sending DMM BUFs to DSP cmd=SETUP, DspRecvBuf=0x203f02e8, DspSendBuf=0x2040a2f0 
Read 102400 bytes from input file.
Writing 102400 bytes to output file.
Read 102400 bytes from input file.
Writing 102400 bytes to output file.
Sent and received buffers don't match 
Press any key to continue 


--------------070602090206050404010807--
