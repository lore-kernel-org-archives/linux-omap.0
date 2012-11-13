From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 0/7] i2c: omap: updates
Date: Tue, 13 Nov 2012 18:20:42 +0530
Message-ID: <CAM=Q2cs2A7iwCLaGP90OFbecYbem_kLxEVY+xKS86un2QYRDAQ@mail.gmail.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 5, 2012 at 5:53 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
>
> Does the followiing
> - Make the revision a 32- bit consisting of rev_lo amd rev_hi each
> of 16 bits.
>
> - Also use the revision register for the erratum i207.
> - Refactor the i2c_omap_init code.
>
> Adds a patch to remove the hardcoding sysc register. Instead
> read register ,reset and then writeback the read value.
>
> Also more cleanup is possible will check on that subsequently.
>
> Previous discussions can be found
> http://www.spinics.net/lists/linux-omap/msg81265.html
>
>
> Tested on OMAP4430sdp  ,4460 ,omap3630 ,3430 and omap2430.
>
> For omap2 testing the below patch was used
> [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3 set
>
If there are no further comments can this be considered for next.

Thanks and Regards,
