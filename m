From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCHv3 1/3] TCA6416 keypad : Implement keypad driver for keys
 interfaced to TCA6416
Date: Fri, 30 Apr 2010 19:49:20 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870304E80EDC@dbde02.ent.ti.com>
References: <1269357035-19754-1-git-send-email-srk@ti.com>
 <1269357035-19754-2-git-send-email-srk@ti.com>
 <20100416052500.GA1078@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab0D3QuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 12:50:01 -0400
In-Reply-To: <20100416052500.GA1078@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, April 16, 2010 10:55 AM
> To: Govindarajan, Sriramakrishnan
> Cc: linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> Subject: Re: [PATCHv3 1/3] TCA6416 keypad : Implement keypad driver for
> keys interfaced to TCA6416
> 
> On Tue, Mar 23, 2010 at 08:40:33PM +0530, Sriramakrishnan wrote:
> > This patch implements a simple Keypad driver that functions
> > as an I2C client. It handles key press events for keys
> > connected to TCA6416 I2C based IO expander.
> >
> > Signed-off-by: Sriramakrishnan <srk@ti.com>
> > ---
> >  drivers/input/keyboard/Kconfig          |   16 ++
> >  drivers/input/keyboard/Makefile         |    1 +
> >  drivers/input/keyboard/tca6416-keypad.c |  354
> +++++++++++++++++++++++++++++++
> >  include/linux/tca6416_keypad.h          |   34 +++
> >  4 files changed, 405 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/keyboard/tca6416-keypad.c
> >  create mode 100644 include/linux/tca6416_keypad.h
----snip----
Does the driver still work if you aplly the patch below on top?
[Sriram] Dmitry, I was able to test with the patch below(again scope restricted to Polling mode) and it works but with following minor changes. Please review.
> 
> Thanks.
> 
> --
> Dmitry
> 
> Input: tca6416 - misc fixes
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/keyboard/tca6416-keypad.c |  327 +++++++++++++++-----------
> -----
>  1 files changed, 160 insertions(+), 167 deletions(-)
> 
> 
> diff --git a/drivers/input/keyboard/tca6416-keypad.c
> b/drivers/input/keyboard/tca6416-keypad.c
> index 17df832..0943af3 100644
> --- a/drivers/input/keyboard/tca6416-keypad.c
> +++ b/drivers/input/keyboard/tca6416-keypad.c
> @@ -10,16 +10,17 @@
>   * published by the Free Software Foundation.
>   */
---snip---

> +static int tca6416_keys_open(struct input_dev *dev)
> +{
> +	struct tca6416_keypad_chip *chip = input_get_drvdata(dev);
> +
> +	/* Get initial device state in case it has switches */
> +	tca6416_keys_scan(chip);
> 
>  	if (chip->use_polling)
>  		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
>  	else
>  		enable_irq(chip->irqnum);
> 
> +	return 0;
> +}
> +
> +static void tca6416_keys_close(struct input_dev *dev)
> +{
> +	struct tca6416_keypad_chip *chip = input_get_drvdata(dev);
> +
> +	if (chip->use_polling)
> +		cancel_delayed_work_sync(&chip->dwork);
> +	else
> +		free_irq(chip->irqnum, chip);
[Sriram] replaced free_irq() with disable_irq() instead. This should take care of multiple (concurrent) opens.

>  }
> 
> +static int __devinit tca6416_setup_registers(struct tca6416_keypad_chip
> *chip)
> +{
> +	int error;
> +
> +	error = tca6416_read_reg(chip, TCA6416_OUTPUT, &chip->reg_output);
> +	if (error)
> +		return error;
> +
> +	error = tca6416_read_reg(chip, TCA6416_DIRECTION, &chip-
> >reg_direction);
> +	if (error)
> +		return error;
> +
> +	/* ensure that keypad pins are set to input */
> +	error = tca6416_write_reg(chip, TCA6416_DIRECTION,
> +				  chip->reg_direction | chip->pinmask);
> +	if (error)
> +		return error;
> +
> +	error = tca6416_read_reg(chip, TCA6416_DIRECTION, &chip-
> >reg_direction);
> +	if (error)
> +		return error;
> +
> +	error = tca6416_read_reg(chip, TCA6416_INPUT, &chip->reg_input);
> +	if (error)
> +		return error;

[Sriram] reg_input cached value needs to be masked with pinmask - otherwise on device open the driver reports continuous stream of key_down(repeat) events until a key is pressed.

> +	return 0;
> +}
> 
[Sriram] Dmitry, once you have reviewed the changes, should I re-post the patch series with your patch added to the series?

Regards
Sriram
