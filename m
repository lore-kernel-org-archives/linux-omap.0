From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 10:16:52 -0800
Message-ID: <200901141016.52800.david-b@pacbell.net>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <20090113220738.GA13227@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:24703 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752870AbZANSQz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2009 13:16:55 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 14 January 2009, Pillai, Manikandan wrote:
> The issue is that passing the initial value for regulators is done by
> 
>     struct regulator_init_data *init_data = dev->platform_data;
> 
> in regulator_register() function. Do we have a way to initialize the
> platform data for the i2c client struct.

Provide it in the struct i2c_board_info that your pr785.c file
uses to configure the regulators.


