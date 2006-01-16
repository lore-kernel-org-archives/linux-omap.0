From: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] keypad platform_data and 24xx support refresh
Date: Mon, 16 Jan 2006 20:17:33 +0200
Message-ID: <1137435453.12289.51.camel@two.research.nokia.com>
References: <20060116172406.3860.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060116172406.3860.qmail@web32905.mail.mud.yahoo.com>
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

On Mon, 2006-01-16 at 09:24 -0800, ext Komal Shah wrote:
> > > +#ifdef CONFIG_MACH_OMAP_H4
> > > +static void set_col_gpio_val(u8 value)
> > 
> > Not H4 but OMAP2.
> 
> Why? If 2430 falls into OMAP2 class then it's EVM design for keyboard
> is using TWL4030 i2c interface to read the values. Richard can clarify
> on this.

Only generic keypad drivers are supposed to live in omap-keypad.c.  I
had the impression that using GPIOs is the standard way of implementing
a keypad on OMAP2xxx CPUs (if you don't use an external keypad chip,
that is).  Is this not the case?  Keypads handled by companion chips
most likely will not share a lot of code with the OMAP-specific driver,
so they naturally belong to a separate driver.

Cheers,
Juha
