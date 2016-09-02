From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Remove pinmux
 configurations
Date: Fri, 2 Sep 2016 15:48:54 +0530
Message-ID: <9bdf5693-ba02-8ce5-04b0-08875ccf7603@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-2-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160902090600.27262-2-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 02 September 2016 02:35 PM, Nishanth Menon wrote:
> pinmuxing for DRA7x/AM57x family of processors need to be done in IO
> isolation as part of initial bootloader executed from SRAM. This is
> done as part of iodelay configuration sequence and is required due to
> the limitations introduced by erratum ID: i869[1] and elaborated in
> the Technical Reference Manual[2] 18.4.6.1.7 Isolation Requirements.
> 
> Only peripheral that is permitted for dynamic pin mux configuration is
> MMC. This is to accommodate the requirements for varied speeds (which

Actually its MMC and DCAN. DCAN because of i893 ("DCAN Initialization
Sequence"). But I can see you may have omitted reference to it since
DCAN is not really used on the x15.

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
