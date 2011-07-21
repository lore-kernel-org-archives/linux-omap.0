From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Kconfig help descriptions
Date: Thu, 21 Jul 2011 10:45:39 +0100
Message-ID: <20110721094539.GB28942@n2100.arm.linux.org.uk>
References: <20110721092221.GA28942@n2100.arm.linux.org.uk> <20110721093718.GM23253@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42077 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1GUJpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 05:45:49 -0400
Content-Disposition: inline
In-Reply-To: <20110721093718.GM23253@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jul 21, 2011 at 12:37:19PM +0300, Felipe Balbi wrote:
> On Thu, Jul 21, 2011 at 10:22:21AM +0100, Russell King - ARM Linux wrote:
> > Some of the Kconfig help descriptions aren't very useful - for example:
> > 
> > | CONFIG_TWL4030_MADC:
> > | 
> > | This driver provides support for triton TWL4030-MADC. The
> > | driver supports both RT and SW conversion methods.
> > | 
> > | This driver can be built as a module. If so it will be
> > | named twl4030-madc
> > 
> > What is madc?  What does it do?  Do I enable it for the OMAP 4430SDP ?
> 
> Monitoring ADC.

Well, why doesn't the text _say_ that then?  I'm still none the wiser
whether it should be enabled or not.  What's it used for?  Who uses it?
When should it be enabled?
