From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 15:31:41 +0200
Message-ID: <20081215133140.GD16316@gandalf.research.nokia.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com> <5d5443650812150414x43716c67v6349e74f922d2de1@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23798 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbYLONcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 08:32:16 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650812150414x43716c67v6349e74f922d2de1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, linux-omap@vger.kernel.org, juha.yrjola@solidboot.com

On Mon, Dec 15, 2008 at 05:44:26PM +0530, ext Trilok Soni wrote:
> Hi Tony
> 
> On Mon, Dec 15, 2008 at 5:38 PM, Jani Nikula
> <ext-jani.1.nikula@nokia.com> wrote:
> > Add new function omap_update_gpio_switch() to support dynamically
> > changing the GPIO switch notify callback functions and debounce
> > timeouts.
> >
> > Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
> 
> Not related to this patch, but why not we convert this omap specific
> gpio switch code into generic switch framework and attach gpios to
> that switch framework, other arm-linux platforms seems to also use
> such home-brew frameworks for this functionality it seems.

Yes, would be cool. Move it to gpiolib, I'm sure there are other
platforms that might get interested in this :-)

Jani, do you plan to do that ??

-- 
balbi
