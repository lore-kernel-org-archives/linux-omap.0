From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/3] OMAP_LDP: Add keypad support on ZOOM SDK
Date: Fri, 7 Nov 2008 18:02:55 +0200
Message-ID: <20081107160254.GJ21860@frodo>
References: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com> <1226065287-3066-2-git-send-email-stanley.miao@windriver.com> <1226065287-3066-3-git-send-email-stanley.miao@windriver.com> <1226065287-3066-4-git-send-email-stanley.miao@windriver.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40536 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYKGQDB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 11:03:01 -0500
Content-Disposition: inline
In-Reply-To: <1226065287-3066-4-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 07, 2008 at 09:41:27PM +0800, Stanley.Miao wrote:
> Support twl4030 keypad and gpio keys on ZOOM SDK.

Again, split defconfig changes out of this patch.

> +static struct twl4030_keypad_data ldp_kp_twl4030_data = {
> +	.rows		= 6,
> +	.cols		= 6,
> +	.keymap		= ldp_twl4030_keymap,
> +	.keymapsize	= ARRAY_SIZE(ldp_twl4030_keymap),
> +	.rep		= 1,
> +	.irq		= TWL4030_MODIRQ_KEYPAD,
> +};
> +
> +

one blank line is enough.

> +static struct gpio_keys_button ldp_gpio_keys_buttons[] = {
> +	[0] = {
> +		.code		= KEY_ENTER,
> +		.gpio		= 101,
> +		.desc		= "enter sw",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[1] = {
> +		.code		= KEY_F1,
> +		.gpio		= 102,
> +		.desc		= "func 1",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[2] = {
> +		.code		= KEY_F2,
> +		.gpio		= 103,
> +		.desc		= "func 2",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[3] = {
> +		.code		= KEY_F3,
> +		.gpio		= 104,
> +		.desc		= "func 3",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[4] = {
> +		.code		= KEY_F4,
> +		.gpio		= 105,
> +		.desc		= "func 4",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[5] = {
> +		.code		= KEY_LEFT,
> +		.gpio		= 106,
> +		.desc		= "left sw",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[6] = {
> +		.code		= KEY_RIGHT,
> +		.gpio		= 107,
> +		.desc		= "right sw",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[7] = {
> +		.code		= KEY_UP,
> +		.gpio		= 108,
> +		.desc		= "up sw",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> +	},
> +	[8] = {
> +		.code		= KEY_DOWN,
> +		.gpio		= 109,
> +		.desc		= "down sw",
> +		.active_low = 1,
> +		.debounce_interval = 30,

tabify here

> diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
> index d3e1d20..f0a0ea9 100644
> --- a/drivers/input/keyboard/omap-twl4030keypad.c
> +++ b/drivers/input/keyboard/omap-twl4030keypad.c
> @@ -174,7 +174,7 @@ static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
>  		if (!changed)
>  			continue;
>  
> -		for (col = 0; col < kp->n_cols + 1; col++) {
> +		for (col = 0; col < kp->n_cols; col++) {

this is a bug fix, should be in a separated patch.

> @@ -185,11 +185,20 @@ static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
>  				"press" : "release");
>  
>  			key = omap_kp_find_key(kp, col, row);
> -			if (key < 0)
> +			if (key < 0) {
> +#ifdef CONFIG_MACH_OMAP_LDP
> +				/* OMAP LDP has a TWL4030 GPIO
> +				 * (KBR5/KBC4) that is set to a persistent
> +				 * state and should be ignored.
> +				 */
> +				if (row == 5 && col == 4)
> +					continue;
> +#endif

this should be avoided in the driver as much as possible. You should
probably add a persistent flag to the keymap data and match that flag here.

Something like, "if (key[i].persistent) continue;"

> +
>  				dev_warn(kp->dbg_dev,
>  					"Spurious key event %d-%d\n",
>  					 col, row);
> -			else
> +			} else

if one arm has {}, put on both

-- 
balbi
