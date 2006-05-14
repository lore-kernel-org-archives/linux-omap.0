From: David Brownell <david-b@pacbell.net>
Subject: Re: is dynamic tick working?
Date: Sun, 14 May 2006 09:19:08 -0700
Message-ID: <200605140919.09540.david-b@pacbell.net>
References: <200605121905.13405.david-b@pacbell.net>
	<20060514104911.GB4715@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060514104911.GB4715@atomide.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Sunday 14 May 2006 3:49 am, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [060512 19:05]:
> > In short, enabling dyntick got me 14x as many IRQs, instead of
> > shrinking the number of IRQs.  Known bug?
> 
> Is this with touchscreen enabled? I saw something similar last week
> where SPI was generating interrupts continuously. I think Imre has a
> patch for that already available.

It was, but I don't think I've seen such a patch yet.

I had noticed that the ads7846 code grew a glitch whereby its timer
polls for position even when the "pen" isn't down.  That's oddly
similar to a glitch in omap-keyboard, where it keeps a timer active
even when no Mistral key is pressed.


> In general dyntick should work, and you should see about 4-6HZ idle
> tick rate.

Depending on drivers, it seems ... ;)

I have a patch to get rid of the OHCI root hub polling, which will
get rid of one 4Hz timer.

- Dave
