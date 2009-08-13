From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/9] OMAP: GPIO: Avoid generating extra IRQs
Date: Thu, 13 Aug 2009 10:17:45 +0100
Message-ID: <20090813091745.GO6132@n2100.arm.linux.org.uk>
References: <20090811094348.32577.81307.stgit@localhost> <20090811095032.32577.69831.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52956 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbZHMJRz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20090811095032.32577.69831.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

On Tue, Aug 11, 2009 at 12:50:32PM +0300, Tony Lindgren wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> It is possible for GPIO IRQ lines configured with
> falling edge triggering only to get IRQs at the
> rising edge upon the exit of offmode. And vice
> versa. Prevent such IRQs to arrive by generating
> the IRQ obeying the detection scheme.

Ok.
