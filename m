From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Use GT_trace for CLk_Disable message
Date: Fri, 5 Jun 2009 11:22:18 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040F3FCAB4@dlee03.ent.ti.com>
References: <1244121953-24866-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57089 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbZFEQW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 12:22:26 -0400
In-Reply-To: <1244121953-24866-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>
>From: Ameya Palande <ameya.palande@nokia.com>
>
>To reduce the unnecessary debug messages polluting the console,
>pr_err is replaced by GT_trace which provides finer control for
>the visibility of debug messages.
>
>Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
>---
> drivers/dsp/bridge/services/clk.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Will be pushing soon to dev.omapzoom

- omar

