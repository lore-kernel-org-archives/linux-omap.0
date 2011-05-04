From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 10/12] OMAP2+: hwmod: Add api to enable io_ring wakeup.
Date: Wed, 04 May 2011 16:59:40 -0700
Message-ID: <87mxj2nhjn.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-11-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1304080796-625-11-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 29 Apr 2011 18:09:54 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Add api to enable io_pad wakeup based on mux dynamic pad and

s/api/API/
s/io_pad/IO pad/

> wake_up enable flag initialized during hwmod_mux.
>
> Use the wakeup flag and pad_remux flag and enable wakeup capability
> for the pad having these flags enabled.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

This patch (except for the serial.c hange) isn't really dependent on the
rest of this series, and should be a separate patch to be merged by
Paul.

Some other comments below...

> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   34 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/serial.c                  |    6 ++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
>  arch/arm/plat-omap/omap_device.c              |   26 +++++++++++++++++++
>  5 files changed, 68 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..4a12336 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2369,3 +2369,37 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +/**
> + * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @oh: struct omap_hwmod *
> + * @enable: based on 0 or 1 set or unset wakeup bit.

more specifically, when true, set wakeup bit, when false, clear wakeup bit

> + * traverse through dynamic pads. If pad is enabled then
> + * set wakeup bit for the mux pin. Return error if pads are
> + * not enabled or not available.
> + */

The comment here should be clearer about when the bit actually gets
set.  Specifically, this function doesn't actually write the value out,
but instead it configures the value which will be used during the hwmod 
idle transition.

Kevin
