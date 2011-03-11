From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/2] OMAP: Overo: Add gpio-leds and gpio-keys support
Date: Fri, 11 Mar 2011 15:49:53 +0200
Message-ID: <1299851393.2479.12.camel@deskari>
References: <1299715686-3920-1-git-send-email-steve@sakoman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42020 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab1CKNuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 08:50:00 -0500
In-Reply-To: <1299715686-3920-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <steve@sakoman.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 2011-03-09 at 18:08 -0600, Steve Sakoman wrote:
> Overo COMs and expansion boards have three LEDS and 2 push button switches
> connected to GPIO pins.  This patch series adds support for utilizing
> them with gpio-keys and gpio-leds.
> 
> Changes from version 1: Guard gpio_leds assignment with CONFIG_LEDS_GPIO check
> 
> Steve Sakoman (2):
>   OMAP: Add gpio-leds support for Overo
>   OMAP: Add gpio-keys support for Overo
> 
>  arch/arm/mach-omap2/board-overo.c |   95 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
> 

Thanks, I'll take these to my tree.

 Tomi


