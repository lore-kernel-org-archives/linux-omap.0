From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
Date: Tue, 10 Apr 2012 09:23:54 -0700
Message-ID: <20120410162353.GA6217@core.coreip.homeip.net>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39641 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2DJQX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 12:23:58 -0400
Content-Disposition: inline
In-Reply-To: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com

Hi Sourav,

On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
> From: G, Manjunath Kondaiah <manjugk@ti.com>
> 
> Keypad controller register offsets are different for omap4
> and omap5. Handle these offsets through static mapping and
> assign these mappings during run time.
> 

In addition to Felipe's comments.

> @@ -76,11 +81,66 @@ struct omap4_keypad {
>  
>  	unsigned int rows;
>  	unsigned int cols;
> +	unsigned int revision;
> +	u32 irqstatus;
> +	u32 irqenable;

	u32 reg_offset;

and you probably won't need revision field.

>  	unsigned int row_shift;
>  	unsigned char key_state[8];
>  	unsigned short keymap[];
>  };
>  
> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> +{
> +	if (keypad_data->revision == KBD_REVISION_OMAP4)
> +		return __raw_readl(keypad_data->base + offset);
> +	else if (keypad_data->revision == KBD_REVISION_OMAP5)
> +		return __raw_readl(keypad_data->base + offset + 0x10);
> +
> +	return -ENODEV;

Instead do:

	return __raw_readl(keypad_data->base + keypad_data->reg_offset +
			   offset);
> +}
> +
> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u32 value)
> +{
> +	if (keypad_data->revision == KBD_REVISION_OMAP4)
> +		__raw_writel(value, keypad_data->base + offset);
> +	else if (keypad_data->revision == KBD_REVISION_OMAP5)
> +		__raw_writel(value, keypad_data->base + offset + 0x10);

	__raw_writel(value,
		     keypad_data->base + keypad_data->reg_offset + offset);

> +}
> +
> +static int kbd_read_revision(struct omap4_keypad *keypad_data, u32 offset)
> +{
> +	int reg;
> +	reg = __raw_readl(keypad_data->base + offset);
> +	reg &= 0x03 << 30;
> +	reg >>= 30;
> +
> +	switch (reg) {
> +	case 1:
> +		return KBD_REVISION_OMAP5;
> +	case 0:
> +		return KBD_REVISION_OMAP4;
> +	default:
> +		return -ENODEV;

-EINVAL? -EIO?

> +	}
> +}
> +
>  /* Interrupt handler */
>  static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>  {
> @@ -91,12 +151,11 @@ static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>  	u32 *new_state = (u32 *) key_state;
>  
>  	/* Disable interrupts */
> -	__raw_writel(OMAP4_VAL_IRQDISABLE,
> -		     keypad_data->base + OMAP4_KBD_IRQENABLE);
> +	kbd_write_irqenable(keypad_data, keypad_data->irqenable,
> +			OMAP4_VAL_IRQDISABLE);
>  
> -	*new_state = __raw_readl(keypad_data->base + OMAP4_KBD_FULLCODE31_0);
> -	*(new_state + 1) = __raw_readl(keypad_data->base
> -						+ OMAP4_KBD_FULLCODE63_32);
> +	*new_state = kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31_0);
> +	*(new_state + 1) = kbd_readl(keypad_data, OMAP4_KBD_FULLCODE63_32);
>  
>  	for (row = 0; row < keypad_data->rows; row++) {
>  		changed = key_state[row] ^ keypad_data->key_state[row];
> @@ -121,12 +180,13 @@ static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>  		sizeof(keypad_data->key_state));
>  
>  	/* clear pending interrupts */
> -	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
> -			keypad_data->base + OMAP4_KBD_IRQSTATUS);
> +	kbd_write_irqstatus(keypad_data, keypad_data->irqstatus,
> +		kbd_read_irqstatus(keypad_data, keypad_data->irqstatus));
>  
>  	/* enable interrupts */
> -	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
> -			keypad_data->base + OMAP4_KBD_IRQENABLE);
> +	kbd_write_irqenable(keypad_data, keypad_data->irqenable,
> +		OMAP4_DEF_IRQENABLE_EVENTEN |
> +			OMAP4_DEF_IRQENABLE_LONGKEY);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -139,16 +199,30 @@ static int omap4_keypad_open(struct input_dev *input)
>  
>  	disable_irq(keypad_data->irq);
>  
> -	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
> -			keypad_data->base + OMAP4_KBD_CTRL);
> -	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
> -			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
> -	__raw_writel(OMAP4_VAL_IRQDISABLE,
> -			keypad_data->base + OMAP4_KBD_IRQSTATUS);
> -	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
> -			keypad_data->base + OMAP4_KBD_IRQENABLE);
> -	__raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA,
> -			keypad_data->base + OMAP4_KBD_WAKEUPENABLE);
> +	keypad_data->revision = kbd_read_revision(keypad_data,
> +			OMAP4_KBD_REVISION);

	switch()
> +	if (keypad_data->revision == KBD_REVISION_OMAP4) {
> +		keypad_data->irqstatus = OMAP4_KBD_IRQSTATUS;
> +		keypad_data->irqenable = OMAP4_KBD_IRQENABLE;
> +	} else if (keypad_data->revision == KBD_REVISION_OMAP5) {
> +		keypad_data->irqstatus = OMAP4_KBD_IRQSTATUS + 0x0c;
> +		keypad_data->irqenable = OMAP4_KBD_IRQENABLE + 0x0c;
> +	} else {
> +		pr_err("Omap keypad not found\n");
> +		return -ENODEV;

Hmm, this is in open() but should probably be in probe().

> +	}
> +
> +	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
> +			OMAP4_VAL_FUNCTIONALCFG);
> +	kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
> +			OMAP4_VAL_DEBOUNCINGTIME);
> +	kbd_write_irqstatus(keypad_data, keypad_data->irqstatus,
> +			OMAP4_VAL_IRQDISABLE);
> +	kbd_write_irqenable(keypad_data, keypad_data->irqenable,
> +			OMAP4_DEF_IRQENABLE_EVENTEN |
> +				OMAP4_DEF_IRQENABLE_LONGKEY);
> +	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
> +			OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA);
>  
>  	enable_irq(keypad_data->irq);
>  
> @@ -162,12 +236,12 @@ static void omap4_keypad_close(struct input_dev *input)
>  	disable_irq(keypad_data->irq);
>  
>  	/* Disable interrupts */
> -	__raw_writel(OMAP4_VAL_IRQDISABLE,
> -		     keypad_data->base + OMAP4_KBD_IRQENABLE);
> +	kbd_write_irqenable(keypad_data, keypad_data->irqenable,
> +			OMAP4_VAL_IRQDISABLE);
>  
>  	/* clear pending interrupts */
> -	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
> -			keypad_data->base + OMAP4_KBD_IRQSTATUS);
> +	kbd_write_irqstatus(keypad_data, keypad_data->irqstatus,
> +		kbd_read_irqstatus(keypad_data, keypad_data->irqstatus));
>  
>  	enable_irq(keypad_data->irq);
>  

Thanks.

-- 
Dmitry
