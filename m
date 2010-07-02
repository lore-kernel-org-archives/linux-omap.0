From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 04/13] OMAP: hwmod: Fix the missing braces
Date: Fri, 2 Jul 2010 05:49:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007020548430.13691@utopia.booyaka.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com> <1277423084-25528-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59207 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab0GBLtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 07:49:20 -0400
In-Reply-To: <1277423084-25528-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

Hi,

On Thu, 24 Jun 2010, Kevin Hilman wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> As reported by Sergei, a couple of braces were missing after
> the WARM removal patch.
> 
> [07/22] OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed
> 
> https://patchwork.kernel.org/patch/100756/
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

This one has already been sent to Tony as part of the -rc series, so I've 
dropped this one.


- Paul
