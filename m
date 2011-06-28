From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Wed, 29 Jun 2011 00:03:58 +0100
Message-ID: <20110628230358.GB23312@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com> <4E0A5982.8040002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50220 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1F1XEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 19:04:11 -0400
Content-Disposition: inline
In-Reply-To: <4E0A5982.8040002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Colin Cross <ccross@google.com>, Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 28, 2011 at 03:45:22PM -0700, Santosh Shilimkar wrote:
> The udelay code doesn't use the per-cpu lpj variable. It uses the global
> lpj. Secondly the calibration of no. of loops to be done is
> precalculateed so overwrite shouldn't impact the scenario you mentioned.
>
> Though it has an issue where, pre-calculated loops can become short/long
> based on new clock change which impacts both CPU's on OMAP, when the  
> other CPU is in in the middle of u-delay routine..

And there's also the issue where you can start a udelay loop on one CPU,
be pre-empted and end up running it on a different CPU running at a
different speed.

The thing to bear in mind is that udelays are approximate at best - I did
some investigation into the accuracy of the loops_per_jiffy calculation,
and it _will_ produce shorter delays than expected by the fact that
what is being calibrated is the udelay() loop _plus_ the timer interrupt
overhead.
