From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Wed, 18 Mar 2015 15:56:36 +0200
Message-ID: <55098414.9020301@ti.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756034AbbCRN4l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 09:56:41 -0400
In-Reply-To: <55087A3A.6070300@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>, linux-omap@vger.kernel.org

Petr,

On 03/17/2015 09:02 PM, Petr Kulhavy wrote:
> Hi Peter,
>=20
> thanks a lot for the details.
> I believe it's not an Ethernet issue, it's really related to the SD c=
ard. If
> we use the USB storage instead of the SD card on our device we don't =
see the
> leaks.

I believe you are not booting with DT. The two eDMA is only supported w=
hen
booting in legacy mode.

> I enabled the dynamic debug and added a debug message for the kzalloc=
() in
> edma_prep_slave_sg() and for the kfree() in the edma_desc_free() both=
 to print
> the pointer address. And it gives an interesting result, see below.
>=20
> You can see that after every alloc (i.e.edma_prep_slave_sg()) edma_ex=
ecute()
> is called ("file transfer starting..."), however not all of them end =
with
> "Transfer complete". And exactly those are also not freed.

I did the same on am335x-evmsk and I don't see the same issue (linux-ne=
xt). It
does not mean that we do not have the issue you describe, but somehow i=
t is
not that easy to reproduce. I will try my OMAP-L138 board, which is clo=
ser to
AM1808 than AM335x.

> Unfortunately I do not know how exactly the edma mechanism works with=
 all the
> callbacks, states, etc.
> But does it make any sense for you? Can you help me to debug more?

Not sure at the moment, but I would try to print also in the error case=
s in
the callback and track the edesc pointer in every prints to see where t=
he code
goes. I would enable the prints in the edma_execute as well to see what=
 is
going on there.

=46or reference I have these prints:
[  924.127638] ALLOC edesc: 0xcd948c40 (channel: 25, sg_len: 1, rounds:=
 1)
[  924.134598] first transfer starting on channel 25 (edesc: 0xcd948c40=
)
[  924.145505] Transfer complete, stopping channel: 25 (edesc: 0xcd948c=
40)
[  924.152561] FREE edesc: 0xcd948c40 (channel: 25)
[  924.159223] ALLOC edesc: 0xc916f800 (channel: 25, sg_len: 30, rounds=
: 2)
[  924.166611] first transfer starting on channel 25 (edesc: 0xc916f800=
)
[  924.180541] Intermediate transfer complete on channel: 25 (edesc: 0x=
c916f800)
[  924.188054] chan: 25: completed 30 elements, resuming (edesc: 0xc916=
f800)
[  924.195208] Error occurred on channel: 25 (edesc: 0xc916f800), TRIGG=
ERING
[  924.204117] Transfer complete, stopping channel: 25 (edesc: 0xc916f8=
00)
[  924.211158] FREE edesc: 0xc916f800 (channel: 25)
[  924.218407] ALLOC edesc: 0xc6cbce00 (channel: 25, sg_len: 8, rounds:=
 1)
[  924.225396] first transfer starting on channel 25 (edesc: 0xc6cbce00=
)
[  924.236530] Transfer complete, stopping channel: 25 (edesc: 0xc6cbce=
00)
[  924.243506] FREE edesc: 0xc6cbce00 (channel: 25)
[  924.248817] ALLOC edesc: 0xcaa5ec00 (channel: 25, sg_len: 12, rounds=
: 1)
[  924.256068] first transfer starting on channel 25 (edesc: 0xcaa5ec00=
)
[  924.268277] Transfer complete, stopping channel: 25 (edesc: 0xcaa5ec=
00)
[  924.275265] FREE edesc: 0xcaa5ec00 (channel: 25)



> Thanks
> Petr
>=20
> ALLOC edesc c65d5c80
> first transfer starting on channel 65565

The channel number does not seams right here.

> ALLOC edesc c5b69640

Would be nice to see the channel as well here. But sure the FREE for c6=
5d5c80
is missing. Strange, I don't see how this happens.
I have enabled PREEMPT and still can not reproduce - this was my first =
idea.

> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5b69640
> ALLOC edesc c58ec580
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c58ec580
> ALLOC edesc c5103d80
> first transfer starting on channel 65565
> ALLOC edesc c61e78c0
> first transfer starting on channel 65565
> ALLOC edesc c65d6f80
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c65d6f80
> ALLOC edesc c5b698c0
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5b698c0
> ALLOC edesc c52244c0
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c52244c0
> ALLOC edesc c52244c0
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c52244c0
> ALLOC edesc c52244c0
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c52244c0
> ALLOC edesc c52244c0
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c52244c0
> ALLOC edesc c58ec580
> first transfer starting on channel 65565
> ALLOC edesc c5b698c0
> first transfer starting on channel 65565
> ALLOC edesc c5103480
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5103480
> ALLOC edesc c5b69640
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5b69640
> ALLOC edesc c61e62c0
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c61e62c0
> ALLOC edesc c5227440
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5227440
> ALLOC edesc c5b69640
> first transfer starting on channel 65565
> ALLOC edesc c5b69b40
> first transfer starting on channel 65565
> ALLOC edesc c5233000
> first transfer starting on channel 65565
> ALLOC edesc c5233dc0
> first transfer starting on channel 65565
> ALLOC edesc c5233140
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5233140
> ALLOC edesc c5233140
> first transfer starting on channel 65565
> ALLOC edesc c5233280
> first transfer starting on channel 65565
> Transfer complete, stopping channel 29
> FREE edesc c5233280
>=20

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
