From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] drivers: bus: Move omap gpmc code to live under drivers
Date: Fri, 21 Nov 2014 12:15:09 +0100
Message-ID: <3449576.YFhSXUYQOn@wuerfel>
References: <1416522501-14999-1-git-send-email-tony@atomide.com> <1416522501-14999-4-git-send-email-tony@atomide.com> <546F0299.1070508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55436 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328AbaKULPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 06:15:21 -0500
In-Reply-To: <546F0299.1070508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Vutla, Lokesh" <lokeshvutla@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On Friday 21 November 2014 11:15:05 Roger Quadros wrote:
> On 11/21/2014 12:28 AM, Tony Lindgren wrote:
> > Just move to drivers as further clean-up can now happen there
> > finally.

Awesome!

> >  arch/arm/mach-omap2/Kconfig                           | 1 +
> >  arch/arm/mach-omap2/Makefile                          | 2 +-
> >  drivers/bus/Kconfig                                   | 3 +++
> >  drivers/bus/Makefile                                  | 3 ++-
> >  arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c | 0
> >  5 files changed, 7 insertions(+), 2 deletions(-)
> >  rename arch/arm/mach-omap2/gpmc.c => drivers/bus/omap-gpmc.c (100%)
> 
> Should we move it to drivers/memory/ instead?
> TI_AEMIF driver lives there. This is similar to OMAP-GPMC for but for
> Davinci and Keystone platforms.

Agreed, using drivers/memory sounds better.

	Arnd
