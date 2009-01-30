From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [patch/rfc 2.6.28-rc2] input: twl4030_keypad driver
Date: Thu, 29 Jan 2009 19:17:43 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A527A@mi8nycmail19.Mi8.com>
References: <200901211613.06427.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <200901211613.06427.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, linux-input@vger.kernel.org
Cc: OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday, January 21, 2009 5:13 PM, David Brownell wrote:
> Driver for the twl4030 family keypad controller.  This controller
> supports a key matrix of up to 8 rows by 8 columns.  Board init
> code passes a description of the key matrix to the driver.
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---

[SNIP]

> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -255,11 +255,18 @@ struct twl4030_madc_platform_data {
>  	int		irq_line;
>  };
>  
> +/* Boards have uniqe mappings of {col, row} --> keycode.
> + * Column and row are 4 bits, but range only from 0..7;
> + * a PERSISTENT_KEY is "always on" and never reported.
> + */
> +#define KEY_PERSISTENT		0x00800000
> +#define KEY(col, row, keycode)	(((col) << 28) | ((row) << 24) |
(keycode))

The same KEY macro is defined in:

arch/arm/mach-pxa/include/mach/pxa27x_keypad.h
arch/arm/plat-omap/include/mach/keypad.h

I also have a keypad driver for the ep93xx that uses the same macro.

Shouldn't/couldn't this be generalized and added to the
include/linux/input.h file?  Allowing 4-bits for row/col gives a maximum
key matrix of 16x16 keys which should be enough for just about anything.

Regards,
Hartley

