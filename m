From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 09 Jan 2013 12:00:05 +0200
Message-ID: <50ED3FA5.9030905@compulab.co.il>
References: <20130109092915.1c2077b5@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:58946 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757554Ab3AIKAL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 05:00:11 -0500
In-Reply-To: <20130109092915.1c2077b5@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Neil,

On 01/09/13 00:29, NeilBrown wrote:
> 
> Hi,
>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
> 
> My current stumbling block is USB.  The "Option" GSM module is attached via
> USB (there is a separate transceiver chip attached to port 1 which is placed
> in OMAP_EHCI_PORT_MODE_PHY).

Which PHY is this (vendor/model)?

> 
> After a suspend/resume cycle with off_mode enabled the GSM module disappears.
> i.e. 'lsusb' doesn't see it any more and the various ttyHSxx devices don't
> exist.
> Without off mode, the modem always appears after resume.
> 
> I discovered that the registers set by:
> 
>    drivers/mfd/omap-usb-host.c
> 
> are not maintained across as suspend/resume so I added the following patch
> (which I can make a formal submission of if it looks right to others), but
> that didn't help (or didn't help enough).
> 
> If I
> 
>   echo 1 > /sys/kernel/debug/pm_debug/usbhost_pwrdm/suspend
> 
> thus keeping just the USBHOST power domain out of off_mode, the GSM module
> doesn't disappear.  So it seems that some context in the usbhost domain is
> not being save and restored.
> 
> This is as far as I can get.  Can someone suggest where I should look to find
> out what is not being saved/restored properly, and how to go about saving and
> restoring?
> 
> Thanks in advance,
> NeilBrown
> 
> 
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 23cec57..522405e 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -100,6 +100,10 @@ struct usbhs_hcd_omap {
>  
>  	void __iomem			*uhh_base;
>  
> +	struct {
> +		unsigned		hostconfig;
> +	} context;
> +
>  	struct usbhs_omap_platform_data	platdata;
>  
>  	u32				usbhs_rev;
> @@ -300,6 +304,10 @@ static int usbhs_runtime_resume(struct device *dev)
>  	clk_enable(omap->utmi_p1_fck);
>  	clk_enable(omap->utmi_p2_fck);
>  
> +	usbhs_write(omap->uhh_base,
> +		    OMAP_UHH_HOSTCONFIG,
> +		    omap->context.hostconfig);
> +
>  	spin_unlock_irqrestore(&omap->lock, flags);
>  
>  	return 0;
> @@ -319,6 +327,8 @@ static int usbhs_runtime_suspend(struct device *dev)
>  	}
>  
>  	spin_lock_irqsave(&omap->lock, flags);
> +	omap->context.hostconfig = usbhs_read(omap->uhh_base,
> +					      OMAP_UHH_HOSTCONFIG);
>  
>  	if (is_ehci_tll_mode(pdata->port_mode[0]))
>  		clk_disable(omap->usbhost_p1_fck);

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQ7T+kAAoJEBDE8YO64Efaj8YQAI5nOE9vvf8wxbu5IXTxaMxn
6B+g2m/zkMlyVNL5hTrwkPkP4CTBwvsGCZYkZT5JS3KM+R+TuyIX07+eM59Ie0Po
u1CCn2XKZY2CP53b3nAtgk9Phxwruf5fDjEu9QiQapdUpbiTWmIn8W3CVye241O2
wXBKAXszX1bD81NFNY+Jm5Us5uGHNTtNtqe78Rng7BTvmaaNgE61PurFclgn0xQb
IO5E7eyq7TG1u/IBhge2jlZGx2BbLcVsrQI3WyuE2L6F+MRgAKBDD7K8uHTfxPyM
eXAk/u5tbA21t1mTIXk19N4c0YVgeFW2kKQOPShKywy9J6k3tE5LE4yUjooo4ZeS
TlIf7HFcp15N3FfX90FOYsQOXILnoNL6a8SOK3gU+iVxZU/4VohKOXBlMjuZ7o10
5FnglPaHjsEaa1DgB/FcnYh3OO33mODJsckUhi5GiIlrbm70JspfWShZfln1k8FS
SwClmyb6FCiqBOcRJ2uS1KTwObzYV9WeuPGCTXC5d4UBB57eRcGcX/NvSftV57mX
jcSEle93kgZx1EiG53Vwd29oV9nU6SJECF7Q8CqulDEQVr76E7Xh8Z1CrsD+BhKe
XuFa3zdtMg1SZO/ctcTIPPpElCVPF1FChX2lY9fCIdK2luHNrOs4GyrozCGXQcXO
ZMFiiStsjr021CGqQUFw
=yIA2
-----END PGP SIGNATURE-----
