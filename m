From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am43xx: fix edma memcpy channel allocation
Date: Wed, 30 Mar 2016 14:15:07 -0700
Message-ID: <20160330211506.GD9329@atomide.com>
References: <1457946110-4612-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457946110-4612-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [160314 02:02]:
> EDMA was allocating DMA channels 32 and 33 for memcpy usage, out of which
> channel 33 is actually used by DES crypto engine. This bad allocation of
> the channel causes a crash in the DES crypto engine, as the channel
> gets configured for memcpy usage instead of hardware <-> memory DMA.
> 
> Fixed by allocating DMA channels 58 and 59 for memcpy usage (I2C0 RX/TX),
> which are not used by anybody.

Thanks applying into omap-for-v4.6/fixes with Cc stable v4.4+.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
