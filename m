From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 1/4] OMAP2PLUS: clocks: Align DSS clock names and
 roles
Date: Wed, 9 Feb 2011 23:22:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102092321580.21991@utopia.booyaka.com>
References: <1296491266-6949-1-git-send-email-sumit.semwal@ti.com> <1296491266-6949-2-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1BJGWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 01:22:34 -0500
In-Reply-To: <1296491266-6949-2-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com

On Mon, 31 Jan 2011, Sumit Semwal wrote:

> Currently, clock database has <dev, clock-name> tuples for DSS2. Because of
> this, the clock names are different across different OMAP platforms.
> 
> This patch aligns the DSS2 clock names and roles across OMAP 2420, 2430, 3xxx,
> 44xx platforms in the clock databases, hwmod databases for opt-clocks, and DSS
> clock handling.
> 
> This ensures that clk_get/put/enable/disable APIs in DSS can use uniform role
> names.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>

Based on a quick glance, this is 

Acked-by: Paul Walmsley <paul@pwsan.com>

Tomi or Tony, feel free to take this


- Paul
