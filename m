From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
Date: Tue, 11 Mar 2014 12:02:59 +0000
Message-ID: <20140311120259.GI21216@lee--X1>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <531ECDCB.4060700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <531ECDCB.4060700-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> > Hi,
> >=20
> > This patchset brings up USB Host ports and Ethernet port on
> > the OMAP5 uEVM board.
> >=20
> > It also does some cleanup with respect to DT clock binding
> > for the mfd/omap-usb-host driver.
> >=20
> > Please queue these for -next.
> >=20
> > Lee,
> >=20
> > I've folded some platform data dependent patches with mfd patches
> > so that they don't break functionality when applied individually.
> > You can safely pull in all MFD patches (1 to 6).
> >=20
> > Tony & Benoit,
> >=20
> > Can you please accept patches 7, 8 and 9?
>=20
> Tony has already picked up 7,8 and 9 through omap-soc tree.
>=20
> Since you acked most patches except 5 and 6, are you fine if Tony tak=
es
> all the patches 1 to 4 in this series via omap-soc tree?
>=20
> What about patches 5 and 6?

Any patches which are orthogonal can just be sucked into whichever tree
they belong in. If there are inter-subsystem dependencies I'd prefer
to take them and issue a immutable branch pull-request to the other
maintainers.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
