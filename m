From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Asynchronous clock disable
Date: Sun, 7 Oct 2007 20:51:25 -0700
Message-ID: <20071008035124.GA11220@atomide.com>
References: <20071005125028.GA32101@angel.research.nokia.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429021E0463@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429021E0463@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [071005 06:29]:
> 
> > Subject: [PATCH] OMAP: Asynchronous clock disable
> 
> Generally I think something like this is good.  Internally I've been
> calling this clock_disable_lazy().
> 
> For OMAP3 we have been trying to make drivers more aggressive in their
> FCLCOK handling.  As much of this control happens in bottom layers of
> large stacks, we don't always know the call frequency on all entry
> points into a driver.  This call can have local clock implications like
> you are seeing and also power domain and chip wide ones.
> 
> As for what is the right number for each driver we were floating ideas
> like if you have an active inner region of the driver, it should use a
> small number and for outer regions use a larger number.
> 
> * If you don't have the time or knowledge to instrument these drivers
> call in points as their may be many (or to be more future proof with
> less maintenance) it might be ok to set the time out to coincide with
> some global system wide or domain wide activity timers.
> 
> This might apply more to say power domains, but one point is, if the
> display is on and the user is interacting the touch screen, it is
> impossible to hit _chip_ OFF modes anyway.  This will only happen after
> the screen has blanked.  Thus for some timers having them approximately
> set to user input speeds might be ok.  Once these major events have
> happened (screen blank and no input activity), it now becomes about
> optimizing duty cycle of chip low power modes.  In this case shorter
> timer outs are better as they are more impacting in that system mode.
> 
> I'll try to look at actual code a bit more later on.

Sounds like this could also allow the same performance as keeping clocks
on all the time for some drivers.

We just have to take care not to use it too much with timers going off
all the time :)

Tony
