From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 00/11] OMAP-GPMC: generic time calc, prepare for
 driver
Date: Thu, 20 Sep 2012 21:51:04 -0700
Message-ID: <20120921045104.GU28835@atomide.com>
References: <cover.1348058726.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16733 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751500Ab2IUEvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 00:51:09 -0400
Content-Disposition: inline
In-Reply-To: <cover.1348058726.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120919 06:22]:
> Hi,
> 
> This version - v7 as compared to previous version, takes care of
> rounding issues due to the usage of nanoseconds in generic timing
> routine. All calculations are now in picoseconds. Once all timings
> are calculated it is converted to nanoseconds so that calculated
> timing values are compatible with existing custom timing routines
> (this will help in reverting back to custom routines easily in case
> of any issues). And documentation has been added on gpmc timings.
> Also redundant rounding of nand timings has been removed as part of
> this series.

I gave this series a quick test on my n800 after applying the
two serial patches needed to get the uart to work, and it seems
to be working just fine.

Was there still some discussion on the format of the generic
timings that's still pending? I think Jon made some comments 
on the format?

Regards,

Tony
