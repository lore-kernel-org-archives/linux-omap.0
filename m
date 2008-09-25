From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 14:52:56 +0300
Message-ID: <20080925115256.GD4654@codecarver.research.nokia.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com> <1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com> <1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com> <87ej38ob7t.fsf@deeprootsystems.com> <20080925113550.GC4654@codecarver.research.nokia.com> <873ajoo3mk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19589 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbYIYLxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 07:53:38 -0400
Content-Disposition: inline
In-Reply-To: <873ajoo3mk.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, Sep 25, 2008 at 02:40:19PM +0300, ext Kevin Hilman wrote:
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
> 
> >> 
> >> The cross-platform gpiolib calls should be used here.
> >> 
> >> > +			snprintf(name, sizeof(name), "hw_dbg%d", i);
> >> > +			err = _new_debobs_pad(&debobs_pads[i], name, i,
> >> > +						debobs_root);
> >> > +			if (err) {
> >> > +				omap_free_gpio(ETK_GPIO(i));
> >> > +				return err;
> >> > +			}
> >> > +		}
> >> > +	}
> >> 
> >> In the successful case, future calls to gpio_request() to use these
> >> lines will fail, since the line is reserved by the omap_request_gpio()
> >> call.
> >> 
> >
> > Yes. That's intended. If debobs sucessfully claims the GPIO line, noone
> > else should be allowed to claim it, unless debobs releases it again.
> >
> 
> In that case, what is the proposed method for other kernel code to use
> the debobs lines?

Hmm, good point :) My idea was to use the gpiolib calls on GPIO12 -
GPIO29, but then there is no way for a user to know if the GPIO was
assigned to debobs or not... Maybe debobs should register as gpiolib
'chip' and reexport those lines ? Would that make sense ?

Cheers,

Peter.

-- 
goa is a state of mind
