From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for
 sidetone
Date: Mon, 21 Mar 2016 17:44:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com> <56EFB794.5010505@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1537027876-1458582277=:31059"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EFB794.5010505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1537027876-1458582277=:31059
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter,

On Mon, 21 Mar 2016, Peter Ujfalusi wrote:

> On 03/19/16 21:38, Paul Walmsley wrote:
> > On Fri, 18 Mar 2016, Peter Ujfalusi wrote:
> >=20
> >> Hi,
> >>
> >> Chanes since v1:
> >> - removed the ASoC patch as Mark has applied it already
> >> - Added my signed-off to the hwmod patch
> >> - New patch to handle the case when the sidetone hwmod has been remove=
d for
> >>   legacy boot.
> >>
> >> The series addresses a long standing issue with McBSP2/3 regarding to =
hwmod
> >> setup. When booting with DT a warning is printed that mcbsp2/3 is usin=
g two
> >> hwmod.
> >> The root of the issue is the way how the hwmod data was constructed in=
 the first
> >> place for OMAP3 McBSP2/3.
> >> After re-reading the TRM it is clear that the sidetone should not have=
 it's
> >> own hwmod data as it is not a separate IP, it is part of the McBSP mod=
ule. It
> >> can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE bi=
t is only
> >> sets the autoidle from the internal McBSP_iclk clock to the sidetone b=
lock of
> >> the same McBSP.
> >=20
> > NAK, at least without further discussion - see my comments on the v1 0/=
3=20
> > introduction.
>=20
> Yes, I could have sent the first series as RFC, but I believe(d) that thi=
s is
> the correct way to fix the McBSP sidetone integration.

Yep not a problem.  You're handling the process correctly.  There's no=20
need to send things as an RFC unless you are unsure.=20

What you and I are doing now is exactly how the discussion and review=20
process is supposed to work.


- Paul
--843723315-1537027876-1458582277=:31059--
