From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] Revert "ARM: OMAP: convert I2C driver to PM QoS for MPU
 latency constraints"
Date: Wed, 7 Nov 2012 11:30:07 +0530
Message-ID: <CAM=Q2cuqQvdgCbH+_KS8FFbVsMDgkh9Kszq2ZLnzQYf6=H8B1g@mail.gmail.com>
References: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39117 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab2KGGAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 01:00:08 -0500
In-Reply-To: <alpine.DEB.2.00.1211061619461.20573@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-i2c@vger.kernel.org, ben-linux@fluff.org, w.sang@pengutronix.de, Jean Pihet <jean.pihet@newoldbits.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>

On Tue, Nov 6, 2012 at 10:01 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> This reverts commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc.
> This commit causes I2C timeouts to appear on several OMAP3430/3530-based
> boards:
>
>   http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
>   http://marc.info/?l=linux-arm-kernel&m=135067558415214&w=2
>   http://marc.info/?l=linux-arm-kernel&m=135216013608196&w=2
>
> and appears to have been sent for merging before one of its prerequisites
> was merged:
>
>   http://marc.info/?l=linux-arm-kernel&m=135219411617621&w=2
>

Not a comment however was curious does merging the dependency.
make the issue go away?
