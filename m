From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: omap5: hwmod_data: Update McPDM hwmod's flags
Date: Thu, 8 May 2014 00:20:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405080018490.23579@utopia.booyaka.com>
References: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1273264070-1399508349=:23579"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36724 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaEHAUu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 20:20:50 -0400
In-Reply-To: <1398858208-1346-1-git-send-email-peter.ujfalusi@ti.com>
Content-ID: <alpine.DEB.2.02.1405080019140.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1273264070-1399508349=:23579
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1405080019141.23579@utopia.booyaka.com>

Hi P=E9ter,

On Wed, 30 Apr 2014, Peter Ujfalusi wrote:

> Add HWMOD_SWSUP_SIDLE to flags.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

This patch could use a better changelog.  It would be ideal to understand=
=20
_why_ HWMOD_SWSUP_SIDLE is needed.  Is there a known hardware bug?  Or is=
=20
this simply based on practical observation, e.g., something bad happens if=
=20
the McPDM is not software-idled?


- Paul
--843723315-1273264070-1399508349=:23579--
