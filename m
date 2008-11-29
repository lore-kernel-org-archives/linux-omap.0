From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH 0/3] OMAP: PM: enable UART clock disabling when idle
Date: Sat, 29 Nov 2008 18:06:59 +0200
Message-ID: <1227974819.26105.6.camel@localhost>
References: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
	 <94a0d4530811290452o53df8811x697bcfa49660118a@mail.gmail.com>
	 <13B9B4C6EF24D648824FF11BE8967162036CE50266@dlee02.ent.ti.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55385 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYK2QRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Nov 2008 11:17:33 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036CE50266@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On Sat, 2008-11-29 at 07:55 -0600, ext Woodruff, Richard wrote:

> Not unless you use some kind of flow control or protocol retransmits.

What about bitbanging the entire first character?

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
