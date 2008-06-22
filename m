From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix warnings in clock34xx.h
Date: Sun, 22 Jun 2008 13:23:49 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806221321030.7503@utopia.booyaka.com>
References: <485E3F4D.7070508@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143AbYFVTXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 15:23:50 -0400
In-Reply-To: <485E3F4D.7070508@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Dirk,

On Sun, 22 Jun 2008, Dirk Behme wrote:

> Fix warnings

Looks good, but one request: for consistency with the rest of the file, 
please use:

       .enable_reg     = _OMAP34XX_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),

in usbhost_sar_fck, rather than OMAP3430_USBHOST_MOD.


- Paul
