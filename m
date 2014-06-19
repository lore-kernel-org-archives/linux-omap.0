From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: v3.16-rc1 & default cachepolicy
Date: Fri, 20 Jun 2014 00:36:26 +0100
Message-ID: <20140619233626.GI3705@n2100.arm.linux.org.uk>
References: <20140619203655.GE558@drone.musicnaut.iki.fi> <20140619205853.GH3705@n2100.arm.linux.org.uk> <20140619224004.GF558@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35856 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965603AbaFSXgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jun 2014 19:36:32 -0400
Content-Disposition: inline
In-Reply-To: <20140619224004.GF558@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 20, 2014 at 01:40:04AM +0300, Aaro Koskinen wrote:
> So I tried the below change. But now it hangs early, even before
> the earlyprintk is working. :-/

Thanks for trying.  I notice you said "write-through", so can you
drop the PMD_SECT_BUFFERABLE flag and try again please?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
