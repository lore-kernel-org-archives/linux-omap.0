From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] Input: Make lm8323 sticky key to work with console
Date: Thu, 15 May 2008 11:03:34 +0300
Message-ID: <20080515080333.GD4625@kedavra.cpe.vivax.com.br>
References: <1210824079-22548-1-git-send-email-tony@atomide.com> <1210824079-22548-2-git-send-email-tony@atomide.com> <1210824079-22548-3-git-send-email-tony@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50752 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbYEOICp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 04:02:45 -0400
Content-Disposition: inline
In-Reply-To: <1210824079-22548-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, daniel.stone@nokia.com

On Wed, May 14, 2008 at 09:01:19PM -0700, Tony Lindgren wrote:
> This allows using N810 keyboard from console by adding optional
> Fn and shift sticky key handling by passing them from platform_data.
> 
> Currently some not so obvious mappings are:
> 
> - Pipe is Fn + Enter
> - Delete is Fn + Backspace
> - Escape is Fn + Ctrl

no tab? :-(

Fn + space maybe?? :-p

> 
> Works also with xserver-xorg-video-fbdev.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-n800.c |   87 ++++++++++++++++++++++++++++++++++----
>  drivers/input/keyboard/lm8323.c  |   84 +++++++++++++++++++++++++++++++++----
>  include/linux/i2c/lm8323.h       |   12 ++----
>  3 files changed, 159 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> index ae85c2c..a654886 100644
> --- a/arch/arm/mach-omap2/board-n800.c
> +++ b/arch/arm/mach-omap2/board-n800.c
> @@ -51,7 +51,16 @@
>  #define N800_TSC2301_RESET_GPIO		118
>  
>  #ifdef CONFIG_MACH_NOKIA_N810
> -static s16 rx44_keymap[LM8323_KEYMAP_SIZE] = {
> +
> +/*
> + * Largest keycode that the chip can send, plus one,
> + * so keys can be mapped directly at the index of the
> + * LM8323 keycode instead of subtracting one.
> + */
> +#define N810_HWKEY_SZ			(0x7f + 1)
> +
> +/* Keymap for lm8323. Negative value means Shift + KEY */
> +static s16 rx44_keymap[N810_HWKEY_SZ * 2] = {
>  	[0x01] = KEY_Q,
>  	[0x02] = KEY_K,
>  	[0x03] = KEY_O,
> @@ -81,7 +90,7 @@ static s16 rx44_keymap[LM8323_KEYMAP_SIZE] = {
>  	[0x21] = KEY_E,
>  	[0x22] = KEY_SEMICOLON,
>  	[0x23] = KEY_MINUS,
> -	[0x24] = KEY_EQUAL,
> +	[0x24] = -KEY_EQUAL,
>  	[0x2b] = KEY_FN,
>  	[0x2c] = KEY_M,
>  	[0x2f] = KEY_F8,
> @@ -108,15 +117,77 @@ static s16 rx44_keymap[LM8323_KEYMAP_SIZE] = {
>  
>  	[0x71] = KEY_I,
>  	[0x75] = KEY_KPENTER,
> +
> +	/* End of hardware key map, Fn + key values below */
> +
> +	[0x01 + N810_HWKEY_SZ] = KEY_1,		/* Fn + KEY_Q */
> +	[0x02 + N810_HWKEY_SZ] = -KEY_0,		/* Fn + KEY_K */
> +	[0x03 + N810_HWKEY_SZ] = KEY_9,		/* Fn + KEY_O */
> +	[0x04 + N810_HWKEY_SZ] = KEY_0,		/* Fn + KEY_P */
> +	[0x05 + N810_HWKEY_SZ] = KEY_DELETE,	/* Fn + KEY_BACKSPACE */
> +	[0x06 + N810_HWKEY_SZ] = -KEY_1,		/* Fn + KEY_A */
> +	[0x07 + N810_HWKEY_SZ] = -KEY_APOSTROPHE,	/* Fn + KEY_S */
> +	[0x08 + N810_HWKEY_SZ] = -KEY_2,		/* Fn + KEY_D */
> +	[0x09 + N810_HWKEY_SZ] = -KEY_3,		/* Fn + KEY_F */
> +	[0x0a + N810_HWKEY_SZ] = KEY_BACKSLASH,	/* Fn + KEY_G */
> +	[0x0b + N810_HWKEY_SZ] = KEY_SLASH,	/* Fn + KEY_H */
> +	[0x0c + N810_HWKEY_SZ] = -KEY_9,		/* Fn + KEY_J */
> +
> +	[0x11 + N810_HWKEY_SZ] = KEY_2,		/* Fn + KEY_W */
> +	[0x12 + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_F4 */
> +	[0x13 + N810_HWKEY_SZ] = -KEY_8,		/* Fn + KEY_L */
> +	[0x14 + N810_HWKEY_SZ] = -KEY_SLASH,	/* Fn + KEY_APOSTROPHE */
> +	[0x16 + N810_HWKEY_SZ] = KEY_YEN,		/* Fn + KEY_Z */
> +	[0x17 + N810_HWKEY_SZ] = -KEY_6,		/* Fn + KEY_X */
> +	[0x18 + N810_HWKEY_SZ] = -KEY_GRAVE,	/* Fn + KEY_C */
> +	[0x19 + N810_HWKEY_SZ] = -KEY_5,		/* Fn + KEY_V */
> +	[0x1a + N810_HWKEY_SZ] = -KEY_7,		/* Fn + KEY_B */
> +	[0x1b + N810_HWKEY_SZ] = -KEY_4,		/* Fn + KEY_N */
> +	[0x1c + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_LEFTSHIFT */
> +	[0x1f + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_F7 */
> +
> +	[0x21 + N810_HWKEY_SZ] = KEY_3,		/* Fn + KEY_E */
> +	[0x22 + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_SEMICOLON */
> +	[0x23 + N810_HWKEY_SZ] = -KEY_MINUS,	/* Fn + KEY_MINUS */
> +	[0x24 + N810_HWKEY_SZ] = KEY_EQUAL,	/* Fn + -KEY_EQUAL */
> +	[0x2b + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_FN */
> +	[0x2c + N810_HWKEY_SZ] = KEY_EURO,		/* Fn + KEY_M */
> +	[0x2f + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_F8 */
> +
> +	[0x31 + N810_HWKEY_SZ] = KEY_4,		/* Fn + KEY_R */
> +	[0x32 + N810_HWKEY_SZ] = KEY_ESC,		/* Fn + KEY_RIGHTCTRL */
> +	[0x34 + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_SPACE */
> +	[0x35 + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_COMMA */
> +	[0x37 + N810_HWKEY_SZ] = KEY_PAGEUP,	/* Fn + KEY_UP */
> +	[0x3c + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_COMPOSE */
> +	[0x3f + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_F6 */
> +
> +	[0x41 + N810_HWKEY_SZ] = KEY_5,		/* Fn + KEY_T */
> +	[0x44 + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_DOT */
> +	[0x46 + N810_HWKEY_SZ] = KEY_TAB,		/* Fn + KEY_RIGHT */
> +	[0x4f + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_F5 */
> +	[0x51 + N810_HWKEY_SZ] = KEY_6,		/* Fn + KEY_Y */
> +	[0x53 + N810_HWKEY_SZ] = KEY_PAGEDOWN,	/* Fn + KEY_DOWN */
> +	[0x55 + N810_HWKEY_SZ] = -KEY_BACKSLASH,	/* Fn + KEY_ENTER */
> +	[0x5f + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_ESC */
> +
> +	[0x61 + N810_HWKEY_SZ] = KEY_7,		/* Fn + KEY_U */
> +	[0x64 + N810_HWKEY_SZ] = KEY_ESC,		/* Fn + KEY_LEFT */
> +
> +	[0x71 + N810_HWKEY_SZ] = KEY_8,		/* Fn + KEY_I */
> +	[0x75 + N810_HWKEY_SZ] = KEY_RESERVED,	/* Fn + KEY_KPENTER */
>  };
>  
>  static struct lm8323_platform_data lm8323_pdata = {
> -	.repeat = 0, /* Repeat is handled in userspace for now. */
> -	.keymap = rx44_keymap,
> -
> -	.name = "Internal keyboard",
> -	.pwm1_name = "keyboard",
> -	.pwm2_name = "cover",
> +	.repeat		= 1, /* Change to 0 if handled in userspace */
> +	.keymap		= rx44_keymap,
> +	.keymap_sz	= ARRAY_SIZE(rx44_keymap),
> +	.fn_key		= KEY_FN,
> +	.shift_key	= KEY_LEFTSHIFT,
> +
> +	.name		= "Internal keyboard",
> +	.pwm1_name	= "keyboard",
> +	.pwm2_name	= "cover",
>  };
>  #endif
>  
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index d472da0..485c19f 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -155,7 +155,19 @@ struct lm8323_chip {
>  	unsigned		pm_suspend : 1;
>  	unsigned		keys_down;
>  	char			phys[32];
> -	s16			keymap[LM8323_KEYMAP_SIZE];
> +
> +#define SHIFT_LOCKED		(1 << 5)
> +#define SHIFT_HELD		(1 << 4)
> +#define SHIFT_ONE		(1 << 3)
> +#define FN_LOCKED		(1 << 2)
> +#define FN_HELD			(1 << 1)
> +#define FN_ONE			(1 << 0)
> +	u8			sticky;
> +
> +	s16			*keymap;
> +	u16			keymap_sz;
> +	u16			fn_key;
> +	u16			shift_key;
>  	int			size_x;
>  	int			size_y;
>  	int			debounce_time;
> @@ -279,6 +291,41 @@ static inline int lm8323_ispress(u8 event)
>  	return (event & 0x80) ? 1 : 0;
>  }
>  
> +static inline u8 is_sticky(struct lm8323_chip *lm, s16 keycode, int isdown)
> +{
> +	if (isdown) {
> +		if (lm->fn_key && keycode == lm->fn_key) {
> +			if (lm->sticky & FN_LOCKED)
> +				lm->sticky = 0;
> +			else if (lm->sticky & FN_ONE)
> +				lm->sticky = FN_LOCKED;
> +			else
> +				lm->sticky = FN_HELD | FN_ONE;
> +			return 1;
> +		}
> +		if (lm->shift_key && keycode == lm->shift_key) {
> +			if (lm->sticky & SHIFT_LOCKED)
> +				lm->sticky = 0;
> +			else if (lm->sticky & SHIFT_ONE)
> +				lm->sticky = SHIFT_LOCKED;
> +			else
> +				lm->sticky = SHIFT_HELD | SHIFT_ONE;
> +			return 1;
> +		}
> +	} else {
> +		if (lm->fn_key && keycode == lm->fn_key) {
> +			lm->sticky &= ~FN_HELD;
> +			return 1;
> +		}
> +		if (lm->shift_key && keycode == lm->shift_key) {
> +			lm->sticky &= ~SHIFT_HELD;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void process_keys(struct lm8323_chip *lm)
>  {
>  	u8 event;
> @@ -300,10 +347,29 @@ static void process_keys(struct lm8323_chip *lm)
>  	key_fifo[ret] = 0;
>  
>  	while ((event = key_fifo[i])) {
> -		u8 key = lm8323_whichkey(event);
> +		u16 key = lm8323_whichkey(event);
>  		int isdown = lm8323_ispress(event);
>  		s16 keycode = lm->keymap[key];
>  
> +		if (is_sticky(lm, keycode, isdown)) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (lm->sticky & (FN_LOCKED | FN_HELD | FN_ONE)) {
> +			keycode = lm->keymap[key + (lm->keymap_sz / 2)];
> +			if (keycode < 0) {
> +				lm->sticky |= SHIFT_ONE;
> +				keycode = abs(keycode);
> +			}
> +		}
> +
> +		if (lm->sticky & (SHIFT_LOCKED | SHIFT_HELD | SHIFT_ONE))
> +			input_report_key(lm->idev, KEY_LEFTSHIFT, isdown);
> +
> +		if (lm->sticky && !isdown)
> +			lm->sticky &= ~(SHIFT_ONE | FN_ONE);
> +
>  		if (likely(keycode > 0)) {
>  			debug(&lm->client->dev, "key 0x%02x %s\n", key,
>  			      isdown ? "down" : "up");
> @@ -707,8 +773,12 @@ static int lm8323_probe(struct i2c_client *client,
>  				lm->size_y);
>  		lm->size_x = 12;
>  	}
> +	debug(&client->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
>  
> -	debug(&c->dev, "Keypad size: %d x %d\n", lm->size_x, lm->size_y);
> +	lm->keymap = lm8323_pdata->keymap;
> +	lm->keymap_sz = lm8323_pdata->keymap_sz;
> +	lm->fn_key = lm8323_pdata->fn_key;
> +	lm->shift_key = lm8323_pdata->shift_key;
>  
>  	lm->debounce_time = lm8323_pdata->debounce_time;
>  	if (lm->debounce_time == 0) /* Default. */
> @@ -789,11 +859,9 @@ static int lm8323_probe(struct i2c_client *client,
>  
>  	lm->keys_down = 0;
>  	idev->evbit[0] = BIT(EV_KEY);
> -	for (i = 0; i < LM8323_KEYMAP_SIZE; i++) {
> -		if (lm8323_pdata->keymap[i] > 0)
> -			set_bit(lm8323_pdata->keymap[i], idev->keybit);
> -
> -		lm->keymap[i] = lm8323_pdata->keymap[i];
> +	for (i = 0; i < lm->keymap_sz; i++) {
> +		if (lm->keymap[i] != 0)
> +			set_bit(abs(lm->keymap[i]), idev->keybit);
>  	}
>  
>  	if (lm8323_pdata->repeat)
> diff --git a/include/linux/i2c/lm8323.h b/include/linux/i2c/lm8323.h
> index 17d6b33..5ea6cef 100644
> --- a/include/linux/i2c/lm8323.h
> +++ b/include/linux/i2c/lm8323.h
> @@ -9,13 +9,6 @@
>  
>  #include <linux/types.h>
>  
> -/*
> - * Largest keycode that the chip can send, plus one,
> - * so keys can be mapped directly at the index of the
> - * LM8323 keycode instead of subtracting one.
> - */
> -#define LM8323_KEYMAP_SIZE (0x7f + 1)
> -
>  struct lm8323_platform_data {
>  	int debounce_time; /* Time to watch for key bouncing, in ms. */
>  	int active_time; /* Idle time until sleep, in ms. */
> @@ -23,7 +16,10 @@ struct lm8323_platform_data {
>  	int size_x;
>  	int size_y;
>  	int repeat : 1;
> -	const s16 *keymap;
> +	s16 *keymap;
> +	u16 keymap_sz;
> +	u16 fn_key;
> +	u16 shift_key;
>  
>  	char *pwm1_name; /* Device name for PWM1. */
>  	char *pwm2_name; /* Device name for PWM2. */
> -- 
> 1.5.3.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
