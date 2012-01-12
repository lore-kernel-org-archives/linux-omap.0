From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] I2C : OMAP : make omap_i2c_unidle/idle functions
 depend on CONFIG_PM_RUNTIME
Date: Thu, 12 Jan 2012 12:29:05 +0530
Message-ID: <4F0E84B9.8050805@ti.com>
References: <1326270657-15309-1-git-send-email-shubhrajyoti@ti.com> <877h0x3mxh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <877h0x3mxh.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 12 January 2012 03:46 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:
>
>> The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_resume
>> and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME.
>> Make the omap_i2c_unidle/idle also depend on CONFIG_PM_RUNTIME flag.
> I probably should've done this when I initially cleaned up the
> callbacks, but since you're doing it...
>
> rather than move the functions within the file, just remove the
> functions and move the code into the runtime callbacks.
That may break the modularity of the code since the

omap_i2c_unidle is responsible for restore. I would have preferred to keep it separate.


Do you think  I could  rename   omap_i2c_unidle to 
omap_i2c_restore instead ?

However don't feel strongly about it either dif you still feel that it should be moved into runtime 
callbacks directly I am ok.
 

>  
> Kevin
