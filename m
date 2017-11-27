From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: EHCI and MUSB do not discover devices without CONFIG_PM
Date: Mon, 27 Nov 2017 23:08:33 +0100
Message-ID: <20171127220833.GA10070@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi there,

USB hosts do not discover any connected device on OMAP3 based board
with CONFIG_PM=n. Just enabling this option is enough to restore working
behaviour. Nothing unusual in log. Tested 4.14.2 and 4.15-rc1. I know
a lot of stuff depends on CONFIG_PM, but is this expected behaviour?
Neither EHCI nor MUSB is working without CONFIG_PM.

Thank you,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
