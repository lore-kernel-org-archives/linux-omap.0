From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] Documentation: dt: bindings: TI WiLink modules
Date: Tue, 30 Jul 2013 21:54:56 +0300
Message-ID: <1375210496.20048.80.camel@cumari.coelho.fi>
References: <1375109728-5931-1-git-send-email-coelho@ti.com>
	 <1551085.3MDKgN8U89@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1551085.3MDKgN8U89@avalon>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

(using the new devicetree mailing list address)

On Tue, 2013-07-30 at 20:24 +0200, Laurent Pinchart wrote:
> Hi Luciano,
> 
> Thank you for the patch.
> 
> On Monday 29 July 2013 17:55:28 Luciano Coelho wrote:
> > Add device tree bindings documentation for the TI WiLink modules.
> > Currently only the WLAN part of the WiLink6, WiLink7 and WiLink8
> > modules is supported.
> > 
> > Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
> > ---
> > 
> > Changes in v2:
> > 
> > Use generic clock definitions to get the clock data instead of passing
> > the frequencies directly.  Also added definition for "internal"
> > ti,wilink-clock.
> > 
> > Please review.
> 
> The proposal looks good to me, I just have one small comment.

Cool! Thanks for the review.

[...]
> > +Example:
> > +--------
> > +
> > +Example definition that can be used in OMAP4 Panda:
> > +
> > +wlan {
> > +	compatible = "ti,wilink6";
> > +	interrupt-parent = <&gpio2>;
> > +	interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
> 
> Could you please use the IRQ_TYPE_LEVEL_HIGH macro (defined in <dt-
> bindings/interrupt-controller/irq.h>) instead of the hardcode 0x4 constant ?

Ah, right, I saw this new header file recently but forgot to update my
example.  I'll update the OMAP4 Panda and OMAP4 SDP dts files I just
sent out as well.

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
