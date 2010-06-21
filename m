From: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Subject: Re: [PATCH] OMAP FB code to set DISPC_TIMING_{H,V} doesn't match
 TRM
Date: Mon, 21 Jun 2010 17:31:23 -0400
Message-ID: <20100621213123.GQ1248@gibbs.hungrycats.org>
References: <20100616214340.GA27198@gibbs.hungrycats.org>
 <AANLkTinaUy_aPsEZIUUFFSgUdn1RmyAOKRPOop9AfSqL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:49065 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758322Ab0FUVbd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 17:31:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinaUy_aPsEZIUUFFSgUdn1RmyAOKRPOop9AfSqL@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

On Mon, Jun 21, 2010 at 04:34:33PM +0300, Grazvydas Ignotas wrote:
> (CC Tomi)
>=20
> On Thu, Jun 17, 2010 at 12:43 AM, Zygo Blaxell
> <vger-linux-omap-esightcorp@mailtoo.hungrycats.org> wrote:
> > The TRM and the OMAP FB driver have different ideas about the width=
s
> > of various bit fields in the DISPC_TIMING_{H,V} registers. =A0This =
patch
> > is based on what the TRM (TI document SPRUF98G) says.
> >
> > Note: =A0this patch changes the meanings of the vertical timing val=
ues
> > by one scan line. =A0It still works with my display, but it might b=
reak
> > things for other people.
>=20
> Why? The TRM doesn't say VFP, VBP have to be programmed with value -1=
=2E

Hmmm...that's correct.  Only VSW in DISPC_TIMING_V needs -1.  Sorry,
my bad.

On the other hand, I've since found the equivalent code in the DSS driv=
er,
and it looks like this:

        if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
                timing_h =3D FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, =
8) |
                        FLD_VAL(hbp-1, 27, 20);

                timing_v =3D FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8)=
 |
                        FLD_VAL(vbp, 27, 20);
        } else {
                timing_h =3D FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, =
8) |
                        FLD_VAL(hbp-1, 31, 20);

                timing_v =3D FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8)=
 |
                        FLD_VAL(vbp, 31, 20);
        }

so it would seem that the wider field widths are only available on
newer hardware than the old omapfb code was intended to support?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
