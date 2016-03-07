From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dra7: Enable Errata i877
Date: Mon, 7 Mar 2016 09:39:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603070938170.3437@utopia.booyaka.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456994525-20573-1-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 3 Mar 2016, Lokesh Vutla wrote:

> This series enables Errata i877 for all DRA7 platforms. The public errata
> documentation can be found here[1].
> 
> [1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
> 
> Lokesh Vutla (1):
>   ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
> 
> Mugunthan V N (1):
>   ARM: dts: dra7: do not gate cpsw clock due to errata i877

I've sent these for merging immediately. 

Have you sent patches for U-boot yet?


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
