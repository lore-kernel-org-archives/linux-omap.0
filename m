From: Tony Lindgren <tony@atomide.com>
Subject: Re: wake up from a serial port
Date: Mon, 27 Aug 2007 04:14:06 -0700
Message-ID: <20070827111405.GD13538@atomide.com>
References: <57314e840708251538l188c6ab1m6c568716c95d4ed1@mail.gmail.com>
	<20070827070626.GA30978@atomide.com>
	<57314e840708270138y2c270362i54fd928538a80a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <57314e840708270138y2c270362i54fd928538a80a87@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Budhee Jamaich <budheej@gmail.com> [070827 01:38]:
> On 8/27/07, Tony Lindgren <tony@atomide.com> wrote:
> > * Budhee Jamaich <budheej@gmail.com> [070827 00:00]:
> > > i am working on 2430 and I need to enable
> > > wakeup from a serial port.
> > >
> > > a patch which does this very thing has just been posted on lkml:
> > > http://article.gmane.org/gmane.linux.kernel/574545
> > >
> > > is it relevant to me ?
> > >
> > > or is there already a way to do that ?
> >
> > You also need to use the omap serial wake-up events, or mux rx pin
> > temporarily to a wake-up capable GPIO pin.
> 
> Are there any examples how to do either of these ?

Well it used to work at least for 5912OSK. Maybe grep for 
CONFIG_OMAP_SERIAL_WAKE.

> If I mux the rx pin to a wake-up capable GPIO pin - should I still apply the
> patch I mentioned above ?

That means you still have to have the functional clock for the UART
on, which will block omap retention. So using the async GPIO wake-up
events will be better.

> (And how can I do this muxing ? Is there an API for that ?)

See CONFIG_OMAP_SERIAL_WAKE.

> Thank you very much Tony.

No problem, if you get it working on 2430, please send patches :)

BTW, I never got the 2420 serial wake events to work, maybe they
need separate interrupt handlers registered. But the GPIO trick
should still work even if the serial wake-up events won't work.

Regards,

Tony
