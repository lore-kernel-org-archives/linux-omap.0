From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 15:31:44 +0300
Message-ID: <87vdwkmmof.fsf@deeprootsystems.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com>
	<87ej38ob7t.fsf@deeprootsystems.com>
	<20080925113550.GC4654@codecarver.research.nokia.com>
	<873ajoo3mk.fsf@deeprootsystems.com>
	<20080925115256.GD4654@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:2644 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYIYMbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 08:31:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so288133fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 05:31:53 -0700 (PDT)
In-Reply-To: <20080925115256.GD4654@codecarver.research.nokia.com> (Peter De Schrijver's message of "Thu\, 25 Sep 2008 14\:52\:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> On Thu, Sep 25, 2008 at 02:40:19PM +0300, ext Kevin Hilman wrote:
>> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>> 
>> >> 
>> >> The cross-platform gpiolib calls should be used here.
>> >> 
>> >> > +			snprintf(name, sizeof(name), "hw_dbg%d", i);
>> >> > +			err = _new_debobs_pad(&debobs_pads[i], name, i,
>> >> > +						debobs_root);
>> >> > +			if (err) {
>> >> > +				omap_free_gpio(ETK_GPIO(i));
>> >> > +				return err;
>> >> > +			}
>> >> > +		}
>> >> > +	}
>> >> 
>> >> In the successful case, future calls to gpio_request() to use these
>> >> lines will fail, since the line is reserved by the omap_request_gpio()
>> >> call.
>> >> 
>> >
>> > Yes. That's intended. If debobs sucessfully claims the GPIO line, noone
>> > else should be allowed to claim it, unless debobs releases it again.
>> >
>> 
>> In that case, what is the proposed method for other kernel code to use
>> the debobs lines?
>
> Hmm, good point :) My idea was to use the gpiolib calls on GPIO12 -
> GPIO29, but then there is no way for a user to know if the GPIO was
> assigned to debobs or not... Maybe debobs should register as gpiolib
> 'chip' and reexport those lines ? Would that make sense ?

I think debobs should simply 'gpio_export' each pin.  It does not need
to hold them.

Later on, if other kernel code comes along and does a gpio_request() I
think the /sysfs entry for that line will disappear until it has been
gpio_free'd.

Kevin
