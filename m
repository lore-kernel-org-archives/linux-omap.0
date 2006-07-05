From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 1/4] Input: ads7846: detect pen up from IRQ state
Date: Wed, 05 Jul 2006 18:42:45 +0200
Message-ID: <44ABEC05.7070204@gmail.com>
References: <20060703182931.GA29921@localdomain> <44AA84CC.5020808@gmail.com>
	<20060705161832.GA32247@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060705161832.GA32247@localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: imre.deak@solidboot.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

imre.deak@solidboot.com wrote:
> On Tue, Jul 04, 2006 at 05:10:04PM +0200, Dirk Behme wrote:
>>imre.deak@solidboot.com wrote:
>>
>>>We can't depend on the pressure value to determine when the pen was
>>>lifted, so use the IRQ line state instead.
>>
>>Today, Tony pushed the "input: ads7846: can't disable 
>>filtering"
>>
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007358.html
>>
>>fix from beginning of June.
>  
> Uh, I forgot about that and noticed Tony's email about it too late.
> 
>>Yesterday, you posted a new patchset "[PATCH 1/1-4] Input: 
>>ads7846:". As I understand it, this recent patch set is the 
>>clean version of ads7846 and is a replacement for the old 
>>workaround now pushed by Tony? Or is it an add on?
> 
> The first patch of the set includes that fix. Now that it's pushed I'm
> posting an updated version of that first patch. The rest should apply ok.

Just applied patch 1-4 to recent git and tried on OSK and 
get crash below at module load.

Cheers

dirk

Unable to handle kernel NULL pointer dereference at virtual 
address 0000003a
pgd = c1a64000
[0000003a] *pgd=11c73031, *pte=00000000, *ppte=00000000
Internal error: Oops: 0 [#1]
Modules linked in: ads7846 omap_uwire spi_bitbang 
omap_keypad evdev nfs lockd suni
CPU: 0
PC is at 0x3a
LR is at ads7846_probe+0x148/0x73c [ads7846]
pc : [<0000003a>]    lr : [<bf082e04>]    Not tainted
sp : c1c7be74  ip : 00000000  fp : c1c7bea8
r10: c1c57000  r9 : c1c7a000  r8 : c1abc600
r7 : 00000001  r6 : c01a7d18  r5 : c1fe9000  r4 : 00000000
r3 : 0000003b  r2 : 0000ffff  r1 : c1fe92d0  r0 : c01a7d18
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 5317F  Table: 11A64000  DAC: 00000015
Process insmod (pid: 753, stack limit = 0xc1c7a198)
Stack: (0xc1c7be74 to 0xc1c7c000)
be60:                                              c1c7be90 
c01e3b80 c1fff8c0
be80: c1abc6cc c1abc600 00000000 bf0841a4 c0021fa4 c1c7a000 
00000000 c1c7beb8
bea0: c1c7beac c0148f64 bf082ccc c1c7bed8 c1c7bebc c0130eac 
c0148f50 c1abc6cc
bec0: c1abc600 c0130f9c bf0841a4 c1c7bef0 c1c7bedc c0131020 
c0130e40 00000000
bee0: c1c7bef4 c1c7bf1c c1c7bef4 c0130860 c0130fac c01e9b14 
c01e9b14 c1abc648
bf00: bf0841b8 bf0841a4 c01e9a14 00000080 c1c7bf2c c1c7bf20 
c0130dc0 c0130828
bf20: c1c7bf54 c1c7bf30 c01304bc c0130db0 bf0841a4 bf0842c0 
40017000 00000080
bf40: c0021fa4 00000002 c1c7bf68 c1c7bf58 c0131320 c0130460 
00002fe8 c1c7bf78
bf60: c1c7bf6c c0148da4 c013129c c1c7bf88 c1c7bf7c bf08603c 
c0148d64 c1c7bfa4
bf80: c1c7bf8c c0066120 bf086010 00000003 00000000 00000100 
00000000 c1c7bfa8
bfa0: c0021e00 c0066080 00000000 00000100 00900080 40017000 
00002fe8 0006e050
bfc0: 00000003 00000000 00000100 bebfbe94 bebfbf56 0000c7bc 
00000002 00000000
bfe0: bebfbdd0 bebfbdc4 0001e6fc 40122390 60000010 00900080 
e50b2028 e50b1024
Backtrace:
[<bf082cbc>] (ads7846_probe+0x0/0x73c [ads7846]) from 
[<c0148f64>] (spi_drv_probe)
[<c0148f40>] (spi_drv_probe+0x0/0x28) from [<c0130eac>] 
(driver_probe_device+0x7c)
[<c0130e30>] (driver_probe_device+0x0/0xcc) from 
[<c0131020>] (__driver_attach+0x)
  r7 = BF0841A4  r6 = C0130F9C  r5 = C1ABC600  r4 = C1ABC6CC
[<c0130f9c>] (__driver_attach+0x0/0xe4) from [<c0130860>] 
(bus_for_each_dev+0x48/)
  r5 = C1C7BEF4  r4 = 00000000
[<c0130818>] (bus_for_each_dev+0x0/0x80) from [<c0130dc0>] 
(driver_attach+0x20/0x)
  r7 = 00000080  r6 = C01E9A14  r5 = BF0841A4  r4 = BF0841B8
[<c0130da0>] (driver_attach+0x0/0x28) from [<c01304bc>] 
(bus_add_driver+0x6c/0x12)
[<c0130450>] (bus_add_driver+0x0/0x124) from [<c0131320>] 
(driver_register+0x94/0)
[<c013128c>] (driver_register+0x0/0xa4) from [<c0148da4>] 
(spi_register_driver+0x)
  r4 = 00002FE8
[<c0148d54>] (spi_register_driver+0x0/0x64) from 
[<bf08603c>] (ads7846_init+0x3c/)
[<bf086000>] (ads7846_init+0x0/0x44 [ads7846]) from 
[<c0066120>] (sys_init_module)
[<c0066070>] (sys_init_module+0x0/0x204) from [<c0021e00>] 
(ret_fast_syscall+0x0/)
  r6 = 00000100  r5 = 00000000  r4 = 00000003
Code: bad PC value.
  Segmentation fault
modprobe: failed to load module ads7846
