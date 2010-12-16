From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 4/5] OMAP: mailbox: build device using
	omap_device/omap_hwmod
Date: Thu, 16 Dec 2010 08:44:46 +0000
Message-ID: <20101216084446.GB10883@n2100.arm.linux.org.uk>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com> <1292482079-2226-5-git-send-email-omar.ramirez@ti.com> <AANLkTik4K3LEovr-wJiv_PG+ivHNj8hxPT7QPua-ytVf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55625 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0LPIpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 03:45:11 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik4K3LEovr-wJiv_PG+ivHNj8hxPT7QPua-ytVf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 16, 2010 at 02:08:11PM +0530, Varadarajan, Charulatha wrote=
:
> > + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("mailbox");
> > + =A0 =A0 =A0 if (!oh) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to find hwmod\n", =
__func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 od =3D omap_device_build("omap-mailbox", -1, oh,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_latencies, ARRAY=
_SIZE(mbox_latencies),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0);
> > + =A0 =A0 =A0 if (!od) {
>=20
> Check for IS_ERR(od).
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: could not build device\n"=
, __func__);

If you have an API which returns errors, and you're bothering to print
something when an error occurs, it's often useful to print the returned
error code, so that people can find out _why_ the error occurred.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
