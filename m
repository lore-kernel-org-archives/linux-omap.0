From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Thu, 22 Jan 2009 12:39:24 +0530
Message-ID: <5d5443650901212309u10bdbf46pb76950f49fc7cebb@mail.gmail.com>
References: <200901211613.06427.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:56159 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbZAVHJZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 02:09:25 -0500
In-Reply-To: <200901211613.06427.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

Hi David,

> +
> +static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all)
> +{
> +       u16 new_state[MAX_ROWS];
> +       int col, row;
> +
> +       if (release_all)
> +               memset(new_state, 0, sizeof(new_state));
> +       else {
> +               /* check for any changes */
> +               int ret = twl4030_read_kp_matrix_state(kp, new_state);
> +
> +               if (ret < 0)    /* panic ... */
> +                       return;
> +               if (twl4030_is_in_ghost_state(kp, new_state))
> +                       return;
> +       }
> +
> +       /* check for changes and print those */
> +       for (row = 0; row < kp->n_rows; row++) {
> +               int changed = new_state[row] ^ kp->kp_state[row];
> +
> +               if (!changed)
> +                       continue;
> +
> +               for (col = 0; col < kp->n_cols; col++) {
> +                       int key;
> +
> +                       if (!(changed & (1 << col)))
> +                               continue;
> +
> +                       dev_dbg(kp->dbg_dev, "key [%d:%d] %s\n", row, col,
> +                               (new_state[row] & (1 << col)) ?
> +                               "press" : "release");
> +
> +                       key = twl4030_find_key(kp, col, row);
> +                       if (key < 0)
> +                               dev_warn(kp->dbg_dev,
> +                                       "Spurious key event %d-%d\n",
> +                                        col, row);
> +                       else if (key & KEY_PERSISTENT)
> +                               continue;
> +                       else
> +                               input_report_key(kp->input, key,
> +                                                new_state[row] & (1 << col));
> +               }
> +               kp->kp_state[row] = new_state[row];
> +       }

where do I find input_sync(...) being called?

> +
> +/*
> + * Registers keypad device with input subsystem
> + * and configures TWL4030 keypad registers
> + */
> +static int __devinit twl4030_kp_probe(struct platform_device *pdev)
> +{
> +       u8 reg;
> +       int i;
> +       int ret = 0;
> +       struct twl4030_keypad *kp;
> +       struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
> +
> +       kp = kzalloc(sizeof(*kp), GFP_KERNEL);
> +       if (!kp)
> +               return -ENOMEM;
> +
> +       if (!pdata->rows || !pdata->cols || !pdata->keymap) {
> +               dev_err(&pdev->dev, "No rows, cols or keymap from pdata\n");
> +               kfree(kp);
> +               return -EINVAL;
> +       }
> +
> +       /* ASSERT:  cols <= 8, rows <= 8 */
> +
> +       dev_set_drvdata(&pdev->dev, kp);

How about platform_set_drvdata ??

> +
> +       /* Get the debug Device */
> +       kp->dbg_dev = &pdev->dev;
> +
> +       kp->input = input_allocate_device();
> +       if (!kp->input) {
> +               kfree(kp);
> +               return -ENOMEM;
> +       }
> +
> +       kp->keymap = pdata->keymap;
> +       kp->keymapsize = pdata->keymapsize;
> +       kp->n_rows = pdata->rows;
> +       kp->n_cols = pdata->cols;
> +       kp->irq = platform_get_irq(pdev, 0);
> +
> +       /* setup input device */
> +       set_bit(EV_KEY, kp->input->evbit);

__set_bit please.

> +
> +       /* Enable auto repeat feature of Linux input subsystem */
> +       if (pdata->rep)
> +               set_bit(EV_REP, kp->input->evbit);
> +
> +       for (i = 0; i < kp->keymapsize; i++)
> +               set_bit(kp->keymap[i] & KEYNUM_MASK,
> +                               kp->input->keybit);

Ditto.

> +
> +       kp->input->name = "TWL4030 Keypad";
> +       kp->input->phys = "twl4030_keypad/input0";
> +       kp->input->dev.parent   = &pdev->dev;
> +
> +       kp->input->id.bustype   = BUS_HOST;
> +       kp->input->id.vendor    = 0x0001;
> +       kp->input->id.product   = 0x0001;
> +       kp->input->id.version   = 0x0003;
> +
> +       kp->input->keycode      = kp->keymap;
> +       kp->input->keycodesize  = sizeof(unsigned int);
> +       kp->input->keycodemax   = kp->keymapsize;
> +
> +       ret = input_register_device(kp->input);
> +       if (ret < 0) {
> +               dev_err(kp->dbg_dev,
> +                       "Unable to register twl4030 keypad device\n");
> +               goto err2;
> +       }

> +
> +       /*
> +        * This ISR will always execute in kernel thread context because of
> +        * the need to access the TWL4030 over the I2C bus.
> +        *
> +        * NOTE:  we assume this host is wired to TWL4040 INT1, not INT2 ...
> +        */
> +       ret = request_irq(kp->irq, do_kp_irq, 0, pdev->name, kp);

How about adding IRQF_SAMPLE_RANDOME here ??

> +       if (ret < 0) {
> +               dev_info(kp->dbg_dev, "request_irq failed for irq no=%d\n",
> +                       kp->irq);
> +               goto err3;
> +       } else {
> +               /* Enable KP and TO interrupts now. */
> +               reg = (u8) ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
> +               ret = twl4030_kpwrite_u8(kp, reg, KEYP_IMR1);
> +               if (ret < 0)
> +                       goto err5;
> +       }
> +
> +       return ret;
> +err5:
> +       /* mask all events - we don't care about the result */
> +       (void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
> +       free_irq(kp->irq, NULL);
> +err3:
> +       input_unregister_device(kp->input);

No free_device after input_unregister_device. Add kp->input = NULL above.

> +err2:
> +       input_free_device(kp->input);
> +
> +       return -ENODEV;
> +}
> +
> +static int __devexit twl4030_kp_remove(struct platform_device *pdev)
> +{
> +       struct twl4030_keypad *kp = dev_get_drvdata(&pdev->dev);

platform_get_drvdata ?

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
