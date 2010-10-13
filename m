From: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC: WL1271 DC supprot on OMAP3EVM 0/5]
Date: Wed, 13 Oct 2010 15:37:54 +0300
Message-ID: <1286973475.18871.27.camel@chilepepper>
References: <1286967439-705-1-git-send-email-csanjay@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286967439-705-1-git-send-email-csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org" <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Sanjay,

On Wed, 2010-10-13 at 12:57 +0200, ext csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org
wrote:
> From: Sanjay Kumar Champati <csanjay-EvXpCiN+lbve9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> 
> 
> Sanjay Kumar Champati (5):
>   ARM: Supported MMC 2 features for OMAP3EVM
>   ARM: Supported for Standard SDIO driver on OMAP3EVM for WL1271 DC
>   ARM: Supported for BT enable on OMAP3EVM for WL1271 DC
>   ARM: Added ALSA audio support for WL1271 DC over the PCM interface
>     (OMAP37XX)
>   Supported BT and WLAN configuration for WL1271 over the OMAP37XX

Nobody (or at least most of us) don't even understand what exactly the
purpose of your patchset it.  Can you try to explain what you're trying
to achieve?

Also, you should clean things up, put platform-specific things where
they belong etc.  You really must review your implementation from an
architectural point of view.  If you have questions, ask here first.  In
most cases a patch describes things better than a thousand words, but it
is certainly not the case here. ;)


-- 
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
