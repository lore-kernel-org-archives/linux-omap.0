From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/smsc911x: Fix deferred probe for interrupt
Date: Sat, 29 Aug 2015 13:09:34 -0700 (PDT)
Message-ID: <20150829.130934.456243212282368124.davem@davemloft.net>
References: <1440787815-24655-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1440787815-24655-1-git-send-email-tony@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: tony@atomide.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, steve.glendinning@shawell.net
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>
Date: Fri, 28 Aug 2015 11:50:15 -0700

> The interrupt handler may not be available when smsc911x probes if the
> interrupt handler is a GPIO controller for example. Let's fix that
> by adding handling for -EPROBE_DEFER.
> 
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied, thanks.
