From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 01/14] ARM: am437x: cm-t43: dts: add basic support for
 sbc-t43
Date: Mon, 30 Nov 2015 13:48:49 -0800
Message-ID: <20151130214849.GC23396@atomide.com>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
 <1448371155-17307-2-git-send-email-nikita@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448371155-17307-2-git-send-email-nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> [151124 05:20]:
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_default>;
> +};
> +

Please get rid of the extra line at the end of the file.. It will cause
whitespace warnings when applying and will also cause issues applying
other changes at the end of the file if they rely on the extra line.
And check the whole series, thanks :) It will make my life a bit easier.

And the Subject line should start with "ARM: dts: ..." for the unified
look.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
