From: Archit Taneja <archit@ti.com>
Subject: Re: [pandaboard] omapfb not accepting 720p mode
Date: Mon, 28 Oct 2013 12:05:42 +0530
Message-ID: <526E05BE.8090808@ti.com>
References: <526BE06E.4020704@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3J1Ggl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Oct 2013 02:36:41 -0400
In-Reply-To: <526BE06E.4020704@math.uni-bielefeld.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org

Hi,

On Saturday 26 October 2013 09:01 PM, Tobias Jakobi wrote:
> Hello,
>
> the kernel bugtracker doesn't let me put this address into CC, so here
> manually:
> https://bugzilla.kernel.org/show_bug.cgi?id=63781

The issue seems like we can't allocate buffers for 720p.

Can you make sure if CONFIG_DMA_CMA is set in your config? And you could 
set CMA_SIZE_MBYTES to a larger valuem say 50M.

Archit

