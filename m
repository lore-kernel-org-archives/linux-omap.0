From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: reorganize gpt8 overflow handling
Date: Mon, 14 Jun 2010 12:59:37 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E872E49@dlee03.ent.ti.com>
References: <1276172045-17267-1-git-send-email-omar.ramirez@ti.com>
 <1276172045-17267-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48818 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0FNR7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 13:59:38 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5EHxcX4009965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 12:59:38 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o5EHxbDE027627
	for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 12:59:37 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o5EHxbXK006446
	for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 12:59:37 -0500 (CDT)
In-Reply-To: <1276172045-17267-2-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Hebbar, Shivananda" <x0hebbar@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>

>From: Ramirez Luna, Omar
>
>New function to encapsulate previous code to configure gpt overflow,
>this prevents accessing dmtimer framework outside dsp-clock interface
>or exposing clock handles to other bridge modules.
>
>Besides that: duplicated and unused defines were removed, conditional
>test for cnt was replaced for a time after jiffes macro.
>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>Signed-off-by: Ernesto Ramos Falcon <ernesto@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/clk.h |    2 +
> drivers/dsp/bridge/core/dsp-clock.c        |   38 ++++++++++++++++++
> drivers/dsp/bridge/core/ue_deh.c           |   59 ++-------------------------
> 3 files changed, 45 insertions(+), 54 deletions(-)
>

Pushed to dspbridge.

- omar
