From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/8] ARM: OMAP3: mmc-twl4030 uses regulator framework
Date: Mon, 25 May 2009 19:47:30 -0300
Message-ID: <1243291650.10927.15.camel@brutus>
References: <20090525174517.19679.18805.stgit@localhost>
	 <20090525174821.19679.1412.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:34173 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZEYWrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 18:47:42 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2222333qwd.37
        for <linux-omap@vger.kernel.org>; Mon, 25 May 2009 15:47:43 -0700 (PDT)
In-Reply-To: <20090525174821.19679.1412.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>

Em Seg, 2009-05-25 =C3=A0s 10:48 -0700, Tony Lindgren escreveu:
> +			/* UGLY HACK:  workaround regulator framework bugs.
> +			 * When the bootloader leaves a supply active, it's
> +			 * initialized with zero usecount ... and we can't
> +			 * disable it without first disabling it.  Until the
> +			 * framework is fixed, we need a workaround like this
> +			 * (which is safe for MMC, but not in general).
> +			 */
> +			if (regulator_is_enabled(hsmmc[i].vcc) > 0) {
> +				regulator_enable(hsmmc[i].vcc);
> +				regulator_disable(hsmmc[i].vcc);
> +			}
> +			if (hsmmc[i].vcc_aux) {
> +				if (regulator_is_enabled(reg) > 0) {
> +					regulator_enable(reg);
> +					regulator_disable(reg);
> +				}
> +			}
> +

This hack would look less ugly on twl4030reg_probe(). There you can
disable the regulator without first enabling it.

(btw, there is a typo in the comment: "disable it without first
disabling it").

--=20
Daniel Ribeiro

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
