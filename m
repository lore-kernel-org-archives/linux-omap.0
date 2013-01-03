From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: OMAP4: Audio regression fix for 3.8 kernel
Date: Thu, 3 Jan 2013 17:56:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301031756290.8721@utopia.booyaka.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1547862850-1357235806=:8721"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43830 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab3ACR4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 12:56:47 -0500
In-Reply-To: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1547862850-1357235806=:8721
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=E9ter

On Thu, 3 Jan 2013, Peter Ujfalusi wrote:

> I have noticed that in 3.8-rc2 kernel OMAP4 audio is not working correctl=
y. The
> audio playback is in 'slow motion' mode.
> The following two patch fixes this regression.
>=20
> We need to lock the ABE DPLL for all OMAP4 revisions not only for 446x an=
d McPDM
> need to be configured to no IDLE mode during activity.

Thanks, both queued for 3.8-rc fixes.

- Paul
--843723315-1547862850-1357235806=:8721--
