From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv5] Input: keypad: Add smsc ece1099 keypad driver
Date: Mon, 29 Oct 2012 10:06:33 -0700
Message-ID: <20121029170633.GA11558@core.coreip.homeip.net>
References: <1351507129-10229-1-git-send-email-sourav.poddar@ti.com>
 <20121029162045.GK27566@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121029162045.GK27566-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 29, 2012 at 06:20:45PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Oct 29, 2012 at 04:08:49PM +0530, Sourav Poddar wrote:
> > +static int __devinit
> > +smsc_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct input_dev *input;
> > +	struct smsc_keypad *kp;
> > +	int ret = 0;
> > +	int i, max_keys, row_shift;
> > +	int irq;
> > +	int addr;
> > +
> > +	kp = devm_kzalloc(dev, sizeof(*kp), GFP_KERNEL);
> > +
> > +	input = devm_input_allocate_device(dev);
> > +	if (!kp || !input)
> > +		ret = -ENOMEM;
> > +
> > +	ret = smsc_keypad_parse_dt(dev, kp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Get the debug Device */
> > +	kp->input = input;
> > +	kp->irq = platform_get_irq(pdev, 0);
> > +	kp->dev = dev;
> > +
> > +	/* setup input device */
> > +	 __set_bit(EV_KEY, input->evbit);
> > +
> > +	/* Enable auto repeat feature of Linux input subsystem */
> > +	if (!kp->no_autorepeat)
> > +		__set_bit(EV_REP, input->evbit);
> > +
> > +	input_set_capability(input, EV_MSC, MSC_SCAN);
> > +	input->name             = "SMSC Keypad";
> > +	input->phys             = "smsc_keypad/input0";
> > +	input->dev.parent       = &pdev->dev;
> > +	input->id.bustype       = BUS_HOST;
> > +	input->id.vendor        = 0x0001;
> > +	input->id.product       = 0x0001;
> > +	input->id.version       = 0x0003;
> > +
> > +	input->open = smsc_keypad_open;
> > +	input->close = smsc_keypad_close;
> > +	input_set_drvdata(input, kp);
> > +
> > +	/* Mask all GPIO interrupts (0x37-0x3B) */
> > +	for (addr = SMSC_GPIO_INT_MASK_START;
> > +			addr < SMSC_GPIO_INT_MASK_START + 4; addr++)
> > +		smsc_write(dev, addr, 0);
> > +
> > +	/* Set all outputs high (0x05-0x09) */
> > +	for (addr = SMSC_GPIO_DATA_OUT_START;
> > +			addr < SMSC_GPIO_DATA_OUT_START + 4; addr++)
> > +		smsc_write(dev, addr, 0xff);
> > +
> > +	/* Clear all GPIO interrupts (0x32-0x36) */
> > +	for (addr = SMSC_GPIO_INT_STAT_START;
> > +			addr < SMSC_GPIO_INT_STAT_START + 4; addr++)
> > +		smsc_write(dev, addr, 0xff);
> > +
> > +	/* Configure the smsc pins as Keyboard scan Input */
> > +	for (i = 0; i < kp->rows; i++) {
> > +		addr = 0x12 + i;
> > +		smsc_write(dev, addr, SMSC_KP_KSI);
> > +	}
> > +
> > +	/* Configure the smsc pins as Keyboard scan output */
> > +	for (i = 0; i < kp->cols; i++) {
> > +		addr = 0x1a + i;
> > +		smsc_write(dev, addr, SMSC_KP_KSO);
> > +	}
> > +
> > +	smsc_write(dev, SMSC_KP_INT_STAT, SMSC_KP_SET_HIGH);
> > +	smsc_write(dev, SMSC_WKUP_CTRL, SMSC_KP_SET_LOW_PWR);
> > +	smsc_write(dev, SMSC_KP_OUT, SMSC_KSO_ALL_LOW);
> > +
> > +	row_shift = get_count_order(kp->cols);
> > +	max_keys = kp->rows << row_shift;
> > +
> > +	kp->row_shift = row_shift;
> > +	kp->keymap = devm_kzalloc(dev, max_keys * sizeof(kp->keymap[0]),
> > +					GFP_KERNEL);
> > +	if (!kp->keymap) {
> > +		dev_err(dev, "Not enough memory for keymap\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = matrix_keypad_build_keymap(NULL, NULL, kp->rows,
> > +			kp->cols, kp->keymap, input);
> > +	if (ret) {
> > +		dev_err(dev, "failed to build keymap\n");
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	* This ISR will always execute in kernel thread context because of
> > +	* the need to access the SMSC over the I2C bus.
> > +	*/
> > +	ret = devm_request_threaded_irq(dev, kp->irq, NULL, do_kp_irq,
> > +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT, pdev->name, kp);
> > +	if (ret) {
> > +		dev_dbg(dev, "request_irq failed for irq no=%d\n",
> > +			irq);
> > +		return ret;
> > +	}
> > +
> > +	ret = input_register_device(input);
> > +	if (ret) {
> > +		dev_err(kp->dev,
> > +			"Unable to register twl4030 keypad device\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __devexit smsc_remove(struct platform_device *pdev)
> > +{
> 
> shouldn't you unregister the input device here ??

And that is why I do not like devm_* interface myself... But no, since
input device was allocated with devm_input_allocate_device() it does not
need to be explicitly freed or unregistered.

Thanks.

-- 
Dmitry
