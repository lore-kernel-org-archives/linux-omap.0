From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 14:35:50 +0300
Message-ID: <20080925113550.GC4654@codecarver.research.nokia.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com> <1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com> <1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com> <87ej38ob7t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17527 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbYIYLgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 07:36:41 -0400
Content-Disposition: inline
In-Reply-To: <87ej38ob7t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

> 
> The cross-platform gpiolib calls should be used here.
> 
> > +			snprintf(name, sizeof(name), "hw_dbg%d", i);
> > +			err = _new_debobs_pad(&debobs_pads[i], name, i,
> > +						debobs_root);
> > +			if (err) {
> > +				omap_free_gpio(ETK_GPIO(i));
> > +				return err;
> > +			}
> > +		}
> > +	}
> 
> In the successful case, future calls to gpio_request() to use these
> lines will fail, since the line is reserved by the omap_request_gpio()
> call.
> 

Yes. That's intended. If debobs sucessfully claims the GPIO line, noone
else should be allowed to claim it, unless debobs releases it again.

Cheers,

Peter.
-- 
goa is a state of mind
