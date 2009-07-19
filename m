From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 03/13] DSPBRIDGE: Remove unnecessary conditions from
 some for loops
Date: Sun, 19 Jul 2009 16:53:00 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304190ECD13@dlee03.ent.ti.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42094 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZGSVxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 17:53:08 -0400
In-Reply-To: <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ameya
>Palande
>Subject: [PATCH 03/13] DSPBRIDGE: Remove unnecessary conditions from some for loops
>
>The status cannot be a failure value at the start of the loops,
>and the only changes to a failure state are accompanied by a
>break or goto, so these conditions are always true.
>
>Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
>Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
>---
> drivers/dsp/bridge/pmgr/wcd.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>

Pushed to d.o-z

- omar

