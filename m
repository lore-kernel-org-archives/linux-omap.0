From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
 viathe clock framework
Date: Tue, 21 Aug 2007 01:04:59 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
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

Hi Richard,

On Mon, 20 Aug 2007, Woodruff, Richard wrote:

> I thought about doing this back when OMAP1 added this when I was more
> active on OMAP2.  However, I dropped it as it didn't have enough 'bang'
> in this form.  I think these registers (even in OMAP1) are widely
> mis-understood.  This is partially a TRM issue and one of complexity.
>
> Meaning you can set this register on a per-clock basis however they do
> nothing for run time except at L3/L4 domain change time.  In the
> OMAP-GIT code this means at retention time the PRCM has permission to
> shut off your ICLK assuming your module acknowledges it.

I see.  Thanks for the explanation.  So in practical terms, it seems best 
to just enable this for all clocks unconditionally, as before in pm.c, no?

> If the PM code
> does this manually (enable/disable) then this register has no effect.

So, if the clock's enable/disable bit in its ICLKEN register is touched in 
any way, the clock auto-idle bit is ignored?  Does that hidden state 
persist until reset?

> It does have a useful run time property in that it is one form to gate a
> clock stop state assuming you have not forced it.  This is one way to
> stop a cascade clock stop from happening when you are not expecting it.
> It would be a lighter weight way then the mutex which OMAP2-GIT code
> uses.  However, for that to work other code would have to change.

But that would only happen when going to retention or off, correct?

> Each IP-Module _does_ have an AUTOIDLE bit in its SYSCONIG space which
> does act as you might expect this bit to.  Setting this AUTOIDLE does
> save significant power.  It would be more useful to control that one
> from here.

Those cover potentially large numbers of clocks...  So in lieu of a more 
general power domain API, is there a reason not to set all of those bits 
unconditionally in pm.c?


- Paul
