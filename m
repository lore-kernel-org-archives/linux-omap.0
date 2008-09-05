From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Fri, 5 Sep 2008 23:45:30 +0100
Message-ID: <20080905224530.GE17156@flint.arm.linux.org.uk>
References: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com> <20080905172133.GM24202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36374 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbYIEWps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 18:45:48 -0400
Content-Disposition: inline
In-Reply-To: <20080905172133.GM24202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

On Fri, Sep 05, 2008 at 10:21:33AM -0700, Tony Lindgren wrote:
> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080902 22:37]:
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> This should be sent to linux-arm-kernel list.

Except, pmd_table() is an omap thing at the moment, so isn't relevant
there.
