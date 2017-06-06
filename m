From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dts: am33xx: Remove redundant interrupt-parent
 property
Date: Tue, 6 Jun 2017 00:34:23 -0700
Message-ID: <20170606073422.GX3730@atomide.com>
References: <1496686636-19194-1-git-send-email-sunil.m@techveda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496686636-19194-1-git-send-email-sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, suniel.spartan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org> [170605 11:21]:
> From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> 
> Interrupt-parent property is defined in the root node as
> "interrupt-parent = <&intc>". This interrupt-parent value becomes
> the default for the system, so removed redundant "interrupt-parent"
> property from mmc, mac, lcdc and tscadc nodes.

Thanks seems safe to remove so applying into omap-for-v4.13/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
