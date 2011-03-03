From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Thu, 3 Mar 2011 14:28:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36590 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab1CCV2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 16:28:22 -0500
In-Reply-To: <1298542123-3654-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Thu, 24 Feb 2011, Avinash.H.M wrote:

> Some of the omap2, omap3 peripherals support software reset. This
> can be done through the softreset bit in sysconfig register.
> The reset status can be checked through resetdone bit of
> sysstatus register. syss_has_reset_status is added to the hwmod
> database of peripherals which have resetdone bit in sysstatus register.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Reviewed-by: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>

Thanks, queued for 2.6.39.


- Paul
