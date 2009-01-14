From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 10:21:22 -0800
Message-ID: <200901141021.22937.david-b@pacbell.net>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <20090114110133.GA24895@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECF70CCE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:26924 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753203AbZANSV0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 13:21:26 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CCE@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 14 January 2009, Pillai, Manikandan wrote:
> [Pillai, Manikandan] =A0The platform_data is now initialized to clkra=
te.
> (arch/arm/plat-omap2/i2c.c

You are confused.  That's for the I2C bus adapter, not
for the i2c_client device which your tps6235.c driver
uses (and passes to the regulator framework).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
