From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] LCD backlight
Date: Fri, 11 Aug 2006 14:09:52 +0300
Message-ID: <20060811110951.GM6720@atomide.com>
References: <fb249edb0606291235t1522f11di19c33f6a2fef8480@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0606291235t1522f11di19c33f6a2fef8480@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrog@zabor.org> [060629 22:36]:
> Add a simple driver for the LCD backlight that uses the Linux backlight api.
> ---
> Some notes:
> 
> The "check_fb" field is for the boards that have more than one LCD.
> The "set_power" field is for boards that need to do something special
> (e.g. GPIOs) before enabling the backlight. You can leave them unset.
> 
> You can use this driver only on boards that don't use UART3 because
> UART3.TX and PWL use the same pin. Does someone know an easy
> workaround for this pin conflict? PalmOS 5 running on OMAP311 somehow
> manages to send and receiver IrDA through UART3 and you can't see any
> change in the backlight level. In Linux when I set this pin to be
> UART3.TX, the backlight level is always forced to 255.

No idea. Maybe you can mux some other pin for UART3.TX?

Could you please post a Signed-off-by for this patch too?

Thanks,

Tony
