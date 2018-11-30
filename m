From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Fri, 30 Nov 2018 13:17:35 +0100
Message-ID: <20181130131605.3cfea95d@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
        <20181110203115.13335-3-andreas@kemnade.info>
        <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
        <20181130071534.0a6cd455@kemnade.info>
        <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
        <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
        <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
        <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JKSN_9Gh0a7D/smCt=_oENr"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Stephen Boyd <sboyd@kernel.org>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

--Sig_/JKSN_9Gh0a7D/smCt=_oENr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tero,

On Fri, 30 Nov 2018 11:20:49 +0200
Tero Kristo <t-kristo@ti.com> wrote:

> On 30/11/2018 09:57, Stephen Boyd wrote:
> > Quoting Tero Kristo (2018-11-29 23:35:35) =20
> >> On 30/11/2018 09:20, Stephen Boyd wrote: =20
> >>> Quoting Andreas Kemnade (2018-11-29 22:15:34) =20
> >>>> Hi Stephen,
> >>>>
> >>>> On Thu, 29 Nov 2018 16:25:05 -0800
> >>>> Stephen Boyd <sboyd@kernel.org> wrote:
> >>>> =20
> >>>>> Quoting Andreas Kemnade (2018-11-10 12:31:14) =20
> >>>>>> Code might use autoidle api with clocks not being omap2 clocks,
> >>>>>> so check if clock type is not basic
> >>>>>>
> >>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>>>> ---
> >>>>>> New in v2
> >>>>>> ---
> >>>>>>    drivers/clk/ti/autoidle.c | 12 ++++++++++--
> >>>>>>    1 file changed, 10 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> >>>>>> index 161f67850393..5bdae5552d38 100644
> >>>>>> --- a/drivers/clk/ti/autoidle.c
> >>>>>> +++ b/drivers/clk/ti/autoidle.c
> >>>>>> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> >>>>>>    int omap2_clk_deny_idle(struct clk *clk)
> >>>>>>    {
> >>>>>>           struct clk_hw_omap *c;
> >>>>>> +       struct clk_hw *hw =3D __clk_get_hw(clk);
> >>>>>>   =20
> >>>>>> -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> >>>>>> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC) =20
> >>>>>
> >>>>> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> >>>>> Maybe add some flag in clk_hw_omap() instead?
> >>>>> =20
> >>>> hmm, Tero suggested that.
> >>>> But to check flags in clk_hw_omap I first need to know that there is=
 a
> >>>> clk_hw_omap behind clk_hw. And for that I either need to check flags=
 in
> >>>> clk_hw or do more changes in the omap_hwmod code. =20
> >>>
> >>> Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
> >>> other users are marking clks with this but there is no reason to do s=
o.
> >>> I'll go make another pass over the tree and nuke those ones from orbi=
t. =20
> >>
> >> The reason for using this flag is because OMAP uses two clock types
> >> around, the basic clocks like fixed-factor-clock/fixed-clock, and then
> >> all the omap derivatives, which can be cast to clk_hw_omap. If we want
> >> to avoid usage of CLK_IS_BASIC, we need to copy paste the remaining
> >> basic code under drivers/clk/ti/ and convert them to use clk_hw_omap as
> >> internal datatype. Is this preferred?
> >> =20
> >=20
> > No that is not preferred. Can the omap2_clk_deny_idle() function be
> > integrated closer into the clk framework in some way that allows it to
> > be part of the clk_ops structure? And then have that take a clk_hw
> > structure instead of a struct clk? I haven't looked at this in any
> > detail whatsoever so I may be way off right now. =20
>=20
> It could be added under the main clk_ops struct, however this would=20
> introduce two new func pointers to it which are not used by anything=20
> else but OMAP. Are you aware of any other platforms requiring similar=20
> feature?

The question here is also how we organize the procedure here. One patchset
fixing nasty problems and another mainly reorganize things? Where do we draw
the line between these two? If we have the autoidle code in main clk_ops,
we could also think whether other autoidle code should go into main code.

Regards,
Andreas

--Sig_/JKSN_9Gh0a7D/smCt=_oENr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwBKmAACgkQfb1qx03i
kyTFZQ/+LYhOeqMel2/sNR00lIM0IYRz/c8g1rgfQUwGXeZ7p1OR88GDdYPlt3Ts
7Uhi3oZvmCLVWrcfTR42Yfao/o/NsKRXm4IwDvi65dZYPn0IsY69OWwAx8BLtSs7
TU4AWmKA6J6ODc4Rsu5KMnmDuLEVE8RxUtwa5jOCZvR0Dbk8Wm0yQBVEUGHhEskq
8h+Vn50lipd9cKZmWNoDFeGNroC7UtRSjS7kodOE0EfzbXlsBb9pBg/wz3Y+WTwl
a2W75OZklZRhKP7Q/wtHyL6cFeIDDzKuMYfgTm123ClfX9DKmx3RqqppzV0MY1VS
I2NkCsHjNu/V2jU1rItuBP0qQeq7T7AQ47Nwn3Xr09EF1L8W2scrjzm/DCuWufdh
xMt5mCyZJLeQfP2vZJzoo3yfLZL6ErP1Nn2aEPpXXgTsXpN7Q0i3YEHISXifi49b
tq0uk3QHdMsslhTX1/zeq5WNoHgTtG9uud5lWFHhP+pu6NYN6kNNeG7Dh06bTBUF
PL196EXXvdva1g6GMD2ButQVP0NfO0cvlkLh70cL33yQnloV8xlR93BjMtzkHsIK
8N5CGu9df9EK6/o97sFlMpZYT9qKvskipS0uvnWXRRvNvIJGlwJWOso6IVsoC3SJ
u6lharSA3uOWKJXDKiRrME/W5Erfa/9hb0GTXy/SQ/KX3Wu3nek=
=2g9z
-----END PGP SIGNATURE-----

--Sig_/JKSN_9Gh0a7D/smCt=_oENr--
