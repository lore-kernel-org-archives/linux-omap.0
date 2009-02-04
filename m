From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.29-rc1-omap git] twl4030_keypad cleanup
Date: Wed, 4 Feb 2009 11:21:16 -0800
Message-ID: <20090204192115.GM7215@atomide.com>
References: <200901200051.47122.david-b@pacbell.net> <200901222259.16234.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64595 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbZBDTVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 14:21:20 -0500
Content-Disposition: inline
In-Reply-To: <200901222259.16234.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090122 22:59]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Start cleaning up the twl4030 keypad driver to become more
> suitable for mainline.
> 
>  - Remove false OMAP dependencies:  names, <mach/keypad.h>, Kconfig
>  - We don't need a miniature header file
>  - Add missing input_sync()
>  - Fix section annotations
>  - Fix probe() error cleanup
>  - Streamline i/o calls
>  - Remove needless mutex; maintain key state only via irqs
>  - Remove unneeded headers
>  - Use "unsigned" for things that can't be negative
> 
> The driver should also be renamed as "twl4030_keypad.c"; that will
> be a different patch.

Pushing this to l-o tree, let me know when/if you need the patch
against the mainline tree added to the omap-upstream queue.

Tony


> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
> ---
> Refresh against RC2, with feedback addressed, and also a few
> deltas that had accidentally been omitted.
> 
>  arch/arm/mach-omap2/board-2430sdp.c         |    1 
>  arch/arm/mach-omap2/board-3430sdp.c         |    1 
>  arch/arm/mach-omap2/board-ldp.c             |    1 
>  arch/arm/mach-omap2/board-omap2evm.c        |    1 
>  arch/arm/mach-omap2/board-omap3evm.c        |    1 
>  drivers/input/keyboard/Kconfig              |    9 
>  drivers/input/keyboard/omap-twl4030keypad.c |  300 +++++++++++++++-----------
>  drivers/input/keyboard/twl4030-keypad.h     |   82 -------
>  include/linux/i2c/twl4030.h                 |   16 +
>  9 files changed, 200 insertions(+), 212 deletions(-)
> 
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -38,7 +38,6 @@
>  #include <mach/board.h>
>  #include <mach/usb-musb.h>
>  #include <mach/common.h>
> -#include <mach/keypad.h>
>  #include <mach/gpmc.h>
>  #include <mach/mcspi.h>
>  
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -36,7 +36,6 @@
>  #include <mach/usb-musb.h>
>  #include <mach/usb-ehci.h>
>  #include <mach/common.h>
> -#include <mach/keypad.h>
>  #include <mach/dma.h>
>  #include <mach/gpmc.h>
>  
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -34,7 +34,6 @@
>  #include <mach/gpio.h>
>  #include <mach/board.h>
>  #include <mach/common.h>
> -#include <mach/keypad.h>
>  #include <mach/gpmc.h>
>  #include <mach/usb-musb.h>
>  
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -35,7 +35,6 @@
>  #include <mach/board.h>
>  #include <mach/common.h>
>  #include <mach/mmc.h>
> -#include <mach/keypad.h>
>  #include <mach/gpmc.h>
>  #include <mach/nand.h>
>  #include <mach/mcspi.h>
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -30,7 +30,6 @@
>  #include <asm/mach/map.h>
>  
>  #include <mach/gpio.h>
> -#include <mach/keypad.h>
>  #include <mach/board.h>
>  #include <mach/usb-musb.h>
>  #include <mach/usb-ehci.h>
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -260,14 +260,15 @@ config KEYBOARD_OMAP
>  	  module will be called omap-keypad.
>  
>  config KEYBOARD_TWL4030
> -	tristate "TI TWL4030 keypad support"
> +	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
>  	depends on TWL4030_CORE
>  	help
> -	  Say Y here if you want to use the OMAP TWL4030 keypad.
> +	  Say Y here if your board use the keypad controller on
> +	  TWL4030 family chips.  It's safe to say enable this
> +	  even on boards that don't use the keypad controller.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called omap-twl4030keypad. This driver depends on
> -	  TWL4030 Core and TWL4030 GPIO I2C client driver
> +	  module will be called twl4030_keypad.
>  
>  config OMAP_PS2
>  	tristate "TI OMAP Innovator 1510 PS/2 keyboard & mouse support"
> --- a/drivers/input/keyboard/omap-twl4030keypad.c
> +++ b/drivers/input/keyboard/omap-twl4030keypad.c
> @@ -25,50 +25,117 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
>  
> +#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/types.h>
>  #include <linux/input.h>
> -#include <linux/kernel.h>
> -#include <linux/mutex.h>
> -#include <linux/delay.h>
> -#include <linux/bitops.h>
>  #include <linux/platform_device.h>
> -#include <linux/i2c.h>
>  #include <linux/i2c/twl4030.h>
> -#include <linux/irq.h>
> -#include <mach/keypad.h>
>  
> -#include "twl4030-keypad.h"
> -
> -#define PTV_PRESCALER		4
> -
> -#define MAX_ROWS		8 /* TWL4030 hardlimit */
> -
> -/* Global variables */
> +/*
> + * The TWL4030 family chips include a keypad controller that supports
> + * up to an 8x8 switch matrix.  The controller can issue system wakeup
> + * events, since it uses only the always-on 32KiHz oscillator, and has
> + * an internal state machine that decodes pressed keys, including
> + * multi-key combinations.
> + *
> + * This driver lets boards define what keycodes they wish to report for
> + * which scancodes, as part of the "struct twl4030_keypad_data" used in
> + * the probe() routine.
> + *
> + * See the TPS65950 documentation; that's the general availability
> + * version of the TWL5030 second generation part.
> + */
> +#define MAX_ROWS		8	/* TWL4030 hard limit */
>  
> -struct omap_keypad {
> -	int		*keymap;
> +struct twl4030_keypad {
> +	unsigned	*keymap;
>  	unsigned int	keymapsize;
>  	u16		kp_state[MAX_ROWS];
> -	int		n_rows;
> -	int		n_cols;
> -	int		irq;
> +	unsigned	n_rows;
> +	unsigned	n_cols;
> +	unsigned	irq;
>  
>  	struct device	*dbg_dev;
> -	struct input_dev *omap_twl4030kp;
> -
> -	/* sync read/write */
> -	struct mutex	mutex;
> +	struct input_dev *input;
>  };
>  
> -static int twl4030_kpread(struct omap_keypad *kp,
> -		u32 module, u8 *data, u32 reg, u8 num_bytes)
> +#define ROWCOL_MASK	KEY(0xf, 0xf, 0)
> +#define KEYNUM_MASK	~PERSISTENT_KEY(0xf, 0xf)
> +
> +/*----------------------------------------------------------------------*/
> +
> +/* arbitrary prescaler value 0..7 */
> +#define PTV_PRESCALER			4
> +
> +/* Register Offsets */
> +#define KEYP_CTRL			0x00
> +#define KEYP_DEB			0x01
> +#define KEYP_LONG_KEY			0x02
> +#define KEYP_LK_PTV			0x03
> +#define KEYP_TIMEOUT_L			0x04
> +#define KEYP_TIMEOUT_H			0x05
> +#define KEYP_KBC			0x06
> +#define KEYP_KBR			0x07
> +#define KEYP_SMS			0x08
> +#define KEYP_FULL_CODE_7_0		0x09	/* row 0 column status */
> +#define KEYP_FULL_CODE_15_8		0x0a	/* ... row 1 ... */
> +#define KEYP_FULL_CODE_23_16		0x0b
> +#define KEYP_FULL_CODE_31_24		0x0c
> +#define KEYP_FULL_CODE_39_32		0x0d
> +#define KEYP_FULL_CODE_47_40		0x0e
> +#define KEYP_FULL_CODE_55_48		0x0f
> +#define KEYP_FULL_CODE_63_56		0x10
> +#define KEYP_ISR1			0x11
> +#define KEYP_IMR1			0x12
> +#define KEYP_ISR2			0x13
> +#define KEYP_IMR2			0x14
> +#define KEYP_SIR			0x15
> +#define KEYP_EDR			0x16	/* edge triggers */
> +#define KEYP_SIH_CTRL			0x17
> +
> +/* KEYP_CTRL_REG Fields */
> +#define KEYP_CTRL_SOFT_NRST		BIT(0)
> +#define KEYP_CTRL_SOFTMODEN		BIT(1)
> +#define KEYP_CTRL_LK_EN			BIT(2)
> +#define KEYP_CTRL_TOE_EN		BIT(3)
> +#define KEYP_CTRL_TOLE_EN		BIT(4)
> +#define KEYP_CTRL_RP_EN			BIT(5)
> +#define KEYP_CTRL_KBD_ON		BIT(6)
> +
> +/* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
> +#define KEYP_PERIOD_US(t, prescale)	((t) / (31 << (prescale + 1)) - 1)
> +
> +/* KEYP_LK_PTV_REG Fields */
> +#define KEYP_LK_PTV_PTV_SHIFT		5
> +
> +/* KEYP_{IMR,ISR,SIR} Fields */
> +#define KEYP_IMR1_MIS			BIT(3)
> +#define KEYP_IMR1_TO			BIT(2)
> +#define KEYP_IMR1_LK			BIT(1)
> +#define KEYP_IMR1_KP			BIT(0)
> +
> +/* KEYP_EDR Fields */
> +#define KEYP_EDR_KP_FALLING		0x01
> +#define KEYP_EDR_KP_RISING		0x02
> +#define KEYP_EDR_KP_BOTH		0x03
> +#define KEYP_EDR_LK_FALLING		0x04
> +#define KEYP_EDR_LK_RISING		0x08
> +#define KEYP_EDR_TO_FALLING		0x10
> +#define KEYP_EDR_TO_RISING		0x20
> +#define KEYP_EDR_MIS_FALLING		0x40
> +#define KEYP_EDR_MIS_RISING		0x80
> +
> +
> +/*----------------------------------------------------------------------*/
> +
> +static int twl4030_kpread(struct twl4030_keypad *kp,
> +		u8 *data, u32 reg, u8 num_bytes)
>  {
>  	int ret;
>  
> -	ret = twl4030_i2c_read(module, data, reg, num_bytes);
> +	ret = twl4030_i2c_read(TWL4030_MODULE_KEYPAD, data, reg, num_bytes);
>  	if (ret < 0) {
>  		dev_warn(kp->dbg_dev,
>  			"Couldn't read TWL4030: %X - ret %d[%x]\n",
> @@ -78,12 +145,11 @@ static int twl4030_kpread(struct omap_ke
>  	return ret;
>  }
>  
> -static int twl4030_kpwrite_u8(struct omap_keypad *kp,
> -		u32 module, u8 data, u32 reg)
> +static int twl4030_kpwrite_u8(struct twl4030_keypad *kp, u8 data, u32 reg)
>  {
>  	int ret;
>  
> -	ret = twl4030_i2c_write_u8(module, data, reg);
> +	ret = twl4030_i2c_write_u8(TWL4030_MODULE_KEYPAD, data, reg);
>  	if (ret < 0) {
>  		dev_warn(kp->dbg_dev,
>  			"Could not write TWL4030: %X - ret %d[%x]\n",
> @@ -93,7 +159,7 @@ static int twl4030_kpwrite_u8(struct oma
>  	return ret;
>  }
>  
> -static int omap_kp_find_key(struct omap_keypad *kp, int col, int row)
> +static int twl4030_find_key(struct twl4030_keypad *kp, int col, int row)
>  {
>  	int i, rc;
>  
> @@ -105,7 +171,7 @@ static int omap_kp_find_key(struct omap_
>  	return -EINVAL;
>  }
>  
> -static inline u16 omap_kp_col_xlate(struct omap_keypad *kp, u8 col)
> +static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 col)
>  {
>  	/* If all bits in a row are active for all coloumns then
>  	 * we have that row line connected to gnd. Mark this
> @@ -118,20 +184,20 @@ static inline u16 omap_kp_col_xlate(stru
>  		return col & ((1 << kp->n_cols) - 1);
>  }
>  
> -static int omap_kp_read_kp_matrix_state(struct omap_keypad *kp, u16 *state)
> +static int twl4030_read_kp_matrix_state(struct twl4030_keypad *kp, u16 *state)
>  {
>  	u8 new_state[MAX_ROWS];
>  	int row;
> -	int ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD,
> +	int ret = twl4030_kpread(kp,
>  				 new_state, KEYP_FULL_CODE_7_0, kp->n_rows);
>  	if (ret >= 0) {
>  		for (row = 0; row < kp->n_rows; row++)
> -			state[row] = omap_kp_col_xlate(kp, new_state[row]);
> +			state[row] = twl4030_col_xlate(kp, new_state[row]);
>  	}
>  	return ret;
>  }
>  
> -static int omap_kp_is_in_ghost_state(struct omap_keypad *kp, u16 *key_state)
> +static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 *key_state)
>  {
>  	int i;
>  	u16 check = 0;
> @@ -147,7 +213,7 @@ static int omap_kp_is_in_ghost_state(str
>  	return 0;
>  }
>  
> -static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
> +static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_all)
>  {
>  	u16 new_state[MAX_ROWS];
>  	int col, row;
> @@ -156,16 +222,14 @@ static void twl4030_kp_scan(struct omap_
>  		memset(new_state, 0, sizeof(new_state));
>  	else {
>  		/* check for any changes */
> -		int ret = omap_kp_read_kp_matrix_state(kp, new_state);
> +		int ret = twl4030_read_kp_matrix_state(kp, new_state);
> +
>  		if (ret < 0)	/* panic ... */
>  			return;
> -
> -		if (omap_kp_is_in_ghost_state(kp, new_state))
> +		if (twl4030_is_in_ghost_state(kp, new_state))
>  			return;
>  	}
>  
> -	mutex_lock(&kp->mutex);
> -
>  	/* check for changes and print those */
>  	for (row = 0; row < kp->n_rows; row++) {
>  		int changed = new_state[row] ^ kp->kp_state[row];
> @@ -183,7 +247,7 @@ static void twl4030_kp_scan(struct omap_
>  				(new_state[row] & (1 << col)) ?
>  				"press" : "release");
>  
> -			key = omap_kp_find_key(kp, col, row);
> +			key = twl4030_find_key(kp, col, row);
>  			if (key < 0)
>  				dev_warn(kp->dbg_dev,
>  					"Spurious key event %d-%d\n",
> @@ -191,13 +255,12 @@ static void twl4030_kp_scan(struct omap_
>  			else if (key & KEY_PERSISTENT)
>  				continue;
>  			else
> -				input_report_key(kp->omap_twl4030kp, key,
> +				input_report_key(kp->input, key,
>  						 new_state[row] & (1 << col));
>  		}
>  		kp->kp_state[row] = new_state[row];
>  	}
> -
> -	mutex_unlock(&kp->mutex);
> +	input_sync(kp->input);
>  }
>  
>  /*
> @@ -205,7 +268,7 @@ static void twl4030_kp_scan(struct omap_
>   */
>  static irqreturn_t do_kp_irq(int irq, void *_kp)
>  {
> -	struct omap_keypad *kp = _kp;
> +	struct twl4030_keypad *kp = _kp;
>  	u8 reg;
>  	int ret;
>  
> @@ -218,7 +281,7 @@ static irqreturn_t do_kp_irq(int irq, vo
>  #endif
>  
>  	/* Read & Clear TWL4030 pending interrupt */
> -	ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD, &reg, KEYP_ISR1, 1);
> +	ret = twl4030_kpread(kp, &reg, KEYP_ISR1, 1);
>  
>  	/* Release all keys if I2C has gone bad or
>  	 * the KEYP has gone to idle state */
> @@ -231,40 +294,38 @@ static irqreturn_t do_kp_irq(int irq, vo
>  }
>  
>  /*
> - * Registers keypad device with input sub system
> + * Registers keypad device with input subsystem
>   * and configures TWL4030 keypad registers
>   */
> -static int __init omap_kp_probe(struct platform_device *pdev)
> +static int __devinit twl4030_kp_probe(struct platform_device *pdev)
>  {
>  	u8 reg;
>  	int i;
>  	int ret = 0;
> -	struct omap_keypad *kp;
> +	struct twl4030_keypad *kp;
>  	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
>  
> +	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap
> +			|| pdata->rows > 8 || pdata->cols > 8) {
> +		dev_err(&pdev->dev, "Invalid platform_data\n");
> +		return -EINVAL;
> +	}
> +
>  	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
>  	if (!kp)
>  		return -ENOMEM;
>  
> -	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
> -		dev_err(&pdev->dev, "No rows, cols or keymap from pdata\n");
> -		kfree(kp);
> -		return -EINVAL;
> -	}
> -
> -	dev_set_drvdata(&pdev->dev, kp);
> +	platform_set_drvdata(pdev, kp);
>  
>  	/* Get the debug Device */
>  	kp->dbg_dev = &pdev->dev;
>  
> -	kp->omap_twl4030kp = input_allocate_device();
> -	if (!kp->omap_twl4030kp) {
> +	kp->input = input_allocate_device();
> +	if (!kp->input) {
>  		kfree(kp);
>  		return -ENOMEM;
>  	}
>  
> -	mutex_init(&kp->mutex);
> -
>  	kp->keymap = pdata->keymap;
>  	kp->keymapsize = pdata->keymapsize;
>  	kp->n_rows = pdata->rows;
> @@ -272,82 +333,92 @@ static int __init omap_kp_probe(struct p
>  	kp->irq = platform_get_irq(pdev, 0);
>  
>  	/* setup input device */
> -	set_bit(EV_KEY, kp->omap_twl4030kp->evbit);
> +	__set_bit(EV_KEY, kp->input->evbit);
>  
>  	/* Enable auto repeat feature of Linux input subsystem */
>  	if (pdata->rep)
> -		set_bit(EV_REP, kp->omap_twl4030kp->evbit);
> +		__set_bit(EV_REP, kp->input->evbit);
>  
>  	for (i = 0; i < kp->keymapsize; i++)
> -		set_bit(kp->keymap[i] & KEYNUM_MASK,
> -				kp->omap_twl4030kp->keybit);
> +		__set_bit(kp->keymap[i] & KEYNUM_MASK,
> +				kp->input->keybit);
>  
> -	kp->omap_twl4030kp->name	= "omap_twl4030keypad";
> -	kp->omap_twl4030kp->phys	= "omap_twl4030keypad/input0";
> -	kp->omap_twl4030kp->dev.parent	= &pdev->dev;
> +	kp->input->name		= "TWL4030 Keypad";
> +	kp->input->phys		= "twl4030_keypad/input0";
> +	kp->input->dev.parent	= &pdev->dev;
>  
> -	kp->omap_twl4030kp->id.bustype	= BUS_HOST;
> -	kp->omap_twl4030kp->id.vendor	= 0x0001;
> -	kp->omap_twl4030kp->id.product	= 0x0001;
> -	kp->omap_twl4030kp->id.version	= 0x0003;
> +	kp->input->id.bustype	= BUS_HOST;
> +	kp->input->id.vendor	= 0x0001;
> +	kp->input->id.product	= 0x0001;
> +	kp->input->id.version	= 0x0003;
>  
> -	kp->omap_twl4030kp->keycode	= kp->keymap;
> -	kp->omap_twl4030kp->keycodesize	= sizeof(unsigned int);
> -	kp->omap_twl4030kp->keycodemax	= kp->keymapsize;
> +	kp->input->keycode	= kp->keymap;
> +	kp->input->keycodesize	= sizeof(unsigned int);
> +	kp->input->keycodemax	= kp->keymapsize;
>  
> -	ret = input_register_device(kp->omap_twl4030kp);
> +	ret = input_register_device(kp->input);
>  	if (ret < 0) {
>  		dev_err(kp->dbg_dev,
>  			"Unable to register twl4030 keypad device\n");
>  		goto err2;
>  	}
>  
> -	/* Disable auto-repeat */
> -	reg = KEYP_CTRL_NOAUTORPT;
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_CTRL);
> +	/* Enable controller, with hardware decoding but not autorepeat */
> +	reg = KEYP_CTRL_SOFT_NRST | KEYP_CTRL_SOFTMODEN
> +		| KEYP_CTRL_TOE_EN | KEYP_CTRL_KBD_ON;
> +	ret = twl4030_kpwrite_u8(kp, reg, KEYP_CTRL);
>  	if (ret < 0)
>  		goto err3;
>  
> +	/* NOTE:  we could use sih_setup() here to package keypad
> +	 * event sources as four different IRQs ... but we don't.
> +	 */
> +
>  	/* Enable TO rising and KP rising and falling edge detection */
>  	reg = KEYP_EDR_KP_BOTH | KEYP_EDR_TO_RISING;
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_EDR);
> +	ret = twl4030_kpwrite_u8(kp, reg, KEYP_EDR);
>  	if (ret < 0)
>  		goto err3;
>  
>  	/* Set PTV prescaler Field */
>  	reg = (PTV_PRESCALER << KEYP_LK_PTV_PTV_SHIFT);
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_LK_PTV);
> +	ret = twl4030_kpwrite_u8(kp, reg, KEYP_LK_PTV);
>  	if (ret < 0)
>  		goto err3;
>  
>  	/* Set key debounce time to 20 ms */
>  	i = KEYP_PERIOD_US(20000, PTV_PRESCALER);
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, i, KEYP_DEB);
> +	ret = twl4030_kpwrite_u8(kp, i, KEYP_DEB);
>  	if (ret < 0)
>  		goto err3;
>  
>  	/* Set timeout period to 100 ms */
>  	i = KEYP_PERIOD_US(200000, PTV_PRESCALER);
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
> -				 (i & 0xFF), KEYP_TIMEOUT_L);
> +	ret = twl4030_kpwrite_u8(kp, (i & 0xFF), KEYP_TIMEOUT_L);
> +	if (ret < 0)
> +		goto err3;
> +	ret = twl4030_kpwrite_u8(kp, (i >> 8), KEYP_TIMEOUT_H);
>  	if (ret < 0)
>  		goto err3;
>  
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
> -				 (i >> 8), KEYP_TIMEOUT_H);
> +	/* Enable Clear-on-Read; disable remembering events that fire
> +	 * after the IRQ but before our handler acks (reads) them,
> +	 */
> +	reg = TWL4030_SIH_CTRL_COR_MASK | TWL4030_SIH_CTRL_PENDDIS_MASK;
> +	ret = twl4030_kpwrite_u8(kp, reg, KEYP_SIH_CTRL);
>  	if (ret < 0)
>  		goto err3;
>  
> -	/* Enable Clear-on-Read */
> -	reg = KEYP_SIH_CTRL_COR | KEYP_SIH_CTRL_PEND_DIS;
> -	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
> -				 reg, KEYP_SIH_CTRL);
> +	/* initialize key state; irqs update it from here on */
> +	ret = twl4030_read_kp_matrix_state(kp, kp->kp_state);
>  	if (ret < 0)
>  		goto err3;
>  
>  	/*
>  	 * This ISR will always execute in kernel thread context because of
>  	 * the need to access the TWL4030 over the I2C bus.
> +	 *
> +	 * NOTE:  we assume this host is wired to TWL4040 INT1, not INT2 ...
>  	 */
>  	ret = request_irq(kp->irq, do_kp_irq, 0, pdev->name, kp);
>  	if (ret < 0) {
> @@ -356,46 +427,42 @@ static int __init omap_kp_probe(struct p
>  		goto err3;
>  	} else {
>  		/* Enable KP and TO interrupts now. */
> -		reg = ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
> -		ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
> -					 reg, KEYP_IMR1);
> +		reg = (u8) ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
> +		ret = twl4030_kpwrite_u8(kp, reg, KEYP_IMR1);
>  		if (ret < 0)
>  			goto err5;
>  	}
>  
> -	ret = omap_kp_read_kp_matrix_state(kp, kp->kp_state);
> -	if (ret < 0)
> -		goto err4;
> -
>  	return ret;
>  err5:
>  	/* mask all events - we don't care about the result */
> -	(void) twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, 0xff, KEYP_IMR1);
> -err4:
> +	(void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
>  	free_irq(kp->irq, NULL);
>  err3:
> -	input_unregister_device(kp->omap_twl4030kp);
> +	input_unregister_device(kp->input);
> +	kp->input = NULL;
>  err2:
> -	input_free_device(kp->omap_twl4030kp);
> -
> +	input_free_device(kp->input);
> +	kfree(kp);
>  	return -ENODEV;
>  }
>  
> -static int omap_kp_remove(struct platform_device *pdev)
> +static int __devexit twl4030_kp_remove(struct platform_device *pdev)
>  {
> -	struct omap_keypad *kp = dev_get_drvdata(&pdev->dev);
> +	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
>  
>  	free_irq(kp->irq, kp);
> -	input_unregister_device(kp->omap_twl4030kp);
> +	input_unregister_device(kp->input);
>  	kfree(kp);
>  
>  	return 0;
>  }
>  
> +MODULE_ALIAS("platform:twl4030_keypad");
>  
> -static struct platform_driver omap_kp_driver = {
> -	.probe		= omap_kp_probe,
> -	.remove		= __devexit_p(omap_kp_remove),
> +static struct platform_driver twl4030_kp_driver = {
> +	.probe		= twl4030_kp_probe,
> +	.remove		= __devexit_p(twl4030_kp_remove),
>  	.driver		= {
>  		.name	= "twl4030_keypad",
>  		.owner	= THIS_MODULE,
> @@ -405,19 +472,18 @@ static struct platform_driver omap_kp_dr
>  /*
>   * OMAP TWL4030 Keypad init
>   */
> -static int __devinit omap_kp_init(void)
> +static int __init twl4030_kp_init(void)
>  {
> -	return platform_driver_register(&omap_kp_driver);
> +	return platform_driver_register(&twl4030_kp_driver);
>  }
> +module_init(twl4030_kp_init);
>  
> -static void __exit omap_kp_exit(void)
> +static void __exit twl4030_kp_exit(void)
>  {
> -	platform_driver_unregister(&omap_kp_driver);
> +	platform_driver_unregister(&twl4030_kp_driver);
>  }
> +module_exit(twl4030_kp_exit);
>  
> -module_init(omap_kp_init);
> -module_exit(omap_kp_exit);
> -MODULE_ALIAS("platform:twl4030_keypad");
>  MODULE_AUTHOR("Texas Instruments");
> -MODULE_DESCRIPTION("OMAP TWL4030 Keypad Driver");
> +MODULE_DESCRIPTION("TWL4030 Keypad Driver");
>  MODULE_LICENSE("GPL");
> --- a/drivers/input/keyboard/twl4030-keypad.h
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -/*
> - * drivers/input/keyboard/twl4030-keypad.h
> - *
> - * Copyright (C) 2006-2007 Texas Instruments, Inc.
> - *
> - * Intial Code:
> - *	Syed Mohammed Khasim <x0khasim@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -#ifndef __TWL4030_KEYPAD_H__
> -#define __TWL4030_KEYPAD_H__
> -
> -/* Register Definitions */
> -#define KEYP_CTRL				0x00
> -#define KEYP_DEB				0x01
> -#define KEYP_LONG_KEY				0x02
> -#define KEYP_LK_PTV				0x03
> -#define KEYP_TIMEOUT_L				0x04
> -#define KEYP_TIMEOUT_H				0x05
> -#define KEYP_FULL_CODE_7_0			0x09
> -#define KEYP_ISR1				0x11
> -#define KEYP_IMR1				0x12
> -#define KEYP_EDR				0x16
> -#define KEYP_SIH_CTRL				0x17
> -
> -/* KEYP_CTRL_REG Fields */
> -#define KEYP_CTRL_SOFT_NRST			0x01
> -#define KEYP_CTRL_SOFTMODEN			0x02
> -#define KEYP_CTRL_LK_EN				0x04
> -#define KEYP_CTRL_TOE_EN			0x08
> -#define KEYP_CTRL_TOLE_EN			0x10
> -#define KEYP_CTRL_RP_EN				0x20
> -#define KEYP_CTRL_KBD_ON			0x40
> -
> -
> -#define KEYP_CTRL_NOAUTORPT			(KEYP_CTRL_SOFT_NRST |	\
> -						 KEYP_CTRL_SOFTMODEN |	\
> -						 KEYP_CTRL_TOE_EN |	\
> -						 KEYP_CTRL_KBD_ON)
> -
> -/* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
> -#define KEYP_PERIOD_US(T, prescale)		(T / (31 << (prescale + 1)) - 1)
> -
> -/* KEYP_LK_PTV_REG Fields */
> -#define KEYP_LK_PTV_PTV_SHIFT			5
> -
> -/* KEYP_IMR1 Fields */
> -#define KEYP_IMR1_MIS				0x08
> -#define KEYP_IMR1_TO				0x04
> -#define KEYP_IMR1_LK				0x02
> -#define KEYP_IMR1_KP				0x01
> -
> -/* KEYP_EDR Fields */
> -#define KEYP_EDR_KP_FALLING			0x01
> -#define KEYP_EDR_KP_RISING			0x02
> -#define KEYP_EDR_KP_BOTH			0x03
> -#define KEYP_EDR_LK_FALLING			0x04
> -#define KEYP_EDR_LK_RISING			0x08
> -#define KEYP_EDR_TO_FALLING			0x10
> -#define KEYP_EDR_TO_RISING			0x20
> -#define KEYP_EDR_MIS_FALLING			0x40
> -#define KEYP_EDR_MIS_RISING			0x80
> -
> -/* KEYP_SIH_CTRL Fields */
> -#define KEYP_SIH_CTRL_COR			0x04
> -#define KEYP_SIH_CTRL_PEND_DIS			0x02
> -#define KEYP_SIH_CTRL_EXCL_EN			0x01
> -
> -#endif	/* End of __TWL4030-KEYPAD_H__ */
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -302,11 +302,19 @@ struct twl4030_madc_platform_data {
>  	int		irq_line;
>  };
>  
> +/* Boards have uniqe mappings of {col, row} --> keycode.
> + * Column and row are 4 bits, but range only from 0..7;
> + * a PERSISTENT_KEY is "always on" and never reported.
> + */
> +#define KEY_PERSISTENT		0x00800000
> +#define KEY(col, row, keycode)	(((col) << 28) | ((row) << 24) | (keycode))
> +#define PERSISTENT_KEY(c, r)	KEY(c, r, KEY_PERSISTENT)
> +
>  struct twl4030_keypad_data {
> -	int rows;
> -	int cols;
> -	int *keymap;
> -	unsigned int keymapsize;
> +	unsigned rows;
> +	unsigned cols;
> +	unsigned *keymap;
> +	unsigned short keymapsize;
>  	unsigned int rep:1;
>  };
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
