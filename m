From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 21:32:47 +0100
Message-ID: <20080917203247.GP5484@flint.arm.linux.org.uk>
References: <87tzcgi1gv.fsf@nokia.com> <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com> <20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <87y71rqo43.fsf@nokia.com> <20080917165350.GF25885@atomide.com> <20080917165725.GG25885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53344 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbYIQUdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 16:33:18 -0400
Content-Disposition: inline
In-Reply-To: <20080917165725.GG25885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kalle Valo <kalle.valo@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Wed, Sep 17, 2008 at 09:57:25AM -0700, Tony Lindgren wrote:
> If any ATAGs are needed, such as for the serial console, it needs to
> be a generic ATAG for whole arch/arm.

Why is it needed for serial console anyway?  We already have a cross-
architecture way of defining the console - it's the 'console=' argument
given to the kernel at boot time via the argument string.
