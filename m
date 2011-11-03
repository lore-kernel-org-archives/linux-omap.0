From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP4: I2C: Enable FIFO usage for OMAP4
Date: Thu, 03 Nov 2011 07:21:02 -0700
Message-ID: <87ipn1i8xd.fsf@ti.com>
References: <1309849870-25660-1-git-send-email-shubhrajyoti@ti.com>
	<8739ikp9aa.fsf@ti.com> <20110713192055.GC3369@freya.fluff.org>
	<4EB278C4.6030006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EB278C4.6030006-l0cyMroinI0@public.gmane.org> (shubhrajyoti-l0cyMroinI0@public.gmane.org's message of "Thu,
	03 Nov 2011 16:49:32 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> On Thursday 14 July 2011 12:50 AM, Ben Dooks wrote:
>> On Tue, Jul 05, 2011 at 05:01:01PM -0700, Kevin Hilman wrote:
>>> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>>>
>>>> Currently the fifo depth is set to zero for OMAP4 which disables
>>>> the FIFO usage. This patch enables the FIFO usage for I2C transactions
>>>> on OMAP4 also.
>>>>
>>>> Tested on omap4430 and 3430.
>>>>
>>>> Reported-By: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>> Rebased on top of the series by Andy Green
>>>> http://www.spinics.net/lists/linux-i2c/msg05632.html
>>> Thanks.
>>>
>>> This is v3.1 material, but would be nice to see a couple tested-by or
>>> acked-by tags from folks that are more actively using the I2C driver
>>> before merging
>>>
>>> Kevin
>> guess you'll be picking these up?
>
> Ben Could this patch be lined up as well?

Please update this patch against my for_3.2/i2c-cleanup branch, and add
the Tested-by from Nishanth Menon.

Then I will push to get this in as a fix for v3.2-rc.

Kevin
