From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP: Make dpll4_m4_ck programmable with
 clk_set_rate()
Date: Fri, 5 Dec 2008 16:52:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812051650380.21247@utopia.booyaka.com>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com> <1224545064-25551-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-910179944-1228521147=:21247"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYLEXw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 18:52:29 -0500
In-Reply-To: <1224545064-25551-1-git-send-email-mans@mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-910179944-1228521147=:21247
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Oct 2008, Mans Rullgard wrote:

> Filling the set_rate and round_rate fields of dpll4_m4_ck makes
> this clock programmable through clk_set_rate().  This is needed
> to give omapfb control over the dss1_alwon_fck rate.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

M=E5ns, sorry this took so long, these two patches slipped through the=20
cracks here.


- Paul
--155748971-910179944-1228521147=:21247--
