From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA76-EVM: Set powerhold property for tps65917
Date: Mon, 11 Dec 2017 08:43:41 -0800
Message-ID: <20171211164341.GJ24344@atomide.com>
References: <1508834648-28715-1-git-send-email-j-keerthy@ti.com>
 <20171025165219.GO4394@atomide.com>
 <30907da7-a80c-4718-dd9a-17cb22669eb5@ti.com>
 <20171026141707.GE21504@atomide.com>
 <84542ce8-6e36-59a6-224c-b51c05d9866e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <84542ce8-6e36-59a6-224c-b51c05d9866e-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [171130 04:16]:
> 
> 
> On Thursday 26 October 2017 07:47 PM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [171025 23:31]:
> >>
> >>
> >> On Wednesday 25 October 2017 10:22 PM, Tony Lindgren wrote:
> >>> * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [171024 01:46]:
> >>>> Set powerhold property for tps65917
> >>>>
> >>>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> >>>
> >>> Is this safe to merge separately before the driver changes?
> >>
> >> This needs to wait till [1] is merged. I should have mentioned this.
> >>
> >> I will ping on this as soon as the dependent patch is merged.
> > 
> > OK thanks will untag this patch from my inbox for now then.
> 
> Tony,
> 
> The dependent driver patch [1] is pulled by Lee Jones.
> So this patch is okay to be applied.
> 
> [1] https://patchwork.kernel.org/patch/10023635/

Thanks applying into omap-for-v4.16/dt.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
