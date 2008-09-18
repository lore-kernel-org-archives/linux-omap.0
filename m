From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: OMAP support in mainline?
Date: Thu, 18 Sep 2008 12:55:37 +0300
Message-ID: <20080918095537.GD28615@gandalf.research.nokia.com>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com> <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61626 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYIRJ43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 05:56:29 -0400
Content-Disposition: inline
In-Reply-To: <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Wed, Sep 17, 2008 at 03:23:49PM +0200, ext Koen Kooi wrote:
>
> Op 17 sep 2008, om 14:24 heeft Steve Sakoman het volgende geschreven:
>
>> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi <k.kooi@student.utwente.nl> 
>> wrote:
>>
>>> And they aren't working too well with current l-o git either with MUSB 
>>> being
>>> broken. There's a patch to fix client mode, but host mode still isn't
>>> working.
>>
>> Host mode musb is working just fine on Overo with the "set
>> transceiver" patch.  Not sure why you are having trouble with Beagle
>> (and can't check since I don't have my Beagle board with me at the
>> moment)
>
> I should clarify: OTG mode with a host cable doesn't work in .27rc, it does 
> work in 2.6.26. I haven't tried specifying pure hostmode, only OTG.
> I would try it on the evm as well, but that is having serious irq issues 
> with .27rc, pressing a key on the keypad triggers an irq overrun, ethernet 
> gives an oops on boot when trying to register and irq etc,etc. 2.6.27 is 
> looking really, really bad on omap3 at the moment.

Yeah, we lost some musb history when it went to mainline. I didn't test
this patch yet cuz I've been quite busy at work, but it should make
beagle work. Could you tell me if makes it work ?

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 9d2dcb1..f7fe91e 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, u8 musb_mode)

 int __init musb_platform_init(struct musb *musb)
 {
+       struct otg_transceiver *xceiv = otg_get_transceiver();
        u32 l;

 #if defined(CONFIG_ARCH_OMAP2430)
        omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif

+       memcpy(musb->xceiv, xceiv, sizeof(*xceiv));
        musb_platform_resume(musb);

        l = omap_readl(OTG_SYSCONFIG);


-- 
balbi
