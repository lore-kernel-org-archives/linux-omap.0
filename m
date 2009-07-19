From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 04/13] DSPBRIDGE: fix macros that break when inside an
 if/else
Date: Sun, 19 Jul 2009 16:54:33 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304190ECD15@dlee03.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55506 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbZGSVyn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 17:54:43 -0400
In-Reply-To: <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Subject: [PATCH 04/13] DSPBRIDGE: fix macros that break when inside an if/else
>
>From: Doyu Hiroshi (Nokia-D/Helsinki) <hiroshi.doyu@nokia.com>
>
>Based on the following discussion:
>      http://marc.info/?l=linux-omap&m=124697893724881&w=2
>
>Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>---
> drivers/dsp/bridge/pmgr/wcd.c |   60 ++++++++++++++++++++++++++--------------
> 1 files changed, 39 insertions(+), 21 deletions(-)
>

Fixed compiler error with debug enabled: "WCD_debugMask undeclared..."

Pushed to d.o-z

- omar
