From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/11] ARM: DRA7: hwmod: Add data for
 McASP1/2/4/5/6/7/8
Date: Tue, 1 Mar 2016 17:01:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com> <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com> <56D5C6B1.6040005@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-543039208-1456851538=:14948"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D5C6B1.6040005@ti.com>
Content-ID: <alpine.DEB.2.02.1603011659040.14948@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, robh+dt@kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-543039208-1456851538=:14948
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1603011659041.14948@utopia.booyaka.com>

Hi P=E9ter,

On Tue, 1 Mar 2016, Peter Ujfalusi wrote:

> Hi Paul,
>=20
> On 03/01/2016 11:11 AM, Paul Walmsley wrote:
> > Hi P=E9ter
> >=20
> > A few questions:
> >=20
> > On Thu, 25 Feb 2016, Peter Ujfalusi wrote:
> >=20
> >> Add missing data for all McASP ports for the dra7 family
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >=20
> > 1. The patch doesn't set the HWMOD_OPT_CLKS_NEEDED flag for McASP1 and =
2,=20
> > but does set it for McASP4-8.  Could you please confirm that this is=20
> > intentional, and if so, why?
>=20
> All should have the HWMOD_OPT_CLKS_NEEDED as both fclk and ahclkx is trea=
ted
> as functional clock and needs to be available in order to be able to acce=
ss
> McASP registers.
> Sorry, I can only test McASP3 and somehow I overlooked this when copy-pas=
ting
> the data.

OK

> > 2. The patch sets HWMOD_SWSUP_SIDLE for McASP1 and 2, but doesn't set i=
t=20
> > for McASP4-8.  Could you please confirm that this is intentional, and i=
f=20
> > so, why?  The descriptions of the MODULEMODE fields in SPRUHZ6 look=20
> > identical.
>=20
> I need to confirm this, but all McASP should have the same set of flags.

OK.  Looking at McASP3 data this morning, they probably shouldn't need=20
HWMOD_SWSUP_SIDLE, but probably all need=20

                        .modulemode   =3D MODULEMODE_SWCTRL,

> > 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should be=
=20
> > "dra7xx_mcasp1__l3_main_1"-style links to indicate this.
>=20
> I need to check this, but I don't think McASP1,2,3 can be bus-master onto=
 L3.

OK.  When you get back, maybe doublecheck this - it looks to me from=20
SPRUHZ6 that McASP1-3 have built-in DMA controllers.

> I can resend the series next week as I'm out of office this week.

That's fine.  It's most likely v4.7 material at this point.


- Paul
--843723315-543039208-1456851538=:14948--
