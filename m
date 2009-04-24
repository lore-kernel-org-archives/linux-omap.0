From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-git] input:  twl4030_keypad driver
Date: Fri, 24 Apr 2009 02:09:55 -0700
Message-ID: <200904240209.55388.david-b@pacbell.net>
References: <200902060057.04108.david-b@pacbell.net> <200904202322.41523.david-b@pacbell.net> <20090424021159.GB11726@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:32603 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752106AbZDXJJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2009 05:09:57 -0400
In-Reply-To: <20090424021159.GB11726@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

On Thursday 23 April 2009, Dmitry Torokhov wrote:
> > 
> 
> Dave,
> 
> It waqs sitting in my local queue, I had some concerns over the keymap
> change as it was implemented in the version you sent me. The problem is
> that you mangle key codes in your keymap table (encoding row/col data in

Well, not really *me* I didn't write any of this.  I just
cleaned it up and sent it along to help get this stuff out
of the OMAP tree, into mainline where it belongs.


> them) but input core is not aware of that and when you try using
> EVIOCSETKEYCODE it will do wierd things. I was wondering what you would
> think about the following patch that should rectify this issue.

It invalidates all the existing keypad tables, which have been
waiting for this driver to merge before they go upstream ... it'd
be simpler just to prevent EVIOCSETKEYCODE calls.  Or provide
update methods that understand the structure of those entries;
conceptually they're a "struct { scancode; keycode; }" though
it's not coded that way

Needing to take 512 bytes per keytable -- vs the keypad-specific
sizes, typically much less even if using a qwerty -- is also a
minor issue.  Keypads with 256 keys are *really* unusual!  Most
current ones are smaller ... the biggest I've seen is 44.


> Also, I don't think we need the special handling for "persistant" keys.
> Just let these keys generate KEY_RESERVED and input core will not
> propagate their events.

I was never sure what to make of that, it seemed like a hack.
Only the "Labrador" boards (since renamed "Zoom1") seem to
need that mechanism.

So I'm not sure whether that would be appropriate.  If it is,
then the keytable construction macros could just change.  But
is the input core aware that it shouldn't remap such things?

- Dave

p.s. a few comments are below.


> 
> Thanks!
> 
> -- 
> Dmitry
> 
> 
> Input: twl4030_kepad fixups
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/keyboard/twl4030_keypad.c |   62 ++++++++++---------------------
>  include/linux/i2c/twl4030.h             |   18 +++++++--
>  2 files changed, 32 insertions(+), 48 deletions(-)
> 
> 
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index 987f13c..b761cac 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -48,23 +48,18 @@
>   * See the TPS65950 documentation; that's the general availability
>   * version of the TWL5030 second generation part.
>   */
> -#define MAX_ROWS		8	/* TWL4030 hard limit */
>  
>  struct twl4030_keypad {
> -	unsigned	*keymap;
> -	unsigned int	keymapsize;
> -	u16		kp_state[MAX_ROWS];
> -	unsigned	n_rows;
> -	unsigned	n_cols;
> +	unsigned short	keymap[TWL4030_KEYMAP_SIZE];

The keypad size is board-specific; not all possible switch
settings are used.


> +	u16		kp_state[TWL4030_MAX_ROWS];

TWL4030_MAX_ROWS makes sense, although the same keypad macros
are used in some other OMAP boards that don't use TWL4030 family
chips, so it's not really TWL-specific.  (OMAP1 boards often use
the "omap-keypad" driver.)


> +	u8		n_rows;
> +	u8		n_cols;

Didn't really need to change those.  This is one of the cases
where the code to read a byte then zero-extend it uses more
space than using a 32-bit unsigned value instead of 8-bit.  :)


>  	unsigned	irq;
>  
>  	struct device	*dbg_dev;
>  	struct input_dev *input;
>  };
>  
> -#define ROWCOL_MASK	KEY(0xf, 0xf, 0)
> -#define KEYNUM_MASK	~PERSISTENT_KEY(0xf, 0xf)

This being a side-effect of changing the key table encoding...

