From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8 v2] ARM OMAP2+ GPMC: change get_gpmc_timing_reg
 output for DTS
Date: Wed, 25 Feb 2015 07:23:25 -0800
Message-ID: <20150225152324.GN11056@atomide.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <54EDCD29.3010404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54EDCD29.3010404@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150225 05:28]:
> On 24/02/15 22:05, Robert ABEL wrote:
> > DTS output was formatted to require additional work when copy-pasting into DTS.
> > Nano-second timings were removed, because they were not a confidence interval nor
> > an indication what timing values would result in the same #ticks
> 
> If they were not is it possible to dump min,max timings that will result in
> the same ticks?

Yeah my plan was o display the nanosecond range resulting in the
same tick value. That makes it a bit easier to compare the timings
to the data sheet. So maybe show both tick and ns range?

Ideally the timings would be from the device data sheet with
the latency added for components that are on the line in
addition to the device, such as level shifters and FPGA.

Regards,

Tony
