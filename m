From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] retu-mfd: support also Tahvo
Date: Mon, 8 Apr 2013 18:25:07 +0200
Message-ID: <20130408162507.GD24058@zurbaran>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
 <1362667221-30659-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1362667221-30659-2-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On Thu, Mar 07, 2013 at 04:40:18PM +0200, Aaro Koskinen wrote:
> Tahvo is a multi-function device on Nokia 770, implementing USB
> transceiver and charge/battery control.
> 
> It's so close to Retu that a single driver can support both.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/mfd/Kconfig      |    6 +--
>  drivers/mfd/retu-mfd.c   |   95 +++++++++++++++++++++++++++++++++++++++-------
>  include/linux/mfd/retu.h |    8 +++-
>  3 files changed, 92 insertions(+), 17 deletions(-)
Overall the patch looks good, but could you please adress Felipe's comments on
it ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
