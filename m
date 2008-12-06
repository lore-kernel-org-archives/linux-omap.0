From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH v2 3/5] OMAP3: PM: Add D2D clocks and auto-idle setup to
 PRCM init
Date: Fri, 5 Dec 2008 23:37:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812052337390.21247@utopia.booyaka.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com> <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com> <1228148566-9358-3-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39120 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYLFGh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Dec 2008 01:37:58 -0500
In-Reply-To: <1228148566-9358-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, 1 Dec 2008, Kevin Hilman wrote:

> Add D2D clocks (modem_fck, sad2d_ick, mad2d_ick) to clock framework,
> and also ensure that auto-idle bits are set for these clocks during
> PRCM init.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
