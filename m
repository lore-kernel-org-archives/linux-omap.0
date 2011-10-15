From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v14] mfd: omap: usb: Runtime PM support (fwd)
Date: Sat, 15 Oct 2011 03:14:37 +0200
Message-ID: <20111015011437.GC10229@sortiz-mobl>
References: <alpine.DEB.2.00.1110131810250.24155@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110131810250.24155-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Thu, Oct 13, 2011 at 06:11:26PM -0600, Paul Walmsley wrote:
> 
> Hi Samuel,
> 
> Care to ack this patch?  If so, we'll merge this series through the OMAP 
> tree.
> 
> 
> - Paul
> 
> ---------- Forwarded message ----------
> Date: Tue, 11 Oct 2011 13:23:29 +0530
> From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
>     linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org,
>     b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
> Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, gadiyar-l0cyMroinI0@public.gmane.org,
>     sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org,
>     johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org,
>     Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> Subject: [PATCH v14] mfd: omap: usb: Runtime PM support
> 
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> 
> The usbhs core driver does not enable/disable the interface and
> functional clocks directly, These clocks are handled by runtime pm,
> hence instead of the clock enable/disable, the runtime pm APIS are
> used. however,the optional clocks and port clocks are handled by
> the usbhs core.
> 
> Dependency:
> This patch is dependent on this series:
> [PATCH 0/5 v13 or latest version] omap: usb: host: Runtime PM preparation 
> for EHCI and OHCI drivers.
> 
> Validation performed:
> The global suspend/resume of EHCI and OHCI is validated on 
> OMAP3430 sdp board with this patch combined with the series:
> [PATCH 0/5 v13 or latest version] omap: usb: host: Runtime PM preparation 
> for EHCI and OHCI drivers. 
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
Acked-by: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
