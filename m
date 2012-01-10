From: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: I2C: add devexit to the remove code
Date: Tue, 10 Jan 2012 12:10:41 +0530
Message-ID: <CANQgH-YunVKm7eG4kv8LXQdZrEAPkQGesNbxmN-rmNFJB_dR8Q@mail.gmail.com>
References: <1324365959-4143-1-git-send-email-shubhrajyoti@ti.com>
	<20120106162820.GB8441@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120106162820.GB8441-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 6, 2012 at 9:58 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Tue, Dec 20, 2011 at 12:55:59PM +0530, Shubhrajyoti D wrote:
>> The omap_i2c_remove function may not be needed after
>> device exit so the memory could be freed.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> Will add this later.

OK thanks.
