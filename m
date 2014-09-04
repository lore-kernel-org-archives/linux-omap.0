From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: dra7-evm: fixes for mux and VTT control
Date: Thu, 4 Sep 2014 12:49:52 -0700
Message-ID: <20140904194951.GB14698@atomide.com>
References: <1409837008-32144-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409837008-32144-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140904 06:24]:
> Hi,
> 
> The following series was inspired in part by http://marc.info/?l=linux-omap&m=140974309205295&w=2
> causing me to try and do an audit of pinctrl configurations on the platform.
> 
> Further, failures on latest board updates in the automated farm also
> caused identification of a fix which was yet to be send to upstream
> from product kernel. Slightly unrelated patches in this series.
> 
> So here they are..
> based on v3.17-rc1:
> before-dra7xx-evm:  Boot FAIL: http://paste.ubuntu.org.cn/1477597
> (fails can be at different times though.. random crashes without VTT is usual)..
> after-dra7xx-evm:  Boot PASS: http://paste.ubuntu.org.cn/1477596

Thanks applying both into omap-for-v3.17/fixes-v2.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
