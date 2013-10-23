From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v10 04/10] mtd: nand: omap: fix device scan:
 NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Wed, 23 Oct 2013 12:30:16 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2A049@DBDE04.ent.ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-5-git-send-email-pekon@ti.com>
 <20131022201624.GL23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA29DB8@DBDE04.ent.ti.com>
 <5267690C.9080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48081 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab3JWMbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 08:31:16 -0400
In-Reply-To: <5267690C.9080005@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi Brian,

> From: Brian Norris [mailto:computersforpeace@gmail.com]
> > On 10/22/2013 10:07 PM, Gupta, Pekon wrote:
> >> From: Brian Norris [mailto:computersforpeace@gmail.com]
> >> On Sat, Oct 19, 2013 at 02:14:08PM +0530, Pekon Gupta wrote:

[...]

>> So are you saying that the driver currently doesn't work if you started
>> in x16 buswidth? Are you having problems with a particular setup? What
>> sort of devices are you testing?
>>
...
> Since you didn't answer the other 2 questions there: are you testing any
> x16 devices?
> 

Ans-1: Yes, I'm testing on following boards:
  (a) AM335x-EVM which has x8 Micron device.
  http://www.ti.com/tool/tmdxevm3358
  (b) beaglebone with 'NAND cape', which has x16 Micron device.
  http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
  (c) AM437x board (which has 4K page NAND from Macronix).
  (d) Also would be testing on DRA7xx again having Micron Device.

Ans-2:
Its not the setup but rather constrain in nand_base.c which prevents
reading of ONFI params in x16 mode. Please read below..

Ans-3:
Mostly are either x8 or x16 SLC NAND device.


[...]

> You NEVER need to call nand_scan_ident() twice for the same chip.
> Period. I will reject any patch that retains this pattern. It is wrong,
> and I seriously doubt the code does what you think it does when you do this.
> 
> I think nand_scan_ident() may have a weak point where it won't support
> ONFI properly for x16 devices. I believe NAND_BUSWIDTH_AUTO was added
> to
> help with this fact. (I don't have any x16 devices to test it.) But if
> this is a problem for you, fix it. Don't work around it.
> 
So, here comes the conflict.. 
If I'm _not_ using NAND_BUSWIDTH_AUTO, how should I read the ONFI 
params on x16 device ? I don't think there is any way because of following
code in generic nand_base.c
@@ nand_flash_onfi_detect()
/*
 * ONFI must be probed in 8-bit mode or with NAND_BUSWIDTH_AUTO, not
 * with NAND_BUSWIDTH_16
 */
if (chip->options & NAND_BUSWIDTH_16) {
	pr_err("ONFI cannot be probed in 16-bit mode; aborting\n");
	return 0;
}

Introduced in commit..
commit 0ce82b7f7b7373b16ecf7b5725e21e2975204500
Author:     Matthieu CASTET <matthieu.castet@parrot.com>
AuthorDate: 2013-01-16

And, I think this commit has implicitly made NAND_BUSWIDTH_AUTO
*mandatory* to be supported by every driver for interfacing with
x16 NAND devices. Isn't it ?
(unless you add every x16 device present in market to nand_flash_id[])

 [...]

> nand_base is designed (and it's documented in the comments) that the
> driver must set the buswidth correctly BEFORE calling nand_scan_ident().
> You may not use nand_scan_ident() as a trial-and-error identification
> function.
> 
> So, to properly do (1), you should only have something like this, just
> like all the other NAND drivers:
> 
>   nand_chip->options = pdata->devsize & NAND_BUSWIDTH_16;
> 
>   ret = nand_scan_ident(...);
>   if (ret) {
>       // exit with error code...
>   }
> 
For a x16 device.. This would *always* fail for x16 device, unless device
is listed in nand_flash_id[]. isn't  it ?
because you cannot read ONFI params in x16 mode, and your device is
not listed in nand_flash_ids[], so your device would not get identified.

And I sincerely don't know how other NAND drivers are probing
x16 NAND devices _without_ enabling NAND_BUSWIDTH_AUTO.
(may be by adding every supported NAND device to nand_flash_id[]
look-up table, which is not recommended).


> If there is a problem with this, then you have to fix your driver or
> nand_scan_ident(). Perhaps you have to adjust your readbuf() or
> cmdfunc() callbacks to do this. But do not add complicated workaround
> logic in your driver.
> 
chip->cmdfunc() and chip->readbufs() are all fine. Rather I let the
generic driver set them for nand_scan_ident().
So, all this calling nand_scan_ident() twice was done because of
previously mentioned reasons..


> [snipping the rest]
> 
> I read your patch, and I gave you my review. I will not accept this
> patch, nor any patch that works around nand_scan_ident() by calling it
> twice. Fix the framework if the framework is giving you problems.
> 
It's a chicken and egg problem, 
I have no solution but all I can say is the above commit, which converted
WARNING into ERROR, until all drivers adapt to NAND_BUSWIDTH_AUTO.

Anyway I have to do nand_scan_ident() somewhere before populating
the chip->ecc.layout and other fields.. so can't drop the patch..
But I'll put your suggestion, instead of my mine.

> I believe that this patch is not integral to the rest of the series, so
> I will repeat: separate this patch out so I can take the rest of this
> series without it.
> 
I'll replace the patch with your suggestions,
So, that you have both versions. Please pick whichever you like :-)


with regards, pekon
