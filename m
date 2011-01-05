From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
Date: Wed, 05 Jan 2011 09:43:04 -0800
Message-ID: <87fwt7z1p3.fsf@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45848 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751312Ab1AERnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 12:43:07 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so3314346pva.5
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 09:43:07 -0800 (PST)
In-Reply-To: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 5 Jan 2011 16:27:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> struct clockdomain member clktrctrl_mask is available for only for OMAP2
> and OMAP3 architectures. Technially it is also used only for these archs
> but this breaks the build with custom OMAP4 configuration.

I'll queue patches 3-5 for the 2.6.38-rc fixes cycle.

With Paul's ack, I can queue the others too, or Paul can decide to take
them via his tree.  Paul can decide.

Kevin
