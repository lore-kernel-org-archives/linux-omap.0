From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2+: hwmod: remove OMAP_CHIP*
Date: Wed, 14 Sep 2011 16:59:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109141655370.15220@utopia.booyaka.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com> <alpine.DEB.2.00.1109051606330.19606@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42731 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1INW7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 18:59:18 -0400
In-Reply-To: <alpine.DEB.2.00.1109051606330.19606@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Aaro,

On Tue, 6 Sep 2011, Aaro Koskinen wrote:

> Should the timer12 be also removed from the common omap3xxx_hwmods
> list, as it is not available on (some?) HS devices. See
> e.g. <http://marc.info/?l=linux-omap&m=129433066521102&w=2>
> 
> Currently RM-680 boot is broken because of this.

Hmmm.  I guess the software that boots the HS devices can pick and choose 
which of the secure devices to make available to Linux.  So I guess that 
on HS/EMU devices, we'd have to assume that all of the HS devices (e.g. 
GPT12) are unavailable?

Does that approach make sense?

If so, maybe we can add a fix patch on top of these cleanup patches that 
handles that...


- Paul
