From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Wed, 12 Sep 2012 15:39:24 -0700
Message-ID: <87pq5quaqr.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
	<20120912131615.GB16547@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120912131615.GB16547-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> (Wolfram Sang's message
	of "Wed, 12 Sep 2012 15:16:15 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

> On Wed, Sep 12, 2012 at 04:27:54PM +0530, Shubhrajyoti D wrote:

[...]

>> This is the cleanup only series.
>>   
>> Tested on omap4sdp and 3430sdp.
>> 
>> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
>> 
>>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
>> 
>> are available in the git repository at:
>>   git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups
>
> Pushed to -next. Thanks to all involved!

Sorry to be late to the party (again), but still catching up after some
time off.

Unfortunately, this series causes PM regressions on several OMAP
platforms.  I hope we can hold off on this until those issues are
addressed.

We *really* need to have some more thorough testing (especially PM)
before merging large series like this.

Kevin
