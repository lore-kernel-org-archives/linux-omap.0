From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 16:28:38 +0530
Message-ID: <5091045E.8040407@ti.com>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com> <20121031101201.GB10094@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121031101201.GB10094-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 31 October 2012 03:42 PM, Felipe Balbi wrote:
>>  
>> > +	if (!_dev->regs)
>> > +		return 0;
> this is wrong, you need to make sure dev->regs is set early enough.


to set the dev->regs I use the value read from revision register.

to read the revision register I do a get_sync first. This in turn leads
to the call to resume handler.
At this point the regs is NULL and so the check.

After reading the register and checking the scheme bit.
the reg map is populated.

How can this issue be solved?
