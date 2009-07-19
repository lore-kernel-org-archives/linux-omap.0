From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 02/13] DSPBRIDGE: PROCWRAP_Load function cleanup in a
 complete mess
Date: Sun, 19 Jul 2009 16:52:42 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304190ECD12@dlee03.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38645 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbZGSVww convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 17:52:52 -0400
In-Reply-To: <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Subject: [PATCH 02/13] DSPBRIDGE: PROCWRAP_Load function cleanup in a complete mess
>
>If you followed some failure paths, it was entirely possible that
>you'd attempt to MEM_Free a user-space pointer, because it wouldn't
>have been replaced with a kernel-space copy yet. Now ensure there's
>a NULL pointer to stop the cleanup at the position of the first error.
>
>Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
>---
> drivers/dsp/bridge/pmgr/wcd.c |  114 +++++++++++++++++++++++-----------------
> 1 files changed, 65 insertions(+), 49 deletions(-)
>

Small rework to apply, original file (on which the patch is based) had spaces instead of tabs.

Pushed to d.o-z

 - omar
