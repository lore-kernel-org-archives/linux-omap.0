From: Paul Walmsley <paul@pwsan.com>
Subject: Re: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Fri, 18 Jul 2008 02:49:45 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807180247000.467@utopia.booyaka.com>
References: <alpine.DEB.1.00.0807172113070.467@utopia.booyaka.com> <20080718084520.GF28713@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41326 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbYGRItq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 04:49:46 -0400
In-Reply-To: <20080718084520.GF28713@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, kai.svahn@nokia.com, tony@atomide.com

On Fri, 18 Jul 2008, Felipe Balbi wrote:

> On Thu, Jul 17, 2008 at 09:25:06PM -0600, ext Paul Walmsley wrote:
> > noticed a few issues booting the N800 with the current git head
> > d3b3ae0fe6c71641da19c8de466ec366d39847e3 today.  Haven't booted the N800 
> > for a while, so not sure when these showed up.
> 
> Can you reproduce it, I just botted n800 up to maemo desktop with
> current linux omap (d3b3ae0fe6c71641da19c8de466ec366d39847e3)

It boots to desktop, but those messages come across the serial console 
consistently across several boots.  Do touchscreen taps play sound for 
you?

Kai, does MMC on N800 use the on-chip controller, or a controller on I2C?

- Paul
