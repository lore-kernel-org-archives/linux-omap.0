From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] keypad: platform_data and 24xx support -exp
Date: Fri, 13 Jan 2006 16:37:28 -0800
Message-ID: <20060114003728.GJ5499@atomide.com>
References: <20051210130228.91620.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051210130228.91620.qmail@web32905.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [051210 05:03]:
> Tony/Brian,
> 
> I have attached patch which includes:
> 
> o Modification suggested by Brian Swetland 
> o Added platform_data structure
>    - keymap is moved to appropriate board files.
>    - rows and cols fields are not used in the driver yet.
>    - rep bit is added.
> o IRQ resource
> o Added 24xx+menelaus keypad support - tested.
> 
> TODO/FIXME:
> o appropriate place for test_keymap.
> 
> o Removing NUM_COLS/ROWS #defines and replacing with
> platform_data->rows/cols.
> 
> o Moving request_gpio/free_gpio to board specific file, by introducing
> one function in platform_data ? Is this ok? e.g get/put_gpios. As
> driver should work as module too.
> 
> o How to handle row_/col_gpio_num array and set_/get_gpio_val functions
> ? I want to keep them out of this keypad.c. Any suggestions?

I like this patch, takes care of the keypad mapping problems nicely.
Can you please refresh it?

Tony
