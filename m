From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
Date: Fri, 9 Mar 2012 10:26:10 -0800
Message-ID: <20120309182609.GG12083@atomide.com>
References: <20120308204328.GW12083@atomide.com>
 <20120308204607.GX12083@atomide.com>
 <1331280718.1927.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26073 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab2CIS0M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 13:26:12 -0500
Content-Disposition: inline
In-Reply-To: <1331280718.1927.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120309 00:14]:
> On Thu, 2012-03-08 at 12:46 -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120308 12:11]:
> > > Otherwise we will get:
> > >=20
> > > arch/arm/plat-omap/fb.c:101: error: expected =E2=80=98)=E2=80=99 =
before =E2=80=98*=E2=80=99 token
> > >=20
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >=20
> > > ---
> > >=20
> > > Tomi, you need something like this for what you have in for-next.
> > >=20
> > > --- a/arch/arm/plat-omap/fb.c
> > > +++ b/arch/arm/plat-omap/fb.c
> > > @@ -98,6 +98,8 @@ arch_initcall(omap_init_fb);
> > > =20
> > >  #else
> > > =20
> > > -void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
> > > +void __init omapfb_set_lcd_config(const struct omap_lcd_config *=
config)
> > > +{
> > > +}
> > > =20
> > >  #endif
> >=20
> > Also now seeing the following with what you have in for-next:
> >=20
> > drivers/video/omap2/displays/panel-taal.c: In function =E2=80=98taa=
l_num_errors_show=E2=80=99:
> > drivers/video/omap2/displays/panel-taal.c:605: warning: =E2=80=98er=
rors=E2=80=99 may be used uninitialized in this function
>=20
> Hmm, my compiler doesn't complain (codesourcery 2010.09-50), so I did=
n't
> notice that. Which compiler version reports the warning?
>=20
> I'm not 100% sure, but I think it's a false warning, the code path th=
at
> uses "errors" should only be ran when "errors" has been set.

This seems to depend on the .config options somehow. Not getting
it with omap2plus_defconfig, but getting it at least with Russell's
omap4430-sdp seed config from:

http://www.arm.linux.org.uk/developer/build/

Using now emdebian 4.3.5-4 as there seems to be some issues
showing all the section warnings with CodeSourcery and Linaro
toolchains.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
