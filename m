From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: Re: [PATCHv3 1/3] TCA6416 keypad : Implement keypad driver for keys
	interfaced to TCA6416
Date: Sun, 4 Apr 2010 13:29:08 -0500
Message-ID: <s2wcb8016981004041129y8db79t8bbd941411a179ba@mail.gmail.com>
References: <1269357035-19754-1-git-send-email-srk@ti.com>
	 <1269357035-19754-2-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60144 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0DDS3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Apr 2010 14:29:10 -0400
In-Reply-To: <1269357035-19754-2-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org

Sriramakrishnan,

=46ind minor changes proposals...

> +
> + =A0 =A0 =A0 =A0 Say Y here if your device has keys connected to
> + =A0 =A0 =A0 =A0 TCA6416 IO expander. Your board-specific setup logi=
c
> + =A0 =A0 =A0 =A0 must also provide pin-mask details(of which TCA6416=
 pins
> + =A0 =A0 =A0 =A0 are used for keypad).

space in " details ( "

<snip>

> + =A0 =A0 =A0 if (chip->use_polling)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_delayed_work(&chip->dwork, mse=
cs_to_jiffies(100));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(chip->irqnum);
> +
> +}
> +
> +

remove one blank line

> +
> + =A0 =A0 =A0 /* initialize cached registers from their original valu=
es.
> + =A0 =A0 =A0 =A0* we can't share this chip with another i2c master.
> + =A0 =A0 =A0 =A0*/

should we start our comment section as below?

/*
 * initialize...

<snip>

> +
> + =A0 =A0 =A0 ret =3D tca6416_read_reg(chip, TCA6416_INPUT, &chip->re=
g_input);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, chip);
> +
> +

remove one blank line

<snip>

> +
> + =A0 =A0 =A0 if (!chip->use_polling) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->irq_is_gpio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->irqnum =3D gpio_t=
o_irq(client->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->irqnum =3D client=
->irq;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(chip->irqnum, tca64=
16_keys_isr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_SH=
ARED | IRQF_TRIGGER_FALLING ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "tca641=
6-keypad", chip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable=
 to claim irq %d; error %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->i=
rqnum, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(chip->irqnum);

why not using threaded irq?

Best Regards
Abraham
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
