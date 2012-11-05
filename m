From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
Date: Mon, 5 Nov 2012 23:59:07 +0530
Message-ID: <CAM=Q2csELdqM2PRtaswx7Ug6KxB+CwVakXnBY6O=FJrKkBWz6A@mail.gmail.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
	<1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
	<20121105141442.GD4815@arwen.pp.htv.fi>
	<5097CBF1.6060108@ti.com>
	<20121105142517.GG4815@arwen.pp.htv.fi>
	<5097F642.9010803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5097F642.9010803-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/5/12, Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org> wrote:
> On 11/5/2012 3:25 PM, Felipe Balbi wrote:
>> Hi,
>>
>> On Mon, Nov 05, 2012 at 07:53:45PM +0530, Shubhrajyoti wrote:
>>> On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
>>>>> -							dev->syscstate);
>>>>>> -		}
>>>> not sure if this will work. What about the first time you call reset()
>>>> ?
>>>> won't SYSC just contain the reset values ?
>>> No actually the hwmod sets the value.
>>
>> ahaaa, ok good. Let's get an Ack from Benoit, then.
>
> Well, in fact, I'm a little bit surprised that we still have to hack the

there was an attempt [1]

the pdata stuff may have issues with dt having to deal with more pdata [2]


> SYSC directly without using an omap_device API.

 Paul was not happy with omap device api  [3]

As far as the patch is concerned it is only getting rid of the hard coded flags
and the rev check.

> I know that we have to
> do some weird stuff for reseting that IP, but didn't we already exposed
> something to allow that?
>
> Regards,
> Benoit

[1]  http://www.spinics.net/lists/linux-i2c/msg06810.html
[2]  http://www.spinics.net/lists/linux-i2c/msg06937.html
[3] http://www.spinics.net/lists/linux-i2c/msg06943.html
