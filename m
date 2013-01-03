From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: clock data: ABE DPLL need to be locked
 on all revisions
Date: Thu, 3 Jan 2013 23:26:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301032325530.24404@utopia.booyaka.com>
References: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com> <1357220811-29904-2-git-send-email-peter.ujfalusi@ti.com> <50E5D4EA.5030001@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-434070453-1357255576=:24404"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44611 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3ACX0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jan 2013 18:26:17 -0500
In-Reply-To: <50E5D4EA.5030001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-434070453-1357255576=:24404
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 3 Jan 2013, Jon Hunter wrote:

> I am not sure that this change to the comment is completely accurate. On
> OMAP4430 I did not see any issues with the DPLL failing to turn on if
> the DPLL was not locked. I only saw this particular problem on the 4460.
> Therefore, it may be better to leave the comment as-is and add an
> additional sentence to state that the DPLL should be locked for all
> OMAP4 devices for audio to work correctly.

Makes sense to me; what do you think, P=E9ter?

- Paul
--843723315-434070453-1357255576=:24404--
