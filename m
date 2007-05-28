From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: write memory barrier
Date: Mon, 28 May 2007 09:36:12 +0300
Message-ID: <1180334172.18692.34.camel@Dogbert.NOE.nokia.com>
References: <1180304111.3430.31.camel@Dogbert.NOE.nokia.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901158463@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901158463@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux OMAP ml <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Richard,
please find my reply inlined.

On Sun, 2007-05-27 at 19:47 -0500, ext Woodruff, Richard wrote:
> Some more specifics might be helpful.

ok, i'll try to be more clear.

> Generally, the commit of a divider change should happen in SRAM.

Or from icache, after an appropriate pre-fetch of the critical section
of code that cannot be executed from sdram, right?

> Much
> of the effects should be synchronized with the commit for the clocks in
> listed as delayed.  When dividing by 2 SDRC/GPMC timings might require
> changes to keep their buses visible.

Right.

> Some clocks do have some side effects of changes, but it might be
> unlikely you access them quickly enough to see the effect.  M/N changes
> take a while.  Depending on I to F clock ratios and posted/non-posted
> timers might take a bit.


Here, if i've understood correctly, you are also referring to hw timing,
which certainly have to be considered, but I was thinking about
out-of-order execution and the compiler potentially reshuffling the
configuration i'm doing.

I'm changing the settings of CM_CLKSEL_* and my understanding is that
afterward, to have the changes applied, I have to write 1 to
PRCM_CLKCFG_CTRL[VALID_CONFIG]

My concern is that the write order is changed and
PRCM_CLKCFG_CTRL[VALID_CONFIG] gets written _before_ proper settings
have been programmed into CM_CLKSEL_* thus effectively leadinig to
either:
-invalid configuration and changes not been applied at all, which is
somehow preferrable to
-valid, but different from the expected, configuration, with some of the
new values applied and some of fthe old ones retained

So i guess my question (at the moment) boils down to:
do i have to insert a wmb (or maybe barrier, if the compiler is the only
entity that can change the order of execution) between the programming
of CM_CLKSEL_* and writing 1 to PRCM_CLKCFG_CTRL[VALID_CONFIG]?

Or: are my writes posted? How can I check/disable the posting or at
least make sure that all the settings have been applied before i flush
them?

I hope this clarifies the situation.

 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
