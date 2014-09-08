From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [resend PATCH 1/3] pinctrl: dra7: dt-bindings: add pin off modes
 for dra7 SoC
Date: Mon, 8 Sep 2014 14:32:35 -0500
Message-ID: <20140908193235.GA12150@kahuna>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>
 <1410203998-8700-2-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410203998-8700-2-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 00:49-20140909, Mugunthan V N wrote:
> Add pin off modes for dra7 SoC so that during module disable or suspend
> state it can help saving power
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
> ---
>  include/dt-bindings/pinctrl/dra.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
> index 002a285..a0ff2d0 100644
> --- a/include/dt-bindings/pinctrl/dra.h
> +++ b/include/dt-bindings/pinctrl/dra.h
> @@ -46,5 +46,13 @@
>  #define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
>  #define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
>  
> +/* Off mode states */
> +#define PIN_OFF_NONE		0
> +#define PIN_OFF_OUTPUT_HIGH	(OFF_EN | OFFOUT_EN | OFFOUT_VAL)
> +#define PIN_OFF_OUTPUT_LOW	(OFF_EN | OFFOUT_EN)
> +#define PIN_OFF_INPUT_PULLUP	(OFF_EN | OFF_PULL_EN | OFF_PULL_UP)
> +#define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
> +#define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
> +
>  #endif

NAK for OFF_NONE, OFF_xyz etc.

A) There is no OFF mode on DRA7. in sleep state use mode 15 (gated).
B) when using this for wakeup - use pinctrl wakeup handling to do the
wakeup.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
