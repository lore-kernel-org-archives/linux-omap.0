From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: board-generic: Add missing omap3_init_late
Date: Tue, 19 Feb 2013 18:47:56 +0530
Message-ID: <51237B84.7060105@ti.com>
References: <1361278711-17672-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631Ab3BSNQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 08:16:39 -0500
In-Reply-To: <1361278711-17672-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, tony@atomide.com, paul@pwsan.com

On Tuesday 19 February 2013 06:28 PM, Rajendra Nayak wrote:
> The .init_late callback for OMAP3 has been missing for DT
> builds, which causes a lot of late PM initializations to
> be missed in turn.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

