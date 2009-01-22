From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Thu, 22 Jan 2009 23:27:30 +0530
Message-ID: <5d5443650901220957i1852982sadc2baf77223decb@mail.gmail.com>
References: <200901211613.06427.david-b@pacbell.net>
	 <5d5443650901212309u10bdbf46pb76950f49fc7cebb@mail.gmail.com>
	 <200901220942.50252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <200901220942.50252.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi David,

On Thu, Jan 22, 2009 at 11:12 PM, David Brownell <david-b@pacbell.net> wrote:
> Hi,
>
>
> ---
>  drivers/input/keyboard/twl4030_keypad.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -260,6 +260,7 @@ static void twl4030_kp_scan(struct twl40
>                }
>                kp->kp_state[row] = new_state[row];
>        }
> +       input_sync(kp->input);
>  }
>
>  /*
> @@ -316,7 +317,7 @@ static int __devinit twl4030_kp_probe(st
>
>        /* ASSERT:  cols <= 8, rows <= 8 */
>
> -       dev_set_drvdata(&pdev->dev, kp);
> +       platform_set_drvdata(pdev, kp);
>
>        /* Get the debug Device */
>        kp->dbg_dev = &pdev->dev;
> @@ -334,14 +335,14 @@ static int __devinit twl4030_kp_probe(st
>        kp->irq = platform_get_irq(pdev, 0);
>
>        /* setup input device */
> -       set_bit(EV_KEY, kp->input->evbit);
> +       __set_bit(EV_KEY, kp->input->evbit);
>
>        /* Enable auto repeat feature of Linux input subsystem */
>        if (pdata->rep)
> -               set_bit(EV_REP, kp->input->evbit);
> +               __set_bit(EV_REP, kp->input->evbit);
>
>        for (i = 0; i < kp->keymapsize; i++)
> -               set_bit(kp->keymap[i] & KEYNUM_MASK,
> +               __set_bit(kp->keymap[i] & KEYNUM_MASK,
>                                kp->input->keybit);
>
>        kp->input->name = "TWL4030 Keypad";
> @@ -441,15 +442,16 @@ err5:
>        free_irq(kp->irq, NULL);
>  err3:
>        input_unregister_device(kp->input);
> +       kp->input = NULL;
>  err2:
>        input_free_device(kp->input);
> -
> +       kfree(kp);
>        return -ENODEV;
>  }
>
>  static int __devexit twl4030_kp_remove(struct platform_device *pdev)
>  {
> -       struct twl4030_keypad *kp = dev_get_drvdata(&pdev->dev);
> +       struct twl4030_keypad *kp = platform_get_drvdata(pdev);
>
>        free_irq(kp->irq, kp);
>        input_unregister_device(kp->input);
>
>

Thanks for making changes:

Reviewed-by: Trilok Soni <soni.trilok@gmail.com>

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
