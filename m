From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 02/13] USB: phy: nop: Defer probe if device needs
 VCC/RESET
Date: Tue, 5 Feb 2013 11:09:20 +0200
Message-ID: <20130205090920.GH32118@arwen.pp.htv.fi>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-3-git-send-email-rogerq@ti.com>
 <51109E95.3000307@ti.com>
 <5110C655.3060305@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50058 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3BEJJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 04:09:32 -0500
Content-Disposition: inline
In-Reply-To: <5110C655.3060305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon <kishon@ti.com>, tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2013 at 10:44:05AM +0200, Roger Quadros wrote:
> >> diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop=
-usb-xceiv.h
> >> index 3265b61..148d351 100644
> >> --- a/include/linux/usb/nop-usb-xceiv.h
> >> +++ b/include/linux/usb/nop-usb-xceiv.h
> >> @@ -6,6 +6,10 @@
> >>   struct nop_usb_xceiv_platform_data {
> >>       enum usb_phy_type type;
> >>       unsigned long clk_rate;
> >> +
> >> +    /* if set fails with -EPROBE_DEFER if can't get regulator */
> >> +    unsigned int needs_vcc:1;
> >> +    unsigned int needs_reset:1;
> >=20
> > how about u8 here?
>=20
> Not sure. Bitfields are usually defined as unsigned int.

IIRC the benefit is that compiler can try to optimize those flags. I
mean, if you have 32 1-bit flags, compiler will combine those in a
single u32. Someone correct me if I'm wrong.

after you fix other comments from kishon (about of_read_bool()), you can
add my:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREMxAAAoJEIaOsuA1yqREs68P/RLv6FYW3OkX7aJTwckP53+n
yjLZ960pEPAfAqDURLX4IoZNwS+EzRvh0GWKh7A21CoeGtSg0YWhS5YJkE+UnPWx
F4mSvJgMRr5jmAQva8x+gK0Hl4Gw+sTvvo2IQAaCCwBti1wDI5zntfh1QaRJEcPK
ta+L7htNrU82/j/sdIUQYfc3kTJAP15pPLPFWC+klS4G6iobnJR+Svl1ERQYBwsv
4BETAGi+q0cRpXcAK7g4m8NVMnQ35QIQ6yNpVYkH/YzHqrp8X36C5tMHEYFCiX3n
rJt1y4PV62cgdQPcEsPI8HR2Lebvsatqho8JUFfgZa3ElJ/vInzmb4g+uGkC0MJR
GH0Bz4iALAiUdOB2jj+YYOu7cklVdgqu3pDIfbfqWzqZN91+Jbyy0nllII5fWffT
f/9qekz0rZXemEeDG3JCthIu4Co4vTKZ6PH12QC0UTh0B+7PD+mgwy6HSPYAN6VQ
XLev/n9y0Pq7LbcjkJVwxZJMiad0Mevsu9Uq8vd6X5VbUBdaOhq71G0YGBol+6u1
c9Y2o9ymHb7HPJOAJCPLLFW0zSF4wk6fhEPGiKIgBgMqrHrqkC6IE9YAWEu7yH/n
18oDAn6VCe5S4Udef2eRW3AvPonRzPaBgUFrcUiRG4WJc5I/rTJxJW3NPTrql52b
KABTiIGO4lY8GUJdqi1K
=uNZG
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
