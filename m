From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: gpmc: Print error message in set_gpmc_timing_reg()
Date: Wed, 05 Nov 2014 01:29:53 +0530
Message-ID: <54593039.3090207@pek-sem.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com> <1413895309-9152-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.57]:60068 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188AbaKDUGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2014 15:06:53 -0500
In-Reply-To: <1413895309-9152-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>
Cc: tony@atomide.com, javier@dowhile0.org, linux-omap@vger.kernel.org

On Tuesday 21 October 2014 06:11 PM, Roger Quadros wrote:
> Simplify set_gpmc_timing_reg() and always print error message
> if the requested timing cannot be achieved due to a too fast
> GPMC functional clock, irrespective if whether DEBUG is defined
> or not. This should help us debug timing configuration issues,
> which were otherwise simply not being displayed in the kernel log.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---

Thanks for this patch.
Its helpful in tweaking NAND signal timing, while trying to squeeze 
read/write performance especially with new NAND devices.


with regards, pekon

------------------------
Powered by BigRock.com

