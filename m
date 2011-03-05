From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 0/2] Add DSS2 support on Overo
Date: Sat, 5 Mar 2011 16:51:06 +0200
Message-ID: <1299336666.2014.0.camel@deskari>
References: <1299333519-11467-1-git-send-email-steve@sakoman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56402 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab1CEOvJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Mar 2011 09:51:09 -0500
In-Reply-To: <1299333519-11467-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, 2011-03-05 at 07:58 -0600, Steve Sakoman wrote:
> This patch series adds support for the set of display devices available
> for the Overo COM products: DVI, S-Video, the Samsung LTE430WQ-F0C LCD
> panel, and the LG.Philips LB035Q02 panel.
> 
> Tested with applicable expansion boards for each option: Tobi, Palo43,
> Chestnut43, and Palo35.
> 
> Changes from version 1: adds mutex locking to the lgphilips-lb035q02
> panel enable/disable and suspend/resume functions.
> 
> Changes from version 2: add missing semicolon to lb035q02_data definition
> 
> Steve Sakoman (2):
>   OMAP: DSS2: Add support for LG Philips LB035Q02 panel
>   OMAP: DSS2: Add DSS2 support for Overo
> 
>  arch/arm/mach-omap2/board-overo.c                  |  239 ++++++++++++++---
>  drivers/video/omap2/displays/Kconfig               |    6 +
>  drivers/video/omap2/displays/Makefile              |    1 +
>  .../omap2/displays/panel-lgphilips-lb035q02.c      |  279 ++++++++++++++++++++
>  4 files changed, 488 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c

Thanks, applied.

 Tomi


