From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v3 6/7] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Wed, 13 Jan 2010 18:24:23 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DDC1F49@dlee03.ent.ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-2-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-3-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-4-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-5-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-6-git-send-email-omar.ramirez@ti.com>
 <1263258041-16836-7-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38933 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197Ab0ANAY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 19:24:28 -0500
In-Reply-To: <1263258041-16836-7-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

>From: Ramirez Luna, Omar
>Sent: Monday, January 11, 2010 7:01 PM
>To: linux-omap
>Cc: Ramirez Luna, Omar; Menon, Nishanth; Hiroshi Doyu; Ameya Palande; Felipe Contreras
>Subject: [PATCH v3 6/7] DSPBRIDGE: Use _IOxx macro to define ioctls
>
>- Use standard convention to define ioctls.
>
>Currently 0xDB is used as identifier for dspbridge.
>
>Discussion:
>http://marc.info/?l=linux-omap&m=126297631603035&w=2
>
>WARNING:
>An update in api ioctl definitions is required, usually replacing
>to a new libbridge (with ioctl patch) should be enough. Other
>clients (not using libbridge) need to update their ioctl numbers
>manually.
>
>Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/wcdioctl.h |  181 ++++++++++++---------
> drivers/dsp/bridge/pmgr/wcd.c                   |  200 +++++++++++++++--------
> drivers/dsp/bridge/rmgr/drv_interface.c         |    3 -
> 3 files changed, 237 insertions(+), 147 deletions(-)
>

Pushed to dspbridge

- omar
