From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am4372: Correct the interrupts_properties of
 McASP
Date: Tue, 28 Nov 2017 06:52:41 -0800
Message-ID: <20171128145241.GV28152@atomide.com>
References: <20171101090331.15435-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171101090331.15435-1-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [171101 02:04]:
> Fixes the following wanring:
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp@44000000/mcasp@48038000
> arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp@44000000/mcasp@4803C000

Applying into omap-for-v4.15/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
