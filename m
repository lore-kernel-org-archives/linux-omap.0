From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] Back-light class driver support for OMAP
Date: Thu, 19 Mar 2009 15:00:33 -0700
Message-ID: <200903191500.33977.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1237385410-29124-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:37822 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752541AbZCSWAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2009 18:00:37 -0400
In-Reply-To: <1237385410-29124-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, premi@ti.com, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>

On Wednesday 18 March 2009, hvaibhav@ti.com wrote:
> +
> +#if defined(CONFIG_TWL4030_CORE)
> +=A0=A0=A0=A0=A0=A0=A0twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, =
TWL4030_LED_EN);
> +=A0=A0=A0=A0=A0=A0=A0twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TW=
L_PWMA_PWMAOFF);
> +#endif

Hmm, I think I'm going to have to get off my butt and
send in the PWM patches I have ... they work for the
PWMs on the two LED outputs, but not yet for the two
other PWM-equipped pins (GPIO-6, GPIO-7)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
