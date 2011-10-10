From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3] usb: musb: enable support for am335x
Date: Mon, 10 Oct 2011 10:35:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECB6B707@dbde02.ent.ti.com>
References: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
 <1317031393-9333-3-git-send-email-ajay.gupta@ti.com>
 <4E80582F.6030803@ru.mvista.com>
 <20111007094123.GL10910@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34434 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1JJFFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 01:05:33 -0400
In-Reply-To: <20111007094123.GL10910@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> On Mon, Sep 26, 2011 at 02:47:11PM +0400, Sergei Shtylyov wrote:
> > Hello.
> >
> > On 26-09-2011 14:03, Ajay Kumar Gupta wrote:
> >
> > >Enabled the flag so that musb_dsps glue file can be used for am335x
> >
> > >Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
> > >---
> > >  drivers/usb/musb/Kconfig |    6 +++---
> > >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > >diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > >index d6abdec..4e21aee 100644
> > >--- a/drivers/usb/musb/Kconfig
> > >+++ b/drivers/usb/musb/Kconfig
> > >@@ -8,7 +8,7 @@ config USB_MUSB_HDRC
> > >  	depends on USB&&  USB_GADGET
> > >  	depends on (ARM || (BF54x&&  !BF544) || (BF52x&&  !BF522&&
> !BF523))
> > >  	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM ||
> BLACKFIN)
> > >-	select NOP_USB_XCEIV if SOC_OMAPTI81XX
> > >+	select NOP_USB_XCEIV if (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
> > >  	select TWL4030_USB if MACH_OMAP_3430SDP
> > >  	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
> > >  	select USB_OTG_UTILS
> > >@@ -57,7 +57,7 @@ config USB_MUSB_AM35X
> > >
> > >  config USB_MUSB_DSPS
> > >  	tristate "TI DSPS platforms"
> > >-	depends on SOC_OMAPTI81XX
> > >+	depends on (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
> >
> >    Parens not needed here and above.
> 
> are we getting a revised version ?

Yes, I will send the revised version with earlier set fixing your
comment.

Thanks,
Ajay
> 
> --
> balbi
