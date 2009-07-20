From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 09/13] DSPBRIDGE: fix incorrect mask of DPLL in
 CHNLSM_InterruptDSP2()
Date: Sun, 19 Jul 2009 22:52:25 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304190ECD77@dlee03.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-6-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-7-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-8-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43453 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbZGTDwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 23:52:37 -0400
In-Reply-To: <1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Subject: [PATCH 09/13] DSPBRIDGE: fix incorrect mask of DPLL in CHNLSM_InterruptDSP2()
>
>This patch also contains indentation fixes and cleanups for
>CHNLSM_InterruptDSP2().
>
>[Hiroshi DOYU: split the original to logical ones]
>
>Reported-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/wmd/tiomap_sm.c |   56 +++++++++++++++++------------------
> 1 files changed, 27 insertions(+), 29 deletions(-)
>

Pushed to d.o-z
