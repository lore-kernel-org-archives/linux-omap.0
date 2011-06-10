From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 1/8] OMAP2+: clockdomain: Add an api to read idle mode
Date: Thu, 9 Jun 2011 17:07:15 -0700
Message-ID: <20110610000715.GA9059@google.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
 <1307616853-28395-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:58111 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab1FJAHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 20:07:32 -0400
Content-Disposition: inline
In-Reply-To: <1307616853-28395-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Jun 09, 2011 at 04:24:06PM +0530, Rajendra Nayak wrote:
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.
> 
...
> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled

A minor suggestion on naming: "clkdm_allows_idle" seems more accurate
and a natural complement to the existing clkdm_allow_idle().


Todd
