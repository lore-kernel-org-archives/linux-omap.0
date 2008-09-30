From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [i2c] [PATCH 1/8] i2c-omap: Do not use interruptible wait call
 in omap_i2c_xfer_msg
Date: Tue, 30 Sep 2008 14:51:00 +0300
Message-ID: <20080930145100.62fdb0fa.jarkko.nikula@nokia.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com>
	<1222329234-31473-2-git-send-email-tony@atomide.com>
	<20080929222100.GN2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21547 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbYI3L7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 07:59:35 -0400
In-Reply-To: <20080929222100.GN2716@fluff.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ben Dooks <ben-linux@fluff.org>
Cc: Tony Lindgren <tony@atomide.com>, i2c@lm-sensors.org, Juha Yrjola <juha.yrjola@solidboot.com>, linux-omap@vger.kernel.org

On Mon, 29 Sep 2008 23:21:00 +0100
"ext Ben Dooks" <ben-linux@fluff.org> wrote:

> On Thu, Sep 25, 2008 at 10:53:47AM +0300, Tony Lindgren wrote:
> > From: Jarkko Nikula <jarkko.nikula@nokia.com>
> > 
> > If there is a signal pending and wait_for_completion_interruptible_timeout
> > terminates with -ERESTARTSYS, we return and disable the i2c clocks in
> > omap_i2c_xfer.
> > 
> > If we terminate before sending last i2c message with a stop condition, the
> > bus remains busy and we are not able to send new messages into bus with
> > successive omap_i2c_xfer calls. Therefore a pending signal is not caught
> > here and we return only because of timeout or i2c error.
> 
> I assume that this is preferable to aborting an transfer when the
> signal is caught (if possible) ?
>  
Most probably yes as long as the stop condition is generated
successfully. IRCC bug behind this fix, OMAP I2C went into bus
arbitration without code able to recover easily or something like that.

Would it be ok to let this fix as now, probably adding FIXME line near
wait_for_completion_timeout so that we don't break anything now but
note that this is not optimal fix?


Jarkko
