From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [GIT PULL v2] ARM: omap2: twl-common update
Date: Thu, 28 Mar 2013 10:27:37 +0100
Message-ID: <51540D09.7000104@ti.com>
References: <5146E895.50709@ti.com> <20130319182336.GE16413@atomide.com> <20130327183822.GC10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36580 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab3C1J1h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 05:27:37 -0400
In-Reply-To: <20130327183822.GC10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@list.infradead.org

Hi Tony,

On 03/27/2013 07:38 PM, Tony Lindgren wrote:
> Sorry just noticed that this one adds:
>=20
> Section mismatch in reference from the variable omap3_power_pdata to =
the (unknown reference) .init.data:(unknown)
> The variable omap3_power_pdata references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>=20
> Is it safe to make it __initdata, or should also other power_pdata
> have their __initdata flags removed if used by the drivers?

We could make the whole stack of struct for the omap3_power_pdata as
__initdata since the driver (mfd/twl4030-power) is bool.

I resend the patch and update the branch (and rebase on -rc4) at the sa=
me time.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
