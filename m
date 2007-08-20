From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
	viathe clock framework
Date: Mon, 20 Aug 2007 07:55:26 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070820095532.728389316@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> Existing OMAP2 code autoidles clocks via pm.c.  OMAP clock framework
> already has some support for enabling autoidle mode via the allow_idle
> function; however, this is currently unused.  Take advantage of this
> support by adding autoidle register and bit information for each
> clock, defining an omap2_clk_allow_idle() function, and adding a
> framework-wide function, clk_allow_idle_all(), to autoidle all clocks,
> intended to be called on init.  Remove all but the APLL/DPLL autoidle
> bit twiddling from pm.c -- we don't yet have generalized support for
APLL
> autoidle.  Handling autoidle via the clock framework ensures that we
only
> touch clocks that are currently configured.

I thought about doing this back when OMAP1 added this when I was more
active on OMAP2.  However, I dropped it as it didn't have enough 'bang'
in this form.  I think these registers (even in OMAP1) are widely
mis-understood.  This is partially a TRM issue and one of complexity.

Meaning you can set this register on a per-clock basis however they do
nothing for run time except at L3/L4 domain change time.  In the
OMAP-GIT code this means at retention time the PRCM has permission to
shut off your ICLK assuming your module acknowledges it.  If the PM code
does this manually (enable/disable) then this register has no effect.

It does have a useful run time property in that it is one form to gate a
clock stop state assuming you have not forced it.  This is one way to
stop a cascade clock stop from happening when you are not expecting it.
It would be a lighter weight way then the mutex which OMAP2-GIT code
uses.  However, for that to work other code would have to change.

Each IP-Module _does_ have an AUTOIDLE bit in its SYSCONIG space which
does act as you might expect this bit to.  Setting this AUTOIDLE does
save significant power.  It would be more useful to control that one
from here. =20

If you hook up a current meter you can toggle all the CM_AUTOIDLES you
like and nothing will happen.  But if you do the same with the module
autoidle you will see a bit change.

Regards,
Richard W.
