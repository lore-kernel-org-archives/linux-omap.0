From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] arm: dts: da850: Add interrupt-controller property to
 gpio node
Date: Wed, 24 May 2017 19:19:03 +0530
Message-ID: <4a6dca2b-b877-a975-3292-60ee08a33ad8@ti.com>
References: <1495630095-1954-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495630095-1954-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 May 2017 06:18 PM, Keerthy wrote:
> The gpio node has 144 gpios. Each gpio is capable of generating
> an interrupt. Hence add interrupt-controller property to the gpio
> node. With this in place one can use interrupts property in device
> tree to request for the gpio interrupts.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Can you please resend with LAKML copied. Thats the right list to use for
TI DaVinci patches (of course, please keep device tree lists and
maintainers copied too for DT patches).

I will fix the MAINTAINERS entry for TI DaVinci device-tree source files.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
