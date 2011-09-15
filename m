From: Luciano Coelho <coelho@ti.com>
Subject: Re: ti.com addresses randomly unsubscribed from vger.kernel.org
 lists
Date: Thu, 15 Sep 2011 22:59:19 +0300
Message-ID: <1316116759.7608.247.camel@cumari>
References: <87r53h67k7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52282 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934532Ab1IOT7X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 15:59:23 -0400
Received: by mail-fx0-f50.google.com with SMTP id 10so1091788fxh.9
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 12:59:22 -0700 (PDT)
In-Reply-To: <87r53h67k7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, 2011-09-15 at 10:26 -0700, Kevin Hilman wrote: 
> Hello,
> 
> There have been ongoing problems for awhile now where ti.com addresses
> have been randomly unsubscribed from vger.kernel.org lists (linux-omap,
> linux-kernel, etc.)
> 
> Luca and myself have been working with TI IT to figure out this problem,
> and they claim to have fixed the problem (details on problem below.)
> 
> Please send me an email if you find yourself suddenly unsubscribed from
> one of these mailing lists, and also open a ticket with IT.
> 
> Kevin
> 
> 
> More details: 
> 
> The problem is that the mailing list admin was receiving bounces from
> the ti.com mail servers, but the bounces were not descriptive enough to
> discover which addresses were failing.  The result was "big hammer"
> approach in that ti.com addresses were unsubscribed until the bounces
> stopped.
> 
> After talking with the list admins, this has been going on for years.
> 
> We were able to get copies of the bounced emails from the kernel.org
> list admin and share them with IT, and they have found the problem and
> have claimed to fix it.
> 
> If you find yourself suddenly unsubscribed again, please open a ticket
> and also let me know.

Yeah, I've been in contact with Dave and he helped us by sending some
bounce emails to be investigated by TI's IT.  It seems that they have
worked around this problem, by whitelisting vger.kernel.org.  According
to IT, the problem was the way vger sends emails, by opening a single
SMTP connection to send loads of emails at once, instead of opening a
separate connection for each recipient.  The SPAM filters TI uses
consider that kind of behavior as SPAM by default.

Hopefully the bounces won't happen anymore with the whitelisting.  Dave
said he hasn't got any bounces for a while (he used to get 50-60 a day)
and that he will inform me in case he sees more bounces from ti.com.

I use my gmail account for these subscriptions, and have done it for a
few years, after having similar problems with my ex nokia.com email. ;)

As Kevin said, if you use ti.com emails and you get mysteriously
unsubscribed from some mailing lists, let us know.

-- 
Cheers,
Luca.

