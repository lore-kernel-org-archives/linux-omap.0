From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: clock: Back-propagate rate change from
 cam_mclk to dpll4_m5 on all OMAP3 platforms
Date: Mon, 28 Apr 2014 21:57:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404282156400.14616@utopia.booyaka.com>
References: <1398085583-9615-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1144989685-1398722253=:14616"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37763 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaD1V5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 17:57:34 -0400
In-Reply-To: <1398085583-9615-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, t-kristo@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1144989685-1398722253=:14616
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Apr 2014, Laurent Pinchart wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>=20
> Commit 7b2e1277598e4187c9be3e61fd9b0f0423f97986 ("ARM: OMAP3: clock:
> Back-propagate rate change from cam_mclk to dpll4_m5") enabled clock
> rate back-propagation from cam_mclk do dpll4_m5 on OMAP3630 only.
> Perform back-propagation on other OMAP3 platforms as well.
>=20
> Reported-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, queued for v3.15-rc.

- Paul
--843723315-1144989685-1398722253=:14616--
