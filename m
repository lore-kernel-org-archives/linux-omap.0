From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: OMAP: fix static suspend vs. runtime suspend
Date: Tue, 08 Feb 2011 10:31:41 -0800
Message-ID: <87d3n2nzsi.fsf@ti.com>
References: <1296173921-4832-1-git-send-email-khilman@ti.com>
	<20110205160843.GD15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110205160843.GD15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org> (Ben Dooks's message
	of "Sat, 5 Feb 2011 16:08:43 +0000")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:

> On Thu, Jan 27, 2011 at 04:18:41PM -0800, Kevin Hilman wrote:
>> When runtime PM is enabled, each OMAP i2c device is suspended after
>> each i2c xfer.  However, there are two cases when the static suspend
>> methods must be used to ensure the devices are suspended:
>> 
>> 1) runtime PM is disabled, either at compile time or dynamically
>>     via /sys/devices/.../power/control.
>> 2) an i2c client driver uses i2c during it's suspend callback, thus
>>    leaving the i2c driver active (NOTE: runtime suspend transitions are
>>    disabled during system suspend, so i2c activity during system
>>    suspend will runtime resume the device, but not runtime (re)suspend it.)
>> 
>> Since the actual work to suspend the device is handled by the
>> subsytem, call the bus methods to take care of it.
>> 
>> NOTE: This takes care of a known suspend problem on OMAP3 where the
>> TWL RTC driver does i2c xfers during its suspend path leaving the i2c
>> driver in an active state (since runtime suspend transistions are
>> disabled.)
>> 
>> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>> ---
>> Ben, this is a regression in 2.6.38 so hopefully this can be queued
>> in the 2.6.38-rc cycle.  Thanks.
>
> Ok, after all the discussions should I keep it in my -rc queue?
>  

Yes, please.

Kevin
