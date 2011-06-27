From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v3 2/8] OMAP2+: clockdomain: Add SoC support for
 clkdm_is_idle
Date: Mon, 27 Jun 2011 12:18:28 -0700
Message-ID: <20110627191828.GC6187@google.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>
 <1309191103-8817-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:39320 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab1F0TSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 15:18:38 -0400
Content-Disposition: inline
In-Reply-To: <1309191103-8817-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On Mon, Jun 27, 2011 at 06:11:37PM +0200, Benoit Cousson wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Add the SoC specific implemenation for clkdm_is_idle
> for OMAP2/3 and OMAP4.


This is now called clkdm_allows_idle.


Todd
