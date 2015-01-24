From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 17/23] ARM: OMAP4: control: remove support for legacy
 padconf APIs
Date: Sat, 24 Jan 2015 20:06:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501242006180.5450@utopia.booyaka.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-18-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44374 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbbAXUGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 15:06:51 -0500
In-Reply-To: <1417103514-17027-18-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 27 Nov 2014, Tero Kristo wrote:

> These are no longer needed for anything with the introduction of
> pinctrl DT support, thus removed.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Dropping since Tomi mentioned that the legacy mux support is still in use.


- Paul
