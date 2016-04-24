From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1] ARM: dts: omap3-n900: Specify peripherals LDO
 regulators initial mode
Date: Sun, 24 Apr 2016 12:08:30 +0200
Message-ID: <20160424100830.GC23015@amd>
References: <20160417122933.GA8093@earth>
 <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sre@kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2016-04-17 17:29:23, Ivaylo Dimitrov wrote:
> Without that, regulators are left in the mode last set by the bootloader or
> by the kernel the device was rebooted from. This leads to various problems,
> like non-working peripherals.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -329,6 +329,7 @@
>  	regulator-name = "V28";
>  	regulator-min-microvolt = <2800000>;
>  	regulator-max-microvolt = <2800000>;
> +	regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */
>  	regulator-always-on; /* due to battery cover sensor */
>  };
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
