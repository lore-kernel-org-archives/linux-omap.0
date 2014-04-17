From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 05/19] bus: omap_l3_noc: switch over to relaxed variants
 of readl/writel
Date: Thu, 17 Apr 2014 17:56:15 -0400
Message-ID: <53504DFF.7090907@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com> <1397767775-10965-1-git-send-email-nm@ti.com> <1397767775-10965-6-git-send-email-nm@ti.com> <20140417215228.GD8504@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140417215228.GD8504-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 17 April 2014 05:52 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Apr 17, 2014 at 03:49:21PM -0500, Nishanth Menon wrote:
>> Currently we use __raw_readl and writel in this driver, however, there
> 
> __raw_* and *_relaxed variants are the same, just have a look <asm/io.h>
> 
Except the relaxed version can take care of endian conversion if
needed. :-)

> 297 #define readb_relaxed(c) ({ u8  __r = __raw_readb(c); __r; })
> 298 #define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
> 299                                         __raw_readw(c)); __r; })
> 300 #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
> 301                                         __raw_readl(c)); __r; })
> 302 
> 303 #define writeb_relaxed(v,c)     __raw_writeb(v,c)
> 304 #define writew_relaxed(v,c)     __raw_writew((__force u16) cpu_to_le16(v),c)
> 305 #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
