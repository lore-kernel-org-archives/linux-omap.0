From: Juergen Kilb <J.Kilb@phytec.de>
Subject: Fix handling of return value in omap3xx_hwmod_init and sr warning.
Date: Mon, 7 Nov 2011 22:30:15 +0100
Message-ID: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:37926 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab1KGVah convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 16:30:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

After this, I got some new warnings during bootup about sr1_hwmod and s=
r2_hwmod.
This is fixed with PATCH2/2.

-J=C3=BCrgen

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