> -
>  /*----------------------------------------------------------------------*/
>  
>  /* arbitrary prescaler value 0..7 */
> @@ -156,18 +151,6 @@ static int twl4030_kpwrite_u8(struct twl4030_keypad *kp, u8 data, u32 reg)
>  	return ret;
>  }
>  
> -static int twl4030_find_key(struct twl4030_keypad *kp, int col, int row)
> -{
> -	int i, rc;
> -
> -	rc = KEY(col, row, 0);
> -	for (i = 0; i < kp->keymapsize; i++)
> -		if ((kp->keymap[i] & ROWCOL_MASK) == rc)
> -			return kp->keymap[i] & (KEYNUM_MASK | KEY_PERSISTENT);
> -
> -	return -EINVAL;
> -}
> -
>  static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 col)
>  {
>  	/* If all bits in a row are active for all coloumns then
> @@ -183,7 +166,7 @@ static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 col)
>  
>  static int twl4030_read_kp_matrix_state(struct twl4030_keypad *kp, u16 *state)
>  {
> -	u8 new_state[MAX_ROWS];
> +	u8 new_state[TWL4030_MAX_ROWS];
>  	int row;
>  	int ret = twl4030_kpread(kp,
>  				 new_state, KEYP_FULL_CODE_7_0, kp->n_rows);
> @@ -213,7 +196,8 @@ static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *key_state)
>  
>  static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all)
>  {
> -	u16 new_state[MAX_ROWS];
> +	struct input_dev *input = kp->input;
> +	u16 new_state[TWL4030_MAX_ROWS];
>  	int col, row;
>  
>  	if (release_all)
> @@ -246,20 +230,13 @@ static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all)
>  				(new_state[row] & (1 << col)) ?
>  				"press" : "release");
>  
> -			key = twl4030_find_key(kp, col, row);
> -			if (key < 0)
> -				dev_warn(kp->dbg_dev,
> -					"Spurious key event %d-%d\n",
> -					 col, row);
> -			else if (key & KEY_PERSISTENT)
> -				continue;
> -			else
> -				input_report_key(kp->input, key,
> -						 new_state[row] & (1 << col));
> +			key = kp->keymap[(row << 3) | col];
> +			input_report_key(input, key,
> +					 new_state[row] & (1 << col));

That being the guts of this patchlet:  using a flat table
lookup instead of a key/value search.


>  		}
>  		kp->kp_state[row] = new_state[row];
>  	}
> -	input_sync(kp->input);
> +	input_sync(input);
>  }
>  
>  /*
> @@ -358,8 +335,8 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
>  	int i;
>  	int error;
>  
> -	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap
> -			|| pdata->rows > 8 || pdata->cols > 8) {
> +	if (!pdata || !pdata->rows || !pdata->cols ||
> +	    pdata->rows > TWL4030_MAX_ROWS || pdata->cols > TWL4030_MAX_COLS) {
>  		dev_err(&pdev->dev, "Invalid platform_data\n");
>  		return -EINVAL;
>  	}
> @@ -373,11 +350,9 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
>  
>  	/* Get the debug Device */
>  	kp->dbg_dev = &pdev->dev;
> -
>  	kp->input = input;
>  
> -	kp->keymap = pdata->keymap;
> -	kp->keymapsize = pdata->keymapsize;
> +	memcpy(kp->keymap, pdata->keymap, sizeof(pdata->keymap));

Alternatively build a table of the "struct { scancode; keycode; }"
things here ... or update the table construction macros so that's
what they get in the first place (instead of integers with bitfields).


>  	kp->n_rows = pdata->rows;
>  	kp->n_cols = pdata->cols;
>  	kp->irq = platform_get_irq(pdev, 0);
> @@ -389,8 +364,9 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
>  	if (pdata->rep)
>  		__set_bit(EV_REP, kp->input->evbit);
>  
> -	for (i = 0; i < kp->keymapsize; i++)
> -		__set_bit(kp->keymap[i] & KEYNUM_MASK, input->keybit);
> +	for (i = 0; i < ARRAY_SIZE(kp->keymap); i++)
> +		__set_bit(kp->keymap[i], input->keybit);
> +	__clear_bit(KEY_RESERVED, input->keybit);

And I see KEY_RESERVED == 0, which is implicitly relied
on by the way most of that keymap is empty.


>  
>  	input->name		= "TWL4030 Keypad";
>  	input->phys		= "twl4030_keypad/input0";
> @@ -402,8 +378,8 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
>  	input->id.version	= 0x0003;
>  
>  	input->keycode		= kp->keymap;
> -	input->keycodesize	= sizeof(unsigned int);
> -	input->keycodemax	= kp->keymapsize;
> +	input->keycodesize	= sizeof(kp->keymap[0]);
> +	input->keycodemax	= ARRAY_SIZE(kp->keymap);
>  
>  	error = input_register_device(input);
>  	if (error) {
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index 6b9722d..e493d2a 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -25,6 +25,8 @@
>  #ifndef __TWL4030_H_
>  #define __TWL4030_H_
>  
> +#include <linux/types.h>
> +
>  /*
>   * Using the twl4030 core we address registers using a pair
>   *	{ module id, relative register offset }
> @@ -306,16 +308,22 @@ struct twl4030_madc_platform_data {
>   * Column and row are 4 bits, but range only from 0..7;
>   * a PERSISTENT_KEY is "always on" and never reported.
>   */
> +
> +#define TWL4030_MAX_ROWS	8
> +#define TWL4030_MAX_COLS	8
> +#define TWL4030_KEYMAP_SIZE	(TWL4030_MAX_ROWS * TWL4030_MAX_COLS)
> +
> +/*
>  #define KEY_PERSISTENT		0x00800000
>  #define KEY(col, row, keycode)	(((col) << 28) | ((row) << 24) | (keycode))
>  #define PERSISTENT_KEY(c, r)	KEY((c), (r), KEY_PERSISTENT)

If your KEY_RESERVED thing checks out,

  PERSISTENT_KEY(c,r) == KEY((c), (r), KEY_RESERVED)

Also, someone had commented that a bunch of other drivers need
basic scancode-to-keycode table support ... so maybe this kind
of stuff should become more standardized, instead of requiring
every driver to re-invent this roundy wheel-ish thing.


> +*/
>  
>  struct twl4030_keypad_data {
> -	unsigned rows;
> -	unsigned cols;
> -	unsigned *keymap;
> -	unsigned short keymapsize;
> -	unsigned int rep:1;
> +	unsigned short keymap[TWL4030_KEYMAP_SIZE];
> +	u8 rows;
> +	u8 cols;
> +	bool rep;
>  };
>  
>  enum twl4030_usb_mode {
> 
> 


