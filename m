From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] pinctrl: dra: dt-bindings: Add virtual mode
 configuration option
Date: Tue, 14 Jul 2015 04:10:10 -0700
Message-ID: <20150714111009.GS17550@atomide.com>
References: <1434986546-2211-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434986546-2211-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [150622 08:24]:
> In addition to the regular mux configuration such as mux mode 1,
> 2 etc, certain pins of DRA7 require to have "virtual mode" also
> programmed. This allows for predefined delay characteristics to
> be used by the SoC to meet timing characterstics needed for the
> interface.
> 
> Provide easy to use macro to do the same.
> 
> It is important to note that the official TI guidelines recommend
> to do as minimal pin reconfiguration beyond the bootloader given
> the design of the hardware involved which can result in substantial
> glitches which may impair functionality of certain peripherals.

Applying into omap-for-v4.3/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
