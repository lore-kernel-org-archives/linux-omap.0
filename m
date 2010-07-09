From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OK to base some patches on lmb branch?
Date: Fri, 9 Jul 2010 15:49:01 +0100
Message-ID: <20100709144901.GK22845@n2100.arm.linux.org.uk>
References: <20100707105213.GJ1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39177 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab0GIOtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 10:49:16 -0400
Content-Disposition: inline
In-Reply-To: <20100707105213.GJ1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Jul 07, 2010 at 01:52:14PM +0300, Tony Lindgren wrote:
> Hi Russell,
> 
> Is your lmb branch going to stay static?

Not at the moment, I'm still tweaking things in there, and the main
lmb conversion commit needs a better description...  I think there's
also a few bits missing from the discontigmem removal patch.
