From: Anirudh Ghayal <anirudhghayal@gmail.com>
Subject: Re: [PATCH 1/3] TCA6416 keypad : Implement keypad driver for keys
	interfaced to TCA6416
Date: Sun, 28 Feb 2010 00:27:47 +0530
Message-ID: <cfb943981002271057t75fe7decy99875c9dbd7721ec@mail.gmail.com>
References: <1267103701-23823-1-git-send-email-srk@ti.com>
	 <1267103701-23823-2-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:51913 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030492Ab0B0S5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Feb 2010 13:57:48 -0500
In-Reply-To: <1267103701-23823-2-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org

Hi,

> +
> + =A0 =A0 =A0 chip =3D kzalloc(sizeof(struct tca6416_keypad_chip), GF=
P_KERNEL);
> + =A0 =A0 =A0 if (chip =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;

Check for i2c functionality support ?

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

The error path needs to free_irq() in case of any failure after this,
for an interrupt based driver.

Thanks,
Anirudh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
