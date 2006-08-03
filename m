From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 3 Aug 2006 17:37:10 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506F17309@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Let me guess... You copy clock.c, gpio.c, dma.c, pm.c, etc to omap3
> directory and hack on it to make it work on omap3 and then call it
> omap3 and it's totally different from earlier code? :)

The process does go something like that.  PRCM is a huge change so clock
and pm won't be able to do much sharing. Many of the modules have been
upgraded.  Carrying around bug work arounds for dma or compatibility
modes isn't so great.  Backward compatible code sharing at bring up time
is less important as compared to validating things are working to
specification.

> AFAIK from chip to chip estimated 60 - 80% of internal omap devices
are
> same except for the bus address. And maybe some added features. What
is
> so different with omap3 if you can tell us something?

Camera with ISP is way different for one, Davainci can help there.
Other things are not so far from 2430.  More later on others...

Early access isn't always so great. Many parts of the system are staged
so major functional parts change (on SDP and sometimes silicon) through
the development process.  There are also generally a good number of
silicon/board/documentation bugs.  In previous cases there was no TRM
until you were about done.  Much less friendly documents exist before
that.

> I appreciate all that for sure. But it sure would be nice to have
> somebody dedicated to merging code for new processors at TI.

I can certainly pass that on.  It is not a new thought.

Regards,
Richard W.
