From: Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/5] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 18 Mar 2011 10:52:27 +0200
Message-ID: <4D831D4B.8090407@nokia.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com> <20110312225047.27728.1835.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110312225047.27728.1835.stgit-MbR9/eEqKADKkTgpAXvmkg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Andy Green <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/13/2011 12:50 AM, ext Andy Green wrote:
> Introduce a generic helper function that can set a MAC address using
> data from the OMAP unqiue CPU ID register.
> 
> Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> 
>  arch/arm/mach-omap2/id.c              |   13 +++++++++++++
>  arch/arm/mach-omap2/include/mach/id.h |    1 +
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..fc69ec5 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -506,3 +506,16 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
>  	else
>  		tap_prod_id = 0x0208;
>  }
> +
> +
> +void omap2_die_id_to_mac(u8 *mac, int length)
> +{
> +	struct omap_die_id odi;
> +
> +	omap_get_die_id(&odi);
> +	memcpy(mac, &odi.id_0, length);
> +
> +	/* mark it as not multicast and outside official 80211 MAC namespace */
> +
> +	mac[0] = (mac[0] & ~1) | 2;
> +}
> diff --git a/arch/arm/mach-omap2/include/mach/id.h b/arch/arm/mach-omap2/include/mach/id.h
> index 02ed3aa..72e10eb 100644
> --- a/arch/arm/mach-omap2/include/mach/id.h
> +++ b/arch/arm/mach-omap2/include/mach/id.h
> @@ -18,5 +18,6 @@ struct omap_die_id {
>  };

so here lies the answer to my question "From where do you get the MAC" :)

Is there a guarantee that this MAC will work in all Ethernet setups?

-- 
regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
