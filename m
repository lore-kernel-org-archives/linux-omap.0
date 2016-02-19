From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Revert "regulator: tps65217: remove tps65217.dtsi file"
Date: Fri, 19 Feb 2016 09:04:05 -0800
Message-ID: <20160219170404.GH21202@atomide.com>
References: <1455891139-6139-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455891139-6139-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: hs-ynQEQJNshbs@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160219 06:14]:
> This reverts commit 8e6ebfaa9b384088002baa10f7534efa73a0794e.
> 
> Without the patch reverted regulators will not work. This prevents
> MMC to be working for example so the boards can not boot to
> MMC rootfs.
> 
> Tested it on beaglebone white and bisect also points to the
> reverted commit.
> The issue can be also fixed by adding "regulator-compatible =" to all board
> dts file for the regulators.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
> Hi,
> 
> I have noticed that bbw did not find the MMC with linux-next, but it turns out
> that even 4.5-rc4 is behaving the same way.
> I have run bisect and with this revert patch I can boot up fine.
> To be honest I don't know why the tps65217.dtsi has been deleted in the first
> place. 

I think initially the only real issue was the naming. The
tps65217.dtsi file should be just renamed to tps65217-am335x.dtsi
to make it clear that this configuration is commonly used for
most am335x boards.

I'll apply this revert into omap-for-v4.5/fixes as it fixes a
regression.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
