From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
Date: Fri, 06 Apr 2012 18:56:41 +0530
Message-ID: <4F7EEF11.7050200@ti.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:44017 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754921Ab2DFN0v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Apr 2012 09:26:51 -0400
Received: by pbcup15 with SMTP id up15so2438792pbc.28
        for <linux-omap@vger.kernel.org>; Fri, 06 Apr 2012 06:26:50 -0700 (PDT)
In-Reply-To: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com

 Hi Sourav,
Some suggestions/ doubts.

On Tuesday 03 April 2012 10:52 AM, Sourav Poddar wrote:
> From: G, Manjunath Kondaiah <manjugk@ti.com>
>
> Keypad controller register offsets are different for omap4
> and omap5. Handle these offsets through static mapping and
> assign these mappings during run time.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> Test Info
>  - Tested on omap4 sdp with 3.4-rc1
>  - Tested on omap5430evm with 3.1 custom kernel.
>  drivers/input/keyboard/Kconfig        |    6 +-
>  drivers/input/keyboard/omap4-keypad.c |  120 ++++++++++++++++++++++++++------
>  2 files changed, 100 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index f354813..9a0e1a9 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -511,10 +511,10 @@ config KEYBOARD_OMAP
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called omap-keypad.
>  
> -config KEYBOARD_OMAP4
> -	tristate "TI OMAP4 keypad support"
> +config KEYBOARD_OMAP4+
> +	tristate "TI OMAP4+ keypad support"
>  	help
> -	  Say Y here if you want to use the OMAP4 keypad.
> +	  Say Y here if you want to use the OMAP4+ keypad.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called omap4-keypad.
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index e809ac0..742e1e3 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -68,6 +68,11 @@
>  
>  #define OMAP4_MASK_IRQSTATUSDISABLE	0xFFFF
>  
> +enum {
> +	KBD_REVISION_OMAP4 = 0,
> +	KBD_REVISION_OMAP5,
> +};
> +
>  struct omap4_keypad {
>  	struct input_dev *input;
>  
> @@ -76,11 +81,66 @@ struct omap4_keypad {
>  
>  	unsigned int rows;
>  	unsigned int cols;
> +	unsigned int revision;
> +	u32 irqstatus;
> +	u32 irqenable;
>  	unsigned int row_shift;
>  	unsigned char key_state[8];
>  	unsigned short keymap[];
>  };
>  
> +static int kbd_read_irqstatus(struct omap4_keypad *keypad_data, u32 offset)
> +{
> +	return __raw_readl(keypad_data->base + offset);
> +}
> +
> +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
> +						u32 offset, u32 value)
> +{
> +	return __raw_writel(value, keypad_data->base + offset);
> +}
> +
> +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
> +						u32 offset, u32 value)
> +{
> +	return __raw_writel(value, keypad_data->base + offset);
> +}
The functions

kbd_write_irqenable and kbd_write_irqstatus look identical.
Could we optimise it? 
 
Feel free to ignore such trivial comments.

> +
> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> +{
> +	if (keypad_data->revision == KBD_REVISION_OMAP4)
> +		return __raw_readl(keypad_data->base + offset);
> +	else if (keypad_data->revision == KBD_REVISION_OMAP5)
> +		return __raw_readl(keypad_data->base + offset + 0x10);
> +
> +	return -ENODEV;
> +}
> +
> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u32 value)
> +{
> +	if (keypad_data->revision == KBD_REVISION_OMAP4)
> +		__raw_writel(value, keypad_data->base + offset);
> +	else if (keypad_data->revision == KBD_REVISION_OMAP5)
> +		__raw_writel(value, keypad_data->base + offset + 0x10);
> +}
> +
> +static int kbd_read_revision(struct omap4_keypad *keypad_data, u32 offset)
> +{
> +	int reg;
Can this be unsigned?

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
In the error case a negative value is returned.
Could we prevent writing in that cases.
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
> +	if (keypad_data->revision == KBD_REVISION_OMAP4) {
> +		keypad_data->irqstatus = OMAP4_KBD_IRQSTATUS;
> +		keypad_data->irqenable = OMAP4_KBD_IRQENABLE;
> +	} else if (keypad_data->revision == KBD_REVISION_OMAP5) {
> +		keypad_data->irqstatus = OMAP4_KBD_IRQSTATUS + 0x0c;
> +		keypad_data->irqenable = OMAP4_KBD_IRQENABLE + 0x0c;
> +	} else {
> +		pr_err("Omap keypad not found\n");
> +		return -ENODEV;
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

