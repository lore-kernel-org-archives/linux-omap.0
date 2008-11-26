From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix omap-gpio warnings when compiling for ARCH_OMAP15XX
Date: Wed, 26 Nov 2008 10:35:22 -0800
Message-ID: <200811261035.22318.david-b@pacbell.net>
References: <20081111225348.GZ3162@earth.li> <20081126175418.GR11997@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:44587 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752389AbYKZSfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 13:35:23 -0500
In-Reply-To: <20081126175418.GR11997@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan McDowell <noodles@earth.li>, linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Tony Lindgren wrote:
> Let's rather start
> splitting the gpio code into common code and processor specific code
> to fix issues like this for good.

Working on that.  :)

