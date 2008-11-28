From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] musb: Remvoing twl4030 dependency for OMAP3EVM MUSB
Date: Thu, 27 Nov 2008 23:02:43 -0800
Message-ID: <200811272302.43295.david-b@pacbell.net>
References: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:20083 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751970AbYK1HCp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 02:02:45 -0500
In-Reply-To: <1227850104-16166-1-git-send-email-mani.pillai@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Thursday 27 November 2008, Manikandan Pillai wrote:
> =A0#if defined(CONFIG_ARCH_OMAP2430)
> =A0=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(AE5_2430_USB0HS_STP);
> +=A0=A0=A0=A0=A0=A0=A0x =3D otg_get_transceiver();
> +#elif defined(CONFIG_MACH_OMAP3EVM)
> +=A0=A0=A0=A0=A0=A0=A0x =3D kzalloc(sizeof *x, GFP_KERNEL);
> +=A0=A0=A0=A0=A0=A0=A0if (!x)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +=A0=A0=A0=A0=A0=A0=A0x->set_host =3D omap3_evm_otg_set_host;
> +=A0=A0=A0=A0=A0=A0=A0x->set_peripheral =3D omap3_evm_otg_set_periphe=
ral;
> +=A0=A0=A0=A0=A0=A0=A0x->set_suspend =3D omap3_evm_otg_set_suspend;
> +=A0=A0=A0=A0=A0=A0=A0otg_set_transceiver(x);
> =A0#endif

This is obviously wrong.  One does set_transceiver(),
the other does get_transceiver() ...=20

It seems that some boards need some kind of basic
OTG transceiver stub.  The newish drivers/usb/otg
directory is the place to keep such stuff.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
