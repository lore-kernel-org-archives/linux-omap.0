From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
Date: Fri, 17 Dec 2010 22:01:04 -0800
Message-ID: <20101218060104.GA1623@core.coreip.homeip.net>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

On Fri, Dec 17, 2010 at 11:32:04PM +0100, Janusz Krzysztofik wrote:
> Most keypad drivers make use of the <linux/input/matrix_keypad.h> 
> defined macros, structures and inline functions.
> 
> Convert omap-keypad driver to use those as well, as suggested by a 
> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
> 

Looks nice, couple of comments.

>  
>  struct omap_kp_platform_data {
>  	int rows;
>  	int cols;
> -	int *keymap;
> -	unsigned int keymapsize;
> +	const struct matrix_keymap_data *keymap_data;
>  	unsigned int rep:1;
>  	unsigned long delay;
>  	unsigned int dbounce:1;

Since you are updating all boards maybe also change rep and dbounce to
bool?

> --- linux-2.6.37-rc5/drivers/input/keyboard/omap-keypad.c.orig	2010-12-09 23:08:09.000000000 +0100
> +++ linux-2.6.37-rc5/drivers/input/keyboard/omap-keypad.c	2010-12-16 21:04:07.000000000 +0100
> @@ -65,7 +65,6 @@ struct omap_kp {
>  
>  static DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
>  
> -static int *keymap;
>  static unsigned int *row_gpios;
>  static unsigned int *col_gpios;
>  
> @@ -162,20 +161,11 @@ static void omap_kp_scan_keypad(struct o
>  	}
>  }
>  
> -static inline int omap_kp_find_key(int col, int row)
> -{
> -	int i, key;
> -
> -	key = KEY(col, row, 0);
> -	for (i = 0; keymap[i] != 0; i++)
> -		if ((keymap[i] & 0xff000000) == key)
> -			return keymap[i] & 0x00ffffff;
> -	return -1;
> -}
> -
>  static void omap_kp_tasklet(unsigned long data)
>  {
>  	struct omap_kp *omap_kp_data = (struct omap_kp *) data;
> +	unsigned short *keycodes = omap_kp_data->input->keycode;
> +	unsigned int row_shift = get_count_order(omap_kp_data->cols);
>  	unsigned char new_state[8], changed, key_down = 0;
>  	int col, row;
>  	int spurious = 0;
> @@ -199,7 +189,7 @@ static void omap_kp_tasklet(unsigned lon
>  			       row, (new_state[col] & (1 << row)) ?
>  			       "pressed" : "released");
>  #else
> -			key = omap_kp_find_key(col, row);
> +			key = keycodes[MATRIX_SCAN_CODE(row, col, row_shift)];
>  			if (key < 0) {
>  				printk(KERN_WARNING
>  				      "omap-keypad: Spurious key event %d-%d\n",
> @@ -298,16 +288,22 @@ static int __devinit omap_kp_probe(struc
>  	struct input_dev *input_dev;
>  	struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
>  	int i, col_idx, row_idx, irq_idx, ret;
> +	unsigned short *keycodes;
> +	unsigned int row_shift;
>  
> -	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
> -		printk(KERN_ERR "No rows, cols or keymap from pdata\n");
> +	if (!pdata->rows || !pdata->cols || !pdata->keymap_data) {
> +		printk(KERN_ERR "No rows, cols or keymap_data from pdata\n");
>  		return -EINVAL;
>  	}
>  
>  	omap_kp = kzalloc(sizeof(struct omap_kp), GFP_KERNEL);
> +	row_shift = get_count_order(pdata->cols);
> +	keycodes = kzalloc((pdata->rows << row_shift) * sizeof(*keycodes),
> +			GFP_KERNEL);
>  	input_dev = input_allocate_device();
> -	if (!omap_kp || !input_dev) {
> +	if (!omap_kp || !keycodes || !input_dev) {
>  		kfree(omap_kp);
> +		kfree(keycodes);

I do not see where you freeing keycodes in case something else fails nor
in omap_kp_remove(). But why don't you put keycodes at the end of struct
omap_kp and allocate it in one shot?

Thanks.

-- 
Dmitry
