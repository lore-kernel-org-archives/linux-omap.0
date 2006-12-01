From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH] ARM:  Add clocksource driver for OMAP1 and OMAP2
Date: Fri, 01 Dec 2006 11:03:17 -0800
Message-ID: <20061201190317.B12841DFAE4@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <4550A70B.7020609@gmail.com>
	<200611301114.09352.david-b@pacbell.net> <456F4025.5010403@gmail.com>
	<200611301322.35918.david-b@pacbell.net> <45707299.3080207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45707299.3080207@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: dirk.behme@googlemail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > +		clocksource_khz2mult(32768, clocksource_32k.shift);
>
> Using clocksource_hz2mult instead (you see, hz vs. khz) does 
> the trick here ;)

Ah, the old "off by one (letter)" trick.  I knew it had to be
something like that ... thanks!  :)

Evidently you agree that using a second timer is appropriate.

However, I'm not sure that a better solution might not be to
register the 32k timer clocksource by default (except on 1510),
since it seems cheap (and "always available").  Clocksource
logic can select a higher precision one if it's available.

Even with as many non-32k timer options as OMAP has (dmtimer for
both OMAP1 and OMAP2, MPU timer for OMAP1, 32k), I could imagine
usage conflicts, as reported this AM on l-a-k for ixp4xx.  And
the only really general way around those seems to be a Kconfig
option for which clocksource to use (other than 32k sync timer).

Comments?

- Dave
