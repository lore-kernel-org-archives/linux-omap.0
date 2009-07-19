From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 01/13] DSPBRIDGE: Heuristic fixes of strlen/malloc out
 by one
Date: Sun, 19 Jul 2009 16:52:04 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304190ECD10@dlee03.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbZGSVwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 17:52:17 -0400
In-Reply-To: <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Subject: [PATCH 01/13] DSPBRIDGE: Heuristic fixes of strlen/malloc out by one
>
>From: Phil Carmody <ext-phil.2.carmody@nokia.com>
>
>I say 'heuristic', as I can't prove they're wrong, they just look
>wrong, and for that reason should be given extra close scrutiny.
>These are basically just the old malloc-one-more-than-strlen.
>
>Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
>Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
>---
> drivers/dsp/bridge/pmgr/wcd.c |   11 ++++++-----
> 1 files changed, 6 insertions(+), 5 deletions(-)
>

Pushed to d.o-z

- omar
