From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
Date: Fri, 31 Aug 2012 11:27:23 +0300
Message-ID: <1346401643.32389.4.camel@deskari>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
	  <1346230576-20004-3-git-send-email-rnayak@ti.com>
	  <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
	  <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
	  <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com>
	 <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-yG42V7maWBYk7DJ7y4Ho"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53317 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750935Ab2HaI1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 04:27:33 -0400
Received: by lbbgj3 with SMTP id gj3so1056080lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 01:27:30 -0700 (PDT)
In-Reply-To: <504073CF.6010804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>


--=-yG42V7maWBYk7DJ7y4Ho
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-31 at 13:50 +0530, Archit Taneja wrote:
> On Friday 31 August 2012 12:45 PM, Tomi Valkeinen wrote:
> > On Fri, 2012-08-31 at 11:53 +0530, Archit Taneja wrote:
> >
> >> The only little problem was that during bootup, when hwmods are setup,
> >> only the 'parent' hwmod was able to get reset properly, all the other
> >> 'child' hwmods don't have modulemode bits tied to them, and hence
> >> weren't able to reset. So we got some error prints.
> >>
> >> Once DSS driver kicks in, the driver ensures the parent is enabled for
> >> any child to be enabled, so we don't face the issue again.
> >>
> >> So, if DSS driver is not built in, and if the bootloader left DSS in a
> >> bad state, the DSS clocks might remain messed up all the time since
> >> hwmod fwk wasn't able to reset them.
> >>
> >> I think this is why we didn't proceed with remove "dss_fck" as a slave
> >> clock. If this issue is minor, we could go ahead and remove it.
> >
> > I wonder if we could handle this with a custom reset function. We
> > already have a reset func for dss core. If I remember right, the main
> > point for that is the fact that omap4 doesn't have a softreset for dss
> > core, so we manually write the default values to registers.
> >
> > For omap2/3 this would be simple: skip the resets for all other dss
> > submodules, and dss core's reset would enable all the clocks and set th=
e
> > softreset bit. This would reset all the submodules also.
> >
> > Omap4 is more tricky. I guess we'd need to enable all the clocks, clear
> > manually dss core's registers, and then set softreset bits in all the
> > submodules. So in this case dss core would need to have information
> > about the other submodules.
>=20
> The is a good idea. I don't clearly understand your approach though. Are=
=20
> you saying we have a custom reset function for only dss core? And reset=
=20
> the submodules in it manually?

Yes.

> An alternative approach would be to implement custom reset functions for=
=20
> each submodule(or each hwmod), and in the beginning of every reset=20
> function, add a hack to enable MODULEMODE bits(since we don't want hwmod=
=20
> fwk to touch MODULEMODE for the DSS submodules), and then set the soft=
=20
> reset bits.

I thought about that also. We'd need reset functions for all of them,
and for omap2/3 we'd just reset the submodules again as they have
already been reset with the dss core reset.

The dss submodule resets are a bit linked. For omap2/3 the connection is
obvious as dss core reset resets also the submodules, and for omap4 we
have this requirement for the modulemode. That's why I though it'd be
perhaps cleaner to handle the reset of the DSS block as a whole, in one
place.

> Your approach would ensure that we get a clean reset of DSS, but it=20
> would still give the annoying prints when each of the submodule tries to=
=20
> reset itself.

The other submodules would not be reset by the hwmod framework at all,
so there wouldn't be prints. I think there's a flag for that.

 Tomi


--=-yG42V7maWBYk7DJ7y4Ho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQHVrAAoJEPo9qoy8lh71NkMP/2scs2eYtrPKJ7OTObM3r5ri
odoGUpGxYMnVy0sXdILl/XB4VAbLQA90kjeEdYreMvSB5RDS/Cq4Q6SrUnwGAiTC
WJswQvhhBKuRg1vs+BvXA520KRrRR0SYYEOqlF0FsnV7QbRy524T27IA/a3LCb/d
MzIlVxsqPKoX/TJyCmwgPFNtQGAabPqkiDWfKMhAXrhkA4Lzef5HWPuTssvwHoTI
M6mJipPnAcSQMb2vOOt9l5oMtgjaMl0p8oNBYnOPpyDYfLEun0Eof1od+xjalNTl
9rHrVR5a0gtg08H46h4n/AEE5Q9rASpBl6Ul3cx1PZ9yVFkF8+xfUJwqXy+AmZIY
52krDPAGmxRcV8mGu5XeZRbGBdvhAi+w8WLfuQUGdnrggErQRkjiWzmZO9rUoAr+
gYVWE7XrZzJPwhMTgLQO/ezpnl4cIM6ZBFizR+5inZSWUeTEKPnMxBuhhDRQhtuz
OURDrjEoKrtYDYZPlPJTtIZOGfCV3M6IBHcgYri1LbIWzinG/l8dAopER3gHlhXu
94i/Njny2Y/AFcQSiiS7N9y2IcY1Gc8qJ6ZdrXgxsGJRqPa5OFxWG2OMMumZWR7+
PXHC6VU9XHjTb5nlj0RYDqgFK2BorsbjgKQ9jY+xwh2eLgrY0A/7ygf1ldG4/X/E
NtNNOlX1FZcku1Tk4f5/
=1BGG
-----END PGP SIGNATURE-----

--=-yG42V7maWBYk7DJ7y4Ho--

