From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Mon, 10 May 2010 21:41:56 -0700
Message-ID: <20100511044156.GA21299@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <20100421065550.GL4364@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:56978 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0EKEmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 00:42:04 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, May 10, 2010 at 11:17:50PM -0500, Arce, Abraham wrote:
> Sorry for the confusion in your name Dmitry...
> 

No worries, although at first I was surprised that Trilok spoke exactly
the same words I did ;)

> Thanks for your comments...
> 
> [snip]
> 
> > > > +
> > > > +/* Interrupt thread handler thread */
> > > > +
> > > > +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> > > > +{
> > >
> > > Why is iti threaded? I fo not see anything that will sleep.
> 
> 
> It was implemented based on previous comments...
> 

Would you point me to that comment? Like I said, I do not see anything
that would possibly sleep in this routine so you don't need to use
threaded interrupt.

> 
> > > > +	struct omap_keypad *keypad_data = dev_id;
> > > > +	struct input_dev *input = keypad_data->input;
> > > > +	unsigned char key_state[8];
> > > > +	int col, row, code;
> > > > +	u32 *new_state = (u32 *) key_state;
> > > > +
> > > > +	*new_state	 = __raw_readl(keypad_data->base +
> > > > +			OMAP4_KBD_FULLCODE31_0);
> > > > +	*(new_state + 1) = __raw_readl(keypad_data->base +
> > > > +			OMAP4_KBD_FULLCODE63_32);
> > > > +
> > > > +	for (col = 0; col < keypad_data->cols; col++) {
> > > > +		for (row = 0; row < keypad_data->rows; row++) {
> > > > +			code = MATRIX_SCAN_CODE(row, col,
> > > > +					keypad_data->row_shift);
> > > > +			if (code < 0) {
> > > > +				printk(KERN_INFO "Spurious key %d-%d\n",
> > > > +						col, row);
> > > > +				continue;
> > > > +			}
> > >
> > > MATRIX_SCAN_CODE() is static data. ISR is wrong place to report
> > > incorrect values in keymap...
> 
> Removed
> 
> > > > +			input_report_key(input, keypad_data->keycodes[code],
> > > > +					key_state[col] & (1 << row));
> > > > +		}
> > > > +	}
> > > > +
> > > > +	memcpy(keypad_data->key_state, &key_state,
> > > > +			sizeof(keypad_data->key_state));
> > > > +
> > > > +	/* enable interrupts */
> > > > +	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
> > > > +			keypad_data->base + OMAP4_KBD_IRQENABLE);
> > > > +
> > > > +	/* clear pending interrupts */
> > > > +	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
> > > > +			keypad_data->base + OMAP4_KBD_IRQSTATUS);
> > > > +
> > > > +	/* clear pending interrupts */
> > > > +	return IRQ_HANDLED;
> > > > +
> > > > +}
> > > > +
> > > > +
> > > > +static int __devinit omap_keypad_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct omap_device *od;
> > > > +	struct omap_hwmod *oh;
> > > > +	struct matrix_keypad_platform_data *pdata;
> > > > +	struct input_dev *input_dev;
> > > > +	const struct matrix_keymap_data *keymap_data;
> > > > +	struct omap_keypad *keypad_data;
> > > > +
> > > > +	unsigned int status = 0, row_shift = 0, error = 0, length = 0, id = 0;
> > > > +	unsigned short *keypad_codes;
> > > > +
> > > > +	int hw_mod_name_len = 16;
> > > > +	char oh_name[hw_mod_name_len];
> > > > +	char *name = "omap4-keypad";
> > > > +
> > > > +	length = snprintf(oh_name, hw_mod_name_len, "keyboard");
> > > > +	WARN(length >= hw_mod_name_len,
> > > > +		"String buffer overflow in keyboard device setup\n");
> > > > +
> > > > +	oh = omap_hwmod_lookup(oh_name);
> > > > +	if (!oh)
> > > > +		pr_err("Could not look up %s\n", oh_name);
> > > > +
> > > > +	pdata = kzalloc(sizeof(struct matrix_keypad_platform_data),
> > > > +				GFP_KERNEL);
> > >
> > > Why is it allocated?
> 
> Moved to board file...
> 
> 
> > > > +
> > > > +	od = omap_device_build(name, id, oh, pdata,
> > > > +				sizeof(struct matrix_keypad_platform_data),
> > > > +				omap_keyboard_latency,
> > > > +				ARRAY_SIZE(omap_keyboard_latency), 1);
> > > > +	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
> > > > +		name, oh_name);
> > > > +
> > > > +	/* platform data */
> > > > +	pdata = pdev->dev.platform_data;
> > >
> > > Umm, here you are overriding pdata pointer... don't you leak memory
> > > doing this?
> 
> 
> hwmod has been moved to board configuration so we need to get platform data
> 
> > > > +	if (!pdata) {
> > > > +		dev_err(&pdev->dev, "no platform data defined\n");
> > > > +		kfree(pdata);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	/* keymap data */
> > > > +	keymap_data = pdata->keymap_data;
> > > > +	if (!keymap_data) {
> > > > +		dev_err(&pdev->dev, "no keymap data defined\n");
> > > > +		kfree(keymap_data);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	/* omap keypad data */
> > > > +	row_shift = get_count_order(pdata->num_col_gpios);
> > > > +	keypad_data = kzalloc(sizeof(struct omap_keypad), GFP_KERNEL);
> > > > +	if (!keypad_data) {
> > > > +		error = -ENOMEM;
> > > > +		goto failed_free_platform;
> > > > +	}
> > > > +
> > > > +	/* omap keypad codes */
> > > > +	keypad_codes = kzalloc((pdata->num_row_gpios << row_shift) *
> > > > +			sizeof(*keypad_codes), GFP_KERNEL);
> > >
> > > Why is it al;loctaed separately? Can it be pickky-backed onto
> > > keypad_data?
>  
> Not getting the idea here... could you explain?

Do something like

struct omap_keypad {
	...
	unsigned short keymap[];
};

and then

	keypad_data = kzalloc(sizeof(struct omap_keypad) +
				(pdata->num_row_gpios << row_shift) *
				sizeof(unsigned short),
				GFP_KERNEL);

Or, depending on the max allowed keymap size, just embed array of
maximum possible size into struct omap_keypad..

>  
> > > > +	if (!keypad_codes) {
> > > > +		error = -ENOMEM;
> > > > +		goto failed_free_data;
> > > > +	}
> > > > +
> > > > +	/* input device allocation */
> > > > +	input_dev = input_allocate_device();
> > > > +	if (!input_dev) {
> > > > +		error = -ENOMEM;
> > > > +		goto failed_free_codes;
> > > > +	}
> > > > +
> > > > +	/* base resource */
> > > > +	keypad_data->base = oh->_rt_va;
> > > > +	if (!keypad_data->base) {
> > >
> > >
> > > You could probably check this earlier, before allocating stuff.
> 
> Early means before input_allocate_device?
> 

Yes. Check data before allocating resources.

> 
> > > > +		error = -ENOMEM;
> > > > +		goto failed_free_input;
> > > > +	}
> > > > +
> > > > +	/* irq */
> > > > +	keypad_data->irq = oh->mpu_irqs[0].irq;
> > > > +	if (keypad_data->irq < 0) {
> > >
> > > You could probably check this earlier, before allocating stuff.
> 
> Early means before input_allocate_device?
> 

Yes.

> > > > +		dev_err(&pdev->dev, "no keyboard irq assigned\n");
> > > > +		error = keypad_data->irq;
> > > > +		goto failed_free_base;
> > > > +	}
> > > > +
> > > > +	/* threaded irq init */
> > > > +	status = request_threaded_irq(keypad_data->irq, omap_keypad_interrupt,
> > > > +			omap_keypad_threaded,
> > > > +				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > > > +			"omap4-keypad", keypad_data);
> > > > +	if (status) {
> > > > +		dev_err(&pdev->dev, "failed to register interrupt\n");
> > > > +		error = -ENOMEM;
> > > > +		goto failed_free_irq;
> > > > +	}
> > > > +
> > > > +	keypad_data->input = input_dev;
> > > > +	keypad_data->row_shift = row_shift;
> > > > +	keypad_data->rows = pdata->num_row_gpios;
> > > > +	keypad_data->cols = pdata->num_col_gpios;
> > > > +	keypad_data->keycodes = keypad_codes;
> > > > +
> > > > +	input_dev->name = pdev->name;
> > > > +	input_dev->id.bustype = BUS_HOST;
> > > > +	input_dev->dev.parent = &pdev->dev;
> > > > +	input_dev->id.vendor = 0x0001;
> > > > +	input_dev->id.product = 0x0001;
> > > > +	input_dev->id.version = 0x0100;
> > > > +
> > > > +	input_dev->keycode	= keypad_codes;
> > > > +	input_dev->keycodesize	= sizeof(*keypad_codes);
> > >
> > > You also need keycodemax so that keymap can be changed from userpsace.
>  
> Added!
> 
> > >
> > > > +
> > > > +	matrix_keypad_build_keymap(keymap_data, row_shift,
> > > > +				   input_dev->keycode, input_dev->keybit);
> > > > +
> > > > +	__set_bit(EV_REP, input_dev->evbit);
> > > > +	__set_bit(KEY_OK, input_dev->keybit);
> > >
> > > Why KEY_OK is set up separately?
>  
> In previous implementation manual set of bit was needed, now removed...
>  
> > >
> > > > +	__set_bit(EV_KEY, input_dev->evbit);
> > > > +
> > > > +	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> > >
> > > You forgot to actualy report MSC_SCAN though.
>  
> Should I remove it? I think I do need it only when KEY_UNKNOWN keys will be
> remapped, right?

I'd rather you actually report EV_MSC/MSC_SCAN.

>  
> > >
> > > > +	input_set_drvdata(input_dev, keypad_data);
> > > > +
> > > > +	status = input_register_device(keypad_data->input);
> > > > +	if (status < 0) {
> > > > +		dev_err(&pdev->dev, "failed to register input device\n");
> > > > +		goto failed_free_device;
> > > > +	}
> > > > +
> > > > +	omap_keypad_config(keypad_data);
> > > > +
> > > > +	platform_set_drvdata(pdev, keypad_data);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +failed_free_device:
> > > > +	input_unregister_device(keypad_data->input);
> > >
> > > 	input_dev = NULL;
> > >
> > > or you will try to free it later.
>  
> Not getting the idea here... could you explain?

It is not allowed to call input_free_device() after
input_unregister_device() due to the fact that input devices are
fercounted and you'd cause refcount underrun and potentially
double-free. However input_free_device() is happy to accept NULL as an
argument to it is a common way to handle the problem whike having
streamlined error handling path.

>  
> > > > +failed_free_irq:
> > > > +	free_irq(keypad_data->irq, pdev);
> > > > +failed_free_base:
> > > > +	keypad_data->base = NULL;
> > > > +failed_free_input:
> > > > +	input_free_device(input_dev);
> > > > +failed_free_codes:
> > > > +	kfree(keypad_codes);
> > > > +failed_free_data:
> > > > +	kfree(keypad_data);
> > > > +failed_free_platform:
> > > > +	kfree(keymap_data);
> > > > +	kfree(pdata);
> > > > +	return error;
> > > > +}
> > > > +
> > > > +static int __devexit omap_keypad_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct omap_keypad *keypad_data = platform_get_drvdata(pdev);
> > > > +
> > > > +	input_unregister_device(keypad_data->input);
> > > > +	free_irq(keypad_data->irq, keypad_data);
> > >
> > > Thsi should happen before unregistering input device, othersie there is
> > > a change IRQ will arrive when input device is freed.
>  
> Done!
>   

Thanks for making the changes.

-- 
Dmitry
