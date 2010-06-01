From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 1 Jun 2010 12:43:59 +0300
Message-ID: <20100601094358.GJ841@atomide.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52136 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab0FAJoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 05:44:04 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

* Arce, Abraham <x0066660@ti.com> [100601 00:39]:
> Register keyboard device with hwmod framework

Please test this with omap3_defconfig too, and make sure it does not break
things for omap2 and omap3.
 
> +int omap4_init_kp(struct omap4_keypad_platform_data *kp)
> +{
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	struct omap4_keypad_platform_data *pdata;
> +
> +	unsigned int length = 0, id = 0;
> +	int hw_mod_name_len = 16;
> +	char oh_name[hw_mod_name_len];
> +	char *name = "omap4-keypad";

	if (!cpu_is_omap44xx())
		return -ENODEV;


Might be needed here.

Tony
