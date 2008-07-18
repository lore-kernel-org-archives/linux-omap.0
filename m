From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Fri, 18 Jul 2008 12:00:55 +0300
Message-ID: <20080718090055.GG28713@gandalf.research.nokia.com>
References: <alpine.DEB.1.00.0807172113070.467@utopia.booyaka.com> <20080718084520.GF28713@gandalf.research.nokia.com> <alpine.DEB.1.00.0807180247000.467@utopia.booyaka.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52432 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbYGRJBF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 05:01:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807180247000.467@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, kai.svahn@nokia.com, tony@atomide.com

On Fri, Jul 18, 2008 at 02:49:45AM -0600, ext Paul Walmsley wrote:
> It boots to desktop, but those messages come across the serial console 
> consistently across several boots.  Do touchscreen taps play sound for 
> you?

Hmm, now I got it right.

The thing is that n800 doesn't have lm8323 (keypad), so that driver
shouldn't be probing. That's quite weird. I'll try to take a look at it.

-- 
balbi
