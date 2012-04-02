From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH-V2 1/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC
 timer to prcm-common header
Date: Mon, 02 Apr 2012 12:10:14 +0530
Message-ID: <4F7949CE.70002@ti.com>
References: <1333115655-28530-1-git-send-email-hvaibhav@ti.com> <1333115655-28530-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49845 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012Ab2DBGkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Apr 2012 02:40:23 -0400
Received: by obbup19 with SMTP id up19so3607827obb.15
        for <linux-omap@vger.kernel.org>; Sun, 01 Apr 2012 23:40:22 -0700 (PDT)
In-Reply-To: <1333115655-28530-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, tom.leiming@gmail.com, Felipe Balbi <balbi@ti.com>

On Friday 30 March 2012 07:24 PM, Vaibhav Hiremath wrote:
> Add missing idle_st bit for 32k-sync timer into the prcm-common
> header file, required for hwmod data.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Ming Lei <tom.leiming@gmail.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
