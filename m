From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/7] tty: 8250: omap: introduce function to update mdr1
Date: Thu, 9 Jul 2015 16:50:55 +0530
Message-ID: <559E5917.7090707@ti.com>
References: <cover.1436174801.git.nsekhar@ti.com> <597e0f4bf4455cb7755851f5c34a02fbdd0d4aeb.1436174801.git.nsekhar@ti.com> <559DC05F.9070707@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559DC05F.9070707-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 09 July 2015 05:59 AM, Peter Hurley wrote:
> Hi Sekhar,
> 
> On 07/06/2015 05:47 AM, Sekhar Nori wrote:
>> updating mdr1 register on OMAP needs to take care of
>> errata i202. Introduce a function to update mdr1.
>>
>> This will be useful later on when mdr1 needs to be
>> written to from other places. No functional change.
> 
> This changelog is not clear. May I suggest:
> 
> serial: 8250_omap: Refactor MDR1 update
> 
> The errata [1] workaround implemented in follow-on patch,
> "serial: 8250_omap: workaround errata on disabling UART after using DMA",
> requires MDR1 register programming.
> 
> Extract MDR1 register update into helper function, omap8250_update_mdr1().
> 
> [1] Advisory 21 in http://www.ti.com/lit/er/sprz408b/sprz408b.pdf

Alright, will use this description instead.

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
