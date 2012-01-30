From: Marc Butler <marc@plastictigers.com>
Subject: Re: How do I get slimbus hwmod information?
Date: Mon, 30 Jan 2012 15:11:32 -0500
Message-ID: <20120130201132.GB6332@plastictigers.com>
References: <20120105004503.GA4650@plastictigers.com>
 <alpine.DEB.2.00.1201251239150.5324@utopia.booyaka.com>
Reply-To: marc@plastictigers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li158-162.members.linode.com ([173.230.148.162]:58734 "EHLO
	plastictigers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab2A3ULd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 15:11:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201251239150.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, gclemson@audience.com

On Wed, Jan 25, 2012 at 12:46:50PM -0700, Paul Walmsley wrote:
> sorry for the delay, just caught this during a list sweep.  The maint=
ainer=20
> of the OMAP4 hwmod data is Beno=EEt, so I'd suggest cc'ing him for OM=
AP4=20
> hwmod data requests.

No worries and thanks for the reply.

> On Wed, 4 Jan 2012, Marc Butler wrote:
> > Currently omap_hwmod_44xx_data.c has slimbus1/slimbus2 included in =
the
> > list of excluded IPs.
> >=20
> > Is it possible to get a version of omap_hwmod_44xx_data.c generated
> > with slimbus1/2 included?=20
>=20
> A good starting point is included below.

Thank you.

> > I am concerned that I do not understand how the pieces for such a
> > driver should be put together: should such a driver be built from t=
he
> > ground up with hwmod interfaces, or should they be added in as the
> > driver stabilizes?
>=20
> The driver shouldn't have any hwmod code in it.  Any=20
> omap_device/omap_hwmod code that's needed should go into an appropria=
te=20
> file in arch/arm/mach-omap2.  The device resource metadata will flow=20
> through the existing Linux resource system.  Also, currently we are u=
sing=20
> the pm_runtime*() calls as the way to interface with the=20
> omap_hwmod/omap_device enable/idle code, so your driver should be wri=
tten=20
> using those.

I believe I came to the conclusion that I need the hwmod support,
inorder to build out the platform_* infrastructure the driver needs,
to query/configure resources. The driver itself does not call hwmod
directly.

A colleague is looking into this, and we are unclear what should be
done in the case where you can choose alternate muxing of the pins?
=46or instance slimbus2 module can be routed two distinct pads. Should
this be handled in an appropriate board_*.c?

-m
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
