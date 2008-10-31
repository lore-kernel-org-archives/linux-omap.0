From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 30 Oct 2008 20:12:35 -0700
Message-ID: <200810302012.35317.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <1225418657-31775-3-git-send-email-tony@atomide.com> <1225418657-31775-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:29688 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753018AbYJaDMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 23:12:37 -0400
In-Reply-To: <1225418657-31775-4-git-send-email-tony@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 30 October 2008, Tony Lindgren wrote:
> @@ -212,7 +212,7 @@ static void __init overo_init(void)
> =A0=A0=A0=A0=A0=A0=A0=A0omap_board_config =3D overo_config;
> =A0=A0=A0=A0=A0=A0=A0=A0omap_board_config_size =3D ARRAY_SIZE(overo_c=
onfig);
> =A0=A0=A0=A0=A0=A0=A0=A0omap_serial_init();
> -=A0=A0=A0=A0=A0=A0=A0hsmmc_init();
> +=A0=A0=A0=A0=A0=A0=A0hsmmc_init(HSMMC1);

Overo has its SDIO WLAN chip (libertas) hard wired to the second contro=
ller,
as I understand things ... or maybe it's the third one.  :)

Related:  shouldn't hsmmc_init() accept a set of params, maybe even a s=
truct,
describing how each controller is wired?

	- which controller (1, 2, 3)
	- how many data wires are used (1, 4, 8)
	- supported voltages (mask)
	- card detect gpio (or negative) ... assume gpio_to_irq(gpio) works
	- write protect gpio (or negative)
	- callback for updating the voltages

That would support more complete functionality ... and get away from
the current hard-wiring of most of those parameters.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
