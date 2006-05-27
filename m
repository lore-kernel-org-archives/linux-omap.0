From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: fix GPIO IRQ mask handling [was Re: [RFC]
	ARM: OMAP: handle lazy IRQ disable properly]
Date: Fri, 26 May 2006 17:22:01 -0700
Message-ID: <200605261722.04793.david-b@pacbell.net>
References: <1144008267.8058.58.camel@bitbox.mine.nu>
	<1148471720.28420.32.camel@mammoth.research.nokia.com>
	<20060526225907.GL4132@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060526225907.GL4132@atomide.com>
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
To: linux-omap-open-source@linux.omap.com
Cc: michl@2n.cz, "Yrjola Juha (Nokia-M/Helsinki)" <Juha.Yrjola@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Friday 26 May 2006 3:59 pm, Tony Lindgren wrote:

> 
> Great, hopefully this will finally fix the last GPIO irq issues!

Just in time to phase in the new generic IRQ infrastructure.  :)

One of the GPIO IRQ issues gets resolved there by having the analogue
of do_simple_IRQ() test for disabled IRQs like all the other dispatchers.
Better do it there than in drivers or platform irq code...

- Dave
