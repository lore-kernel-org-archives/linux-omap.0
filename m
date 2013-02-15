From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod_reset: Include errno.h to fix compilation
 error
Date: Fri, 15 Feb 2013 01:12:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302150111360.11016@utopia.booyaka.com>
References: <1359377743-30663-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-9291021-1360890762=:11016"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59128 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935216Ab3BOBMn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 20:12:43 -0500
In-Reply-To: <1359377743-30663-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastien Guiriec <s-guiriec@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-9291021-1360890762=:11016
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=C3=A9ter,

On Mon, 28 Jan 2013, Peter Ujfalusi wrote:

> Without the errno.h:
>   CC      arch/arm/mach-omap2/omap_hwmod_reset.o
> arch/arm/mach-omap2/omap_hwmod_reset.c: In function =E2=80=98omap_hwmod_a=
ess_preprogram=E2=80=99:
> arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: =E2=80=98EINVAL=E2=
=80=99 undeclared (first use in this function)
> arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: note: each undeclared ident=
ifier is reported only once for each function it appears in
> make[1]: *** [arch/arm/mach-omap2/omap_hwmod_reset.o] Error 1
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Paul,
>=20
> I could not find the patches from Sebastien's series:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82971.html
>=20
> But AFAIK you have taken them for 3.9.
>=20
> This patch is on top of it to fix compilation error.
>=20
> Regards,
> Peter

Thanks for sending this.  I didn't know what to do with it at the time=20
since the patches seemed to build with omap2plus_defconfig, but now after=
=20
Arnd's E-mail it's clear that this was needed for multiplatform builds. =20
Sorry about the misunderstanding...


- Paul
--843723315-9291021-1360890762=:11016--
