From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv11 0/6] I2C cleanups
Date: Fri, 13 Jul 2012 16:55:53 +0530
Message-ID: <500005C1.4010203@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com> <CAM=Q2ct0PUisYGcaX6EAPWT-SmZAgRV_O8mAOodH-V4Q0O-Vww@mail.gmail.com> <20120712125229.GG2194@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120712125229.GG2194-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 12 July 2012 06:22 PM, Wolfram Sang wrote:
> On Mon, Jul 09, 2012 at 05:17:07PM +0530, Shubhrajyoti Datta wrote:
>> On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>>> This is a minimal cleanup series.
>> If there are no further comments can this series be queued?
> I just applied a few of them. BTW I get a build warning when compiling the
> kernel, maybe someone is interested. It is not related to the patches, though.
OK could check that.
>
> ===
>
> WARNING: arch/arm/mach-omap2/built-in.o(.data+0x2b5c0): Section mismatch in reference from the variable rx51_si4713_dev to the (unknown reference) .init.data:(unknown)
> The variable rx51_si4713_dev references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> ===
>
> I think this is what I'll pull in for the next merge window. The big OMAP
> cleanup (latest version from 3. July) would then go in early into -next for
> 3.7. Is that OK with the omap-people?
>
> Also, thanks to Shubhrajyoti Datta for reviewing other patches on the
> i2c-list, much appreciated.
Thanks,

> Thanks,
>
>    Wolfram
>
