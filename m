From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: omap: Fix the revision register read
Date: Wed, 31 Oct 2012 15:02:57 +0530
Message-ID: <CAM=Q2cssHRYFJprozOSJqXNgeCub27jyVXkhvvMaxz-Z44d_EA@mail.gmail.com>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351673959-5918-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 31, 2012 at 2:29 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> The revision register on OMAP4 is a 16-bit lo and a 16-bit
> hi. Currently the driver reads only the lower 8-bits.
> Fix the same by preventing the truncating of the rev register
> for OMAP4.
>
> Also use the scheme bit ie bit-14 of the hi register to know if it
> is OMAP_I2C_IP_VERSION_2.
>
> On platforms previous to OMAP4 the offset 0x04 is IE register whose
> bit-14 reset value is 0, the code uses the same to its advantage.
>
> The dev->regs is populated after reading the rev_hi. A NULL check
> has been added in the resume handler to prevent the access before
> the setting of the regs.
>
tested on omap4sdp, omap3630 based beagle , omap3430sdp.
