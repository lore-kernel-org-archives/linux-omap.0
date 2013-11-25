From: Tony Lindgren <tony@atomide.com>
Subject: Re: Status of 1GHz support on am37xx
Date: Mon, 25 Nov 2013 15:35:46 -0800
Message-ID: <20131125233545.GZ10023@atomide.com>
References: <20131122230121.GA13440@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45724 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752592Ab3KYXft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 18:35:49 -0500
Content-Disposition: inline
In-Reply-To: <20131122230121.GA13440@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

* Mark A. Greer <mgreer@animalcreek.com> [131122 15:02]:
> Hello.
> 
> I was wondering what that the status of 1GHz support for the am37xx is.
> 
> It looks like smartreflex/avs and ABB drivers are there.  Do they need
> more work (e.g., DT support)?  What DT nodes and related support need
> to be added?
> 
> What pieces are being worked on and which ones aren't?
> Is there an ETA for the pieces being worked on?

There are still various parts of twl4030 that are only working with
platform data, so at least those should be fixed now that we're moving
to DT only based booting for mach-omap2 for v3.14.

Regards,

Tony
