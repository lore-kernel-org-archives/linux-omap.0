From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Fri, 19 Apr 2013 23:11:06 +0530
Message-ID: <517181B2.9070302@ti.com>
References: <20130419171318.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39608 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036Ab3DSRjA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Apr 2013 13:39:00 -0400
In-Reply-To: <20130419171318.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
> Hi all,
> 
> Here's a list of breakage I've noticed so far while trying to
> use linux next on my pandaboard es. Probably similar issues exist
> on other boards as well.
> 
> Ideally we would not have any breakage by the merge window, so
> let's try to get these fixed ASAP:
> 
> 1. Serial console broken on panda es booting with DT
> 
> The symptoms are dmesg output stopping after few lines
> and only continuing after pressing a key. Does not seem to
> happen on blaze with DT for some reason. And does not happen
> on panda es with legacy booting.
> 
This one is known and reported on list along with fix patches and
later pull request [1].

Unfortunately with all the testing and everything and patches have
been on the list for quite some time, feedback on one of the patch
received was after pull request and then there was no further
clarification. That series address the same exact issue you have
mentioned above.

Regards,
Santosh
[1] http://patchwork.ozlabs.org/patch/229269/
