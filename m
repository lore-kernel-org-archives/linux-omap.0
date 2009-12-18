From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
Date: Fri, 18 Dec 2009 17:20:34 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FFDF3045@dbde02.ent.ti.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.0911300141440.17083@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA90250A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0912010904590.13408@utopia.booyaka.com>
 <74583B8642AB8841B30447520659FCA9DE54DA68@dnce01.ent.ti.com>
 <alpine.DEB.2.00.0912150002370.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59928 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbZLRLuo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 06:50:44 -0500
In-Reply-To: <alpine.DEB.2.00.0912150002370.12561@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "ext-ari.kauppi@nokia.com" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Menon, Nishanth" <nm@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, December 15, 2009 12:38 PM
> To: Cousson, Benoit
> Cc: Sripathy, Vishwanath; Nayak, Rajendra; ext-ari.kauppi@nokia.com; =
linux-
> omap@vger.kernel.org; Woodruff, Richard; Menon, Nishanth
> Subject: RE: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
>=20
> Hi Beno=EEt, Vishwanath,
>=20
> Thanks for the info, Beno=EEt.
>=20
> On Fri, 11 Dec 2009, Cousson, Benoit wrote:
>=20
> > >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > >owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > >Sent: Thursday, December 10, 2009 10:24 PM
> > >
> > >Hi Vishwanath,
> > >
> > >On Tue, 1 Dec 2009, Sripathy, Vishwanath wrote:
> > >
> > >> >
> > Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuv=
e Loubet.
> 036 420 040 R.C.S Antibes. Capital de EUR 753.920
> >
> > -----Original Message-----
> >
> > >> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > >> > Sent: Monday, November 30, 2009 3:00 PM
> > >> > To: Sripathy, Vishwanath
> > >> > Cc: ext-ari.kauppi@nokia.com; linux-omap@vger.kernel.org; Wood=
ruff,
> > >Richard;
> > >> > Menon, Nishanth
> > >> > Subject: Re: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
> > >> >
> > >> > Hello Vishwanath,
> > >> >
> > >> > a few comments:
> > >> >
> > >> > On Thu, 26 Nov 2009, Vishwanath BS wrote:
> > >> >
> > >> > > From: Richard Woodruff <r-woodruff2@ti.com>
> > >> > >
> > >> > > DPLL4 for 3630 introduces a changed block requiring special =
divisor
> > >bits and
> > >> > > additional reg fields. To allow for silicons to use this, th=
is is
> > >introduced
> > >> > > as a omap3_has_jtype_dpll4() and is enabled for 3630 silicon
> > >> > >
> > >> > > Tested with 3630 ZOOM3
> > >> >
> > >> > Could you please consider Ari Kauppi's suggestions that he pos=
ted on
> > >> > 30 and 31 October?  They look good to me.  Here is a link:
> > >> >
> > >> Regarding comments from Ari Kauppi on addition of dco_sel_mask a=
nd
> > >> sd_div_mask, yes I had a look at them. However I feel, it's bett=
er to
> > >> have these masks in the structure variable. Reason being this ap=
proach
> > >> will help us to support when dpll types for other dplls get chan=
ged in
> > >> future. For example, if dpll3 block is changed, then having new =
mask
> > >> will help us to support it.
> > >
> > >Is there a product coming out that will add more j-type DPLLs with
> > >different dco_sel_masks and sd_div_masks?  If not, then let's go w=
ith
> > >Ari's suggested changes, since we don't really know if any more of=
 these
> > >j-type DPLLs will be used.  We can always add the fields back in w=
hen we
> > >need them.  But if you know for sure that there is a chip variant =
coming
> > >out soon that will use more j-type DPLLs, let's talk about it.
> >
> > OMAP4 is using the same J-type for the DPLL_USB. The programming mo=
del
> > is "almost" the same... sd_div is a the same location, but dco_sel =
is
> > not there anymore because that DPLL will always be locked at 960MHz=
 and
> > thus will not require the mode for frequency > 1GHz. At the DCO
> > location, we have the bypass_clksel, so the code will have to take =
care
> > of that.
> >
> > 31:24 DPLL_SD_DIV
> > 23    DPLL_BYP_CLKSEL
> > 19:8  DPLL_MULT
> > 7:0   DPLL_DIV
>=20
> Vishwanath, it sounds like it makes sense to hardcode the DPLL_SD_DIV=
 and
> DCO_SEL shifts, since, so far, when present, they are always at the s=
ame
> offset.  Instead of using a 'u8 jtype;' it seems to make sense to hav=
e a
> 'u8 flags' and have at least two flags there: DPLL_J_TYPE and
> DPLL_NO_DCO_SEL.  (The latter flag would skip any DCO_SEL reads/write=
s for
> J-type DPLLs if it is set, so it will be usable for OMAP4.  The code
> should also warn if DPLL_NO_DCO_SEL is set and DPLL_J_TYPE is not set=
=2E)
>=20
> Sound reasonable?
>=20
>=20

Make sense. I will post new set of patches after incorporating all thes=
e.=20
Thanks.=20
> - Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
