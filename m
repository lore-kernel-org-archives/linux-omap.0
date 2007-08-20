From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock
	autoidling viathe clock framework
Date: Mon, 20 Aug 2007 16:30:13 +0300
Message-ID: <1187616613.7307.10.camel@localhost.localdomain>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C91@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901AD7C91@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2007-08-20 at 08:18 -0500, ext Woodruff, Richard wrote:
> One further note is in the 'ideal' model you should never have to
> control your I-CLK at all just your F-CLK.  I'm sure our hardware people
> would be very pleased if the code moved in that direction (me too if it
> turned out to all work).  They generally dislike the idea of the clock
> frame work as they feel it allows duplication of work the hardware can
> do if setup properly.  Its APIs open up some choices which can nullify
> or reduce understanding of hardware capabilities. For OMAP1 there was no
> other way.  For OMAP2/3 there are some options. I do very much like the
> frame work but do understand their points.
> 
> Ideally, you set all idles at all levels and all async interrupt wake
> and use the PRCM interrupt to clear status at wake up time, then the
> system can handle all clocks based on dependency.  Iclocks can be
> managed automatically.  Fclocks should be dynamically controlled by
> drivers on a demand basis.  This means some activity timers. 

I'm not new to these concepts, however I find extremely hard to accept
the idea of using timers, since they assume to know what the duration of
the activity will be.

Could that work on an internet tablet?
For the tablet there is not really a set of use-cases like on a phone,
where you can have a closed set of fapplications and do some serious
profiling.

>  When this
> does work the savings are really massive and dramatic.  The catch in it
> is that one dependency break from a bad driver (sw or hw) at any of the
> multiple levels will stop it from working. 

And how easy is it to trace that? All the refcounting seems to be done
in HW ...

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
