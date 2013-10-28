From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [pandaboard] omapfb not accepting 720p mode
Date: Mon, 28 Oct 2013 10:34:57 +0100
Message-ID: <526E2FC1.6030607@math.uni-bielefeld.de>
References: <526BE06E.4020704@math.uni-bielefeld.de> <526E05BE.8090808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:44921 "EHLO
	smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756122Ab3J1Jlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Oct 2013 05:41:31 -0400
In-Reply-To: <526E05BE.8090808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

Archit Taneja wrote:
> The issue seems like we can't allocate buffers for 720p.
>
> Can you make sure if CONFIG_DMA_CMA is set in your config? And you
> could set CMA_SIZE_MBYTES to a larger valuem say 50M.
>
> Archit
>
Hello Archit,

yes, CMA is activated and with my latest config I've got 32MB allocated.
I'll try to further increase the amount and check some other (larger)
resolutions with don't require CVT (1280x1024 e.g.).

Also I may be wrong, but isn't allocation done after the parsing?
The first message "cannot parse default modes" comes from
omapfb_parse_def_modes returning an error. Which could be triggered by
either the mode syntax being messed up (not the case for me I think),
kstrdup failing (not very likely) or omapfb_set_def_mode failing. And
from what I can see, omapfb_set_def_mode does some timing
calculations/conversions, sets these timings and nothing more.

The allocation part is triggered by omapfb_create_framebuffers, so after
omapfb_parse_def_modes.

Greets,
Tobias

