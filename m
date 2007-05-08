From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Git tree updated
Date: Tue, 8 May 2007 12:51:31 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47DCC783@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429F12539@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429F12539@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Yeah, I was also getting an error for the "if(i2c_del_driver" in twl4030 =
driver. The i2c_del_driver is a void function and we were testing the =
return condition.

static void __exit twl4030_exit(void)
{
        if (i2c_del_driver(&twl4030_driver))
                printk(KERN_ERR
                        "TWL4030: Driver remove failed, module not =
removed\n");

Temporarily I disabled MMC and corrected io.c and T2. 2430 SDP hangs =
while booting, I think this is what Tony was debugging yesterday.

Uncompressing =
Linux.............................................................
................................. done, booting the kernel.
<5>Linux version 2.6.21-omap1-gf2c4487d-dirty (khasim@omap-linux2) (gcc =
version
4.1.1 (CodeSourcery ARM Sourcery G++ 2006q3-26)) #1 PREEMPT Tue May 8 =
12:36:26 C
DT 2007
CPU: ARMv6-compatible processor [4107b366] revision 6 (ARMv6TEJ), =
cr=3D00c5387f
Machine: OMAP2430 sdp2430 board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 256 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 32512 pages, LIFO batch:7
<7>  Normal zone: 0 pages used for memmap



  =20

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-
>open-source-bounces@linux.omap.com] On Behalf Of Woodruff, Richard
>Sent: Tuesday, May 08, 2007 12:45 PM
>To: Tony Lindgren; linux-omap-open-source@linux.omap.com
>Subject: RE: Git tree updated
>
>I noticed that MMC doesn't compile either.
>
>The include/linux/mmc/card.h structure mmc_card changed removing the
>'node' element.
>
>Regards,
>Richard W.
>
>> -----Original Message-----
>> From: linux-omap-open-source-bounces@linux.omap.com
>[mailto:linux-omap-
>> open-source-bounces@linux.omap.com] On Behalf Of Tony Lindgren
>> Sent: Monday, May 07, 2007 10:20 PM
>> To: linux-omap-open-source@linux.omap.com
>> Subject: Git tree updated
>>
>> Hi all,
>>
>> I've updated our git tree to be in sync with mainline tree as Russell
>> has merged some of our pending patches.
>>
>> Looks like 24xx does not currently boot, it seems to hang at
>> devicemaps_init(). I've verified that at least 16xx boots.
>>
>> I'll have to continue debugging the 24xx devicemaps_init issue
>tomorrow,
>> if somebody gets it working before that, please post the patch :)
>>
>> Regards,
>>
>> Tony
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
