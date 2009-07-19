From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 06/13] DSPBRIDGE: avoid to dump unnecessary registers
 without debug
Date: Sun, 19 Jul 2009 16:54:16 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304190ECD14@dlee03.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbZGSVy0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 17:54:26 -0400
In-Reply-To: <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Subject: [PATCH 06/13] DSPBRIDGE: avoid to dump unnecessary registers without debug
>
>Make "GetHWRegs()" available only with CONFIG_BRIDGE_DEBUG.
>
>[Hiroshi DOYU: split the original to logical ones]
>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/wmd/tiomap3430.c |   57 +++++++++++++++++++----------------
> 1 files changed, 31 insertions(+), 26 deletions(-)
>

Pushed to d.o-z

- omar
