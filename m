From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
Date: Tue, 15 Dec 2009 00:08:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912150002370.12561@utopia.booyaka.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com> <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com> <alpine.DEB.2.00.0911300141440.17083@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC35608702FA90250A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0912010904590.13408@utopia.booyaka.com> <74583B8642AB8841B30447520659FCA9DE54DA68@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1070891597-1260860691=:12561"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57083 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbZLOHIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 02:08:13 -0500
In-Reply-To: <74583B8642AB8841B30447520659FCA9DE54DA68@dnce01.ent.ti.com>
Content-ID: <alpine.DEB.2.00.0912150005130.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "ext-ari.kauppi@nokia.com" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Menon, Nishanth" <nm@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1070891597-1260860691=:12561
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.0912150005131.12561@utopia.booyaka.com>

Hi Beno=EEt, Vishwanath,

Thanks for the info, Beno=EEt.

On Fri, 11 Dec 2009, Cousson, Benoit wrote:

> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >owner@vger.kernel.org] On Behalf Of Paul Walmsley
> >Sent: Thursday, December 10, 2009 10:24 PM
> >
> >Hi Vishwanath,
> >
> >On Tue, 1 Dec 2009, Sripathy, Vishwanath wrote:
> >
> >> >
> Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loub=
et. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>=20
> -----Original Message-----
>=20
> >> > From: Paul Walmsley [mailto:paul@pwsan.com]
> >> > Sent: Monday, November 30, 2009 3:00 PM
> >> > To: Sripathy, Vishwanath
> >> > Cc: ext-ari.kauppi@nokia.com; linux-omap@vger.kernel.org; Woodruff,
> >Richard;
> >> > Menon, Nishanth
> >> > Subject: Re: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
> >> >
> >> > Hello Vishwanath,
> >> >
> >> > a few comments:
> >> >
> >> > On Thu, 26 Nov 2009, Vishwanath BS wrote:
> >> >
> >> > > From: Richard Woodruff <r-woodruff2@ti.com>
> >> > >
> >> > > DPLL4 for 3630 introduces a changed block requiring special diviso=
r
> >bits and
> >> > > additional reg fields. To allow for silicons to use this, this is
> >introduced
> >> > > as a omap3_has_jtype_dpll4() and is enabled for 3630 silicon
> >> > >
> >> > > Tested with 3630 ZOOM3
> >> >
> >> > Could you please consider Ari Kauppi's suggestions that he posted on
> >> > 30 and 31 October?  They look good to me.  Here is a link:
> >> >
> >> Regarding comments from Ari Kauppi on addition of dco_sel_mask and
> >> sd_div_mask, yes I had a look at them. However I feel, it's better to
> >> have these masks in the structure variable. Reason being this approach
> >> will help us to support when dpll types for other dplls get changed in
> >> future. For example, if dpll3 block is changed, then having new mask
> >> will help us to support it.
> >
> >Is there a product coming out that will add more j-type DPLLs with
> >different dco_sel_masks and sd_div_masks?  If not, then let's go with
> >Ari's suggested changes, since we don't really know if any more of these
> >j-type DPLLs will be used.  We can always add the fields back in when we
> >need them.  But if you know for sure that there is a chip variant coming
> >out soon that will use more j-type DPLLs, let's talk about it.
>=20
> OMAP4 is using the same J-type for the DPLL_USB. The programming model=20
> is "almost" the same... sd_div is a the same location, but dco_sel is=20
> not there anymore because that DPLL will always be locked at 960MHz and=
=20
> thus will not require the mode for frequency > 1GHz. At the DCO=20
> location, we have the bypass_clksel, so the code will have to take care=
=20
> of that.
>=20
> 31:24 DPLL_SD_DIV
> 23    DPLL_BYP_CLKSEL
> 19:8  DPLL_MULT
> 7:0   DPLL_DIV

Vishwanath, it sounds like it makes sense to hardcode the DPLL_SD_DIV and=
=20
DCO_SEL shifts, since, so far, when present, they are always at the same=20
offset.  Instead of using a 'u8 jtype;' it seems to make sense to have a=20
'u8 flags' and have at least two flags there: DPLL_J_TYPE and=20
DPLL_NO_DCO_SEL.  (The latter flag would skip any DCO_SEL reads/writes for=
=20
J-type DPLLs if it is set, so it will be usable for OMAP4.  The code=20
should also warn if DPLL_NO_DCO_SEL is set and DPLL_J_TYPE is not set.)

Sound reasonable?


- Paul
--155748971-1070891597-1260860691=:12561--
