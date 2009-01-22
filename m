From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Thu, 22 Jan 2009 09:42:49 -0800
Message-ID: <200901220942.50252.david-b@pacbell.net>
References: <200901211613.06427.david-b@pacbell.net> <5d5443650901212309u10bdbf46pb76950f49fc7cebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:24644 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753940AbZAVRmx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Jan 2009 12:42:53 -0500
In-Reply-To: <5d5443650901212309u10bdbf46pb76950f49fc7cebb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

Hi,

On Wednesday 21 January 2009, Trilok Soni wrote:
> > +
> > +static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all)
> > +{
> > +       u16 new_state[MAX_ROWS];
> > +       int col, row;
> > +
> > +       ...
> > +
> > +                       key = twl4030_find_key(kp, col, row);
> > +                       if (key < 0)
> > +                               dev_warn(kp->dbg_dev,
> > +                                       "Spurious key event %d-%d\n",
> > +                                        col, row);
> > +                       else if (key & KEY_PERSISTENT)
> > +                               continue;
> > +                       else
> > +                               input_report_key(kp->input, key,
> > +                                                new_state[row] & (1 << col));
> > +               }
> > +               kp->kp_state[row] = new_state[row];
> > +       }
> 
> where do I find input_sync(...) being called?

Yeah, I was wondering about that too.  The code
obviously works without it ... I'll add that call
anyway.


> > +
> > +       dev_set_drvdata(&pdev->dev, kp);
> 
> How about platform_set_drvdata ??

Those calls are exactly equivalent, although you're
right that platform_* versions are preferred.  Either
is correct.


> > +       /* setup input device */
> > +       set_bit(EV_KEY, kp->input->evbit);
> 
> __set_bit please.
> 
> > +
> > +       /* Enable auto repeat feature of Linux input subsystem */
> > +       if (pdata->rep)
> > +               set_bit(EV_REP, kp->input->evbit);
> > +
> > +       for (i = 0; i < kp->keymapsize; i++)
> > +               set_bit(kp->keymap[i] & KEYNUM_MASK,
> > +                               kp->input->keybit);
> 
> Ditto.

The practical difference there being that __set_bit() is
a bit less costly (space and time), being non-atomic; there
is no semantic difference.  Either is correct.


> > +       /*
> > +        * This ISR will always execute in kernel thread context because of
> > +        * the need to access the TWL4030 over the I2C bus.
> > +        *
> > +        * NOTE:  we assume this host is wired to TWL4040 INT1, not INT2 ...
> > +        */
> > +       ret = request_irq(kp->irq, do_kp_irq, 0, pdev->name, kp);
> 
> How about adding IRQF_SAMPLE_RANDOME here ??

Input system does that automagically; it should not be
sampled twice.


> > +err5:
> > +       /* mask all events - we don't care about the result */
> > +       (void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
> > +       free_irq(kp->irq, NULL);
> > +err3:
> > +       input_unregister_device(kp->input);
> 
> No free_device after input_unregister_device. Add kp->input = NULL above.
> 
> > +err2:
> > +       input_free_device(kp->input);

and kfree(kp) was missing too ...

I'll merge the following with any other feedback.

- Dave

---
 drivers/input/keyboard/twl4030_keypad.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -260,6 +260,7 @@ static void twl4030_kp_scan(struct twl40
 		}
 		kp->kp_state[row] = new_state[row];
 	}
+	input_sync(kp->input);
 }
 
 /*
@@ -316,7 +317,7 @@ static int __devinit twl4030_kp_probe(st
 
 	/* ASSERT:  cols <= 8, rows <= 8 */
 
-	dev_set_drvdata(&pdev->dev, kp);
+	platform_set_drvdata(pdev, kp);
 
 	/* Get the debug Device */
 	kp->dbg_dev = &pdev->dev;
@@ -334,14 +335,14 @@ static int __devinit twl4030_kp_probe(st
 	kp->irq = platform_get_irq(pdev, 0);
 
 	/* setup input device */
-	set_bit(EV_KEY, kp->input->evbit);
+	__set_bit(EV_KEY, kp->input->evbit);
 
 	/* Enable auto repeat feature of Linux input subsystem */
 	if (pdata->rep)
-		set_bit(EV_REP, kp->input->evbit);
+		__set_bit(EV_REP, kp->input->evbit);
 
 	for (i = 0; i < kp->keymapsize; i++)
-		set_bit(kp->keymap[i] & KEYNUM_MASK,
+		__set_bit(kp->keymap[i] & KEYNUM_MASK,
 				kp->input->keybit);
 
 	kp->input->name	= "TWL4030 Keypad";
@@ -441,15 +442,16 @@ err5:
 	free_irq(kp->irq, NULL);
 err3:
 	input_unregister_device(kp->input);
+	kp->input = NULL;
 err2:
 	input_free_device(kp->input);
-
+	kfree(kp);
 	return -ENODEV;
 }
 
 static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 {
-	struct twl4030_keypad *kp = dev_get_drvdata(&pdev->dev);
+	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
 
 	free_irq(kp->irq, kp);
 	input_unregister_device(kp->input);

