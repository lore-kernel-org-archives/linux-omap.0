From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v3 3/7] DSPBRIDGE: Mark unused ioctls as deprecated
Date: Wed, 13 Jan 2010 18:23:13 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DDC1F43@dlee03.ent.ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50915 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197Ab0ANAXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 19:23:19 -0500
In-Reply-To: <1263258041-16836-4-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

>From: Ramirez Luna, Omar
>Sent: Monday, January 11, 2010 7:01 PM
>To: linux-omap
>Cc: Ramirez Luna, Omar; Menon, Nishanth; Hiroshi Doyu; Ameya Palande; Felipe Contreras
>Subject: [PATCH v3 3/7] DSPBRIDGE: Mark unused ioctls as deprecated
>
>Mark unused ioctls as deprecated for future removal
>and print an error message whenever they are used.
>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   11 ++++--
> drivers/dsp/bridge/pmgr/wcd.c                   |   38 +++++++++--------------
> 2 files changed, 22 insertions(+), 27 deletions(-)
>

Pushed to dspbridge

- omar
