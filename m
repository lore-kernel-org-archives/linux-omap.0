From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 14:40:19 +0300
Message-ID: <873ajoo3mk.fsf@deeprootsystems.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com>
	<1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com>
	<87ej38ob7t.fsf@deeprootsystems.com>
	<20080925113550.GC4654@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:60804 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbYIYLk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 07:40:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so377932fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 04:40:28 -0700 (PDT)
In-Reply-To: <20080925113550.GC4654@codecarver.research.nokia.com> (Peter De Schrijver's message of "Thu\, 25 Sep 2008 14\:35\:50 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

>> 
>> The cross-platform gpiolib calls should be used here.
>> 
>> > +			snprintf(name, sizeof(name), "hw_dbg%d", i);
>> > +			err = _new_debobs_pad(&debobs_pads[i], name, i,
>> > +						debobs_root);
>> > +			if (err) {
>> > +				omap_free_gpio(ETK_GPIO(i));
>> > +				return err;
>> > +			}
>> > +		}
>> > +	}
>> 
>> In the successful case, future calls to gpio_request() to use these
>> lines will fail, since the line is reserved by the omap_request_gpio()
>> call.
>> 
>
> Yes. That's intended. If debobs sucessfully claims the GPIO line, noone
> else should be allowed to claim it, unless debobs releases it again.
>

In that case, what is the proposed method for other kernel code to use
the debobs lines?

Kevin
