From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] soc: ti: Add wkup_m3_ipc driver
Date: Sun, 19 Jul 2015 23:16:00 -0700
Message-ID: <20150720061559.GX17550@atomide.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-4-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437166592-25378-4-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [150717 13:59]:
> +
> +/* Public functions */
...
> +EXPORT_SYMBOL_GPL(wkup_m3_set_mem_type);
> +EXPORT_SYMBOL_GPL(wkup_m3_set_resume_address);
> +EXPORT_SYMBOL_GPL(wkup_m3_request_pm_status);
> +EXPORT_SYMBOL_GPL(wkup_m3_prepare_low_power);
> +EXPORT_SYMBOL_GPL(wkup_m3_finish_low_power);

I think you can avoid exporting these SoC specific functions
by just exporting wkup_m3_request() and wkup_m3_free() type
functions with a data structure containing the necessary
function pointers.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
