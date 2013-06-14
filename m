From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Fri, 14 Jun 2013 02:47:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306140246590.5514@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com> <51B6D618.30809@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-151619738-1371178048=:5514"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52563 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404Ab3FNCr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 22:47:29 -0400
In-Reply-To: <51B6D618.30809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-151619738-1371178048=:5514
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter,

On Tue, 11 Jun 2013, Peter Ujfalusi wrote:

> I will send a patch soon to fix these. Need to test the patch(es) first. =
I
> think they surfaced because I have enabled the audio support in
> omap2plus_defconfig for OMAP4 and 5 - which require McPDM and DMIC.
> Just couple of minutes, and I'll have the fix.

Thanks for the fast fixes :-)


- Paul
--843723315-151619738-1371178048=:5514--
