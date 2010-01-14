From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v3 2/7] DSPBRIDGE: Replace magic numbers in SSI
 configuration
Date: Wed, 13 Jan 2010 18:22:52 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DDC1F42@dlee03.ent.ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35680 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625Ab0ANAW6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 19:22:58 -0500
In-Reply-To: <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

>From: Ramirez Luna, Omar
>Sent: Monday, January 11, 2010 7:01 PM
>To: linux-omap
>Cc: Ramirez Luna, Omar; Menon, Nishanth; Hiroshi Doyu; Ameya Palande; Felipe Contreras
>Subject: [PATCH v3 2/7] DSPBRIDGE: Replace magic numbers in SSI configuration
>
>Rename ssi_sysconfig variable and replace the usage of magic
>numbers while updating SSI configuration.
>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> drivers/dsp/bridge/services/clk.c |   12 ++++++++----
> 1 files changed, 8 insertions(+), 4 deletions(-)
>

Pushed to dspbridge

- omar
