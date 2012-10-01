From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.6-rc7
Date: Mon, 1 Oct 2012 18:34:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210011832420.2160@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com> <50645A1D.5040108@compulab.co.il>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1150428557-1349116453=:2160"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54275 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab2JASeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 14:34:14 -0400
In-Reply-To: <50645A1D.5040108@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1150428557-1349116453=:2160
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 27 Sep 2012, Igor Grinberg wrote:

> On 09/24/12 21:21, Paul Walmsley wrote:
> >=20
> > * 3517EVM & CM-T3517: boot hangs              =20
> >   - Probably due to the use of NFS root; there are likely some Kconfig,
> >     board file, and PM issues with EMAC
>=20
> Have you tried the nohlt boot parameter?
> It looks like the wfi is killing those SoCs once you use EMAC.

Haven't had the chance to do much debugging here yet.  M=E5ns and Mark Gree=
r=20
also suggested there may be a board file/Kconfig problem here that
should be checked.  Right now am just testing mainline.

- Paul
--843723315-1150428557-1349116453=:2160--
