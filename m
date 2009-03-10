From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/6] RX51: adjust hsmmc info
Date: Tue, 10 Mar 2009 09:58:12 -0800
Message-ID: <200903101058.12980.david-b@pacbell.net>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop> <20090310093329.16889.76098.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:33381 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753590AbZCJR6P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2009 13:58:15 -0400
In-Reply-To: <20090310093329.16889.76098.sendpatchset@ahunter-laptop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tuesday 10 March 2009, Adrian Hunter wrote:
> @@ -52,16 +52,20 @@ static struct platform_device *rx51_flash_devices=
[] =3D {
> =A0
> =A0static struct twl4030_hsmmc_info mmc[] __initdata =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D "external",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.mmc=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=3D 1,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.wires=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=3D 8,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.wires=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=3D 4,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.cover_only=A0=A0=A0=A0=
=A0=3D true,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_cd=A0=A0=A0=A0=A0=
=A0=A0=A0=3D 160,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_wp=A0=A0=A0=A0=A0=
=A0=A0=A0=3D -EINVAL,
> =A0=A0=A0=A0=A0=A0=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D "internal",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.mmc=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=3D 2,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.wires=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D 8,

Ack on all the changes above ...


> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_cd=A0=A0=A0=A0=A0=
=A0=A0=A0=3D -EINVAL,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_wp=A0=A0=A0=A0=A0=
=A0=A0=A0=3D -EINVAL,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.vsim_18v=A0=A0=A0=A0=A0=
=A0=A0=3D true,

=2E.. but not that one.

> =A0=A0=A0=A0=A0=A0=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{}=A0=A0=A0=A0=A0=A0/* Terminator */
> =A0};


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
