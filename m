From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: omap5: hwmod_data: Update McPDM hwmod's flags
Date: Thu, 8 May 2014 16:03:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405081602220.23579@utopia.booyaka.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com> <536B5790.1050800@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-427682295-1399564988=:23579"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43610 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbaEHQDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 12:03:09 -0400
In-Reply-To: <536B5790.1050800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-427682295-1399564988=:23579
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 8 May 2014, Peter Ujfalusi wrote:

> Hi Paul,
>=20
> On 05/08/2014 03:20 AM, Paul Walmsley wrote:
> > Hi P=E9ter,
> >=20
> > On Wed, 30 Apr 2014, Peter Ujfalusi wrote:
> >=20
> >> Add HWMOD_SWSUP_SIDLE to flags.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >=20
> > This patch could use a better changelog.  It would be ideal to understa=
nd=20
> > _why_ HWMOD_SWSUP_SIDLE is needed.  Is there a known hardware bug?  Or =
is=20
> > this simply based on practical observation, e.g., something bad happens=
 if=20
> > the McPDM is not software-idled?
>=20
> The same issue exists on OMAP5 as on OMAP4:
>=20
> commit 12d82e4b0aa6c71f38b668a372f9a13f243207da
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Fri Jan 18 16:48:16 2013 -0700
>=20
>     ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM
>=20
>     McPDM need to be configured to NO_IDLE mode when it is in used otherw=
ise
>     vital clocks will be gated which results 'slow motion' audio playback=
=2E
>=20
>     Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>     [paul@pwsan.com: copy patch description into hwmod data comments]
>     Signed-off-by: Paul Walmsley <paul@pwsan.com>
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c

Thanks, could you please resend the patch with an updated commit message? =
=20
Then I'll take it.  I assume this is -rc material?


- Paul
--843723315-427682295-1399564988=:23579--
