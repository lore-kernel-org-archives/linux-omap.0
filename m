From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH] LCD backlight
Date: Fri, 11 Aug 2006 13:51:02 +0200
Message-ID: <fb249edb0608110451s7e85c6bfldbf98875857f6983@mail.gmail.com>
References: <fb249edb0606291235t1522f11di19c33f6a2fef8480@mail.gmail.com>
	<20060811110951.GM6720@atomide.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060811110951.GM6720@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 11/08/06, Tony Lindgren <tony@atomide.com> wrote:
> * andrzej zaborowski <balrog@zabor.org> [060629 22:36]:
> > Add a simple driver for the LCD backlight that uses the Linux backlight api.
> > ---
> > Some notes:
> >
> > The "check_fb" field is for the boards that have more than one LCD.
> > The "set_power" field is for boards that need to do something special
> > (e.g. GPIOs) before enabling the backlight. You can leave them unset.
> >
> > You can use this driver only on boards that don't use UART3 because
> > UART3.TX and PWL use the same pin. Does someone know an easy
> > workaround for this pin conflict? PalmOS 5 running on OMAP311 somehow
> > manages to send and receiver IrDA through UART3 and you can't see any
> > change in the backlight level. In Linux when I set this pin to be
> > UART3.TX, the backlight level is always forced to 255.
>
> No idea. Maybe you can mux some other pin for UART3.TX?

I'm not sure how this happens but now I have both IrDA and PWL working
and the pin is set to work as PWL.

>
> Could you please post a Signed-off-by for this patch too?

I will need to rediff it because it seems the backlight API changed in
current git a bit. BTW Also I noticed that struct lcd_panel (in the
OMAP LCD driver) now has pointers for intensity setters and getters
for potential use. Maybe it should be somehow coupled with backlight
api (e.g. using "notifiers").

I will post a new version this week, if this is OK.

>
> Thanks,
>
> Tony
>


-- 
balrog 2oo6

Dear Outlook users: Please remove me from your address books
http://www.newsforge.com/article.pl?sid=03/08/21/143258
