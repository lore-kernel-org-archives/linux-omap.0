From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-pandora: miscellaneous corrections
Date: Tue, 21 Jul 2015 04:10:17 -0700
Message-ID: <20150721111017.GE17550@atomide.com>
References: <1437441121-31658-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437441121-31658-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150720 18:14]:
> - add pandora specific compatible name
> - fix mmc2 card detect polarity
> - fix mmc1 and mmc2 write protect polarity
> - disable write protect pins because of production issue and add an
>   explanation why they are disabled
> - fix NAND partition name to reflect the correct address

Thanks applying all four into omap-for-v4.3/dt and also
now adding the dropping of the legacy board file into Linux
next.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
