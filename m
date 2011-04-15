From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 08:39:55 -0500
Message-ID: <4DA84AAB.60601@gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58263 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab1DONj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 09:39:59 -0400
Received: by yxs7 with SMTP id 7so1089896yxs.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Apr 2011 06:39:58 -0700 (PDT)
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russell,

On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
> This is work in progress.
>
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.

It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.

lpc32xx and pnx4008 also use iram, but do not have an allocator (only 1 
user). Both are doing a copy the suspend code to IRAM and run it which 
may also be a good thing to have generic code for. Several i.MX chips 
also need to run from IRAM for suspend.

Rob
