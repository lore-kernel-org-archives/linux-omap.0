From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] keypad platform_data and 24xx support refresh
Date: Sun, 15 Jan 2006 18:25:13 +0200
Message-ID: <1137342313.7691.11.camel@two.research.nokia.com>
References: <20060115102754.73099.qmail@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060115102754.73099.qmail@web32910.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sun, 2006-01-15 at 02:27 -0800, ext Komal Shah wrote:

> Attached patch is refresh against the latest git head, from the
> earlier patch as per following thread.

Looks good, except:

> +#ifdef CONFIG_MACH_OMAP_H4
> +#define NUM_ROWS 6
> +#define NUM_COLS 7

> +static unsigned int row_gpio_num[NUM_ROWS] = { 88, 89, 124, 11, 6, 96 };
> +static unsigned int col_gpio_num[NUM_COLS] = { 90, 91, 100, 36, 12, 97, 98 };

Why not use the platform_data for this information, too?  It's kind of
bad to assume this for all the 2420 boards.

>  static int test_keymap[] = {
>         KEY(0, 0, KEY_F4),
>         KEY(1, 0, KEY_LEFT),

This can go away, too.  We'll put it into board-nokia770.c.

> +#ifdef CONFIG_MACH_OMAP_H4
> +static void set_col_gpio_val(u8 value)

Not H4 but OMAP2.

> +       if (machine_is_omap_h4()) {

Ditto.

There's also a fairly important patch we haven't published yet.  The
patch provides a work-around to the "ghost key" problem that happens
when necessary precautions have not been made in the keypad HW design.
If there are three (or more) keys pressed at the same time, and they
form a triangle on the keypad matrix, the HW thinks there are some extra
keys pressed.

Unfortunately I don't have time now to come up with a proper patch, but
I've put our version of the driver here:
http://jemmari.tky.hut.fi/~jey/omap-keypad.c

Cheers,
Juha
