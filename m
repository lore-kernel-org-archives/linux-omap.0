From: Kevin Hilman <khilman@mvista.com>
Subject: Re: 3430 and UART3 parent clocks
Date: Tue, 20 Nov 2007 11:43:16 -0800
Message-ID: <1195587796.17706.12.camel@vence.hilman.org>
References: <1194982452.7433.55.camel@vence.hilman.org>
	<Pine.LNX.4.64.0711140221470.3713@utopia.booyaka.com>
	<1195052848.15127.30.camel@vence.hilman.org>
	<Pine.LNX.4.64.0711151356390.32494@utopia.booyaka.com>
	<1195264997.24857.27.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1195264997.24857.27.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: amit@verdurent.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


On Fri, 2007-11-16 at 18:03 -0800, Kevin Hilman wrote:
> On Thu, 2007-11-15 at 14:02 -0700, Paul Walmsley wrote:
> > Hi Kevin,
> > 
> > On Wed, 14 Nov 2007, Kevin Hilman wrote:
> > 
> > > On Wed, 2007-11-14 at 02:24 -0700, Paul Walmsley wrote:
> > >
> > > > ... What bootloader are you using?
> > > 
> > > u-boot from TI.  See the full console log attached for u-boot version
> > > and details, as well as the crash dump.
> > 
> > Thanks, that's very helpful.  Looks like we're running different 
> > bootloaders.  I suspect that the bootloader here may be enabling UART3 
> > itself, but need to investigate further.  I've included our bootlog 
> > below for comparison.
> 
> I think it's probably enabling more than the UART3 clock.  Probably the
> parent clocks too.
> 
> As a quick hack, if I just blindly enable all the ICLKEN and FCLKEN bits
> in omap2_clk_init() I can then boot without any problems.  

Paul,

I found the root cause of this (patch just posted.)

The PER_MOD based ICLKs were actually delcared in WKUP_MOD instead of
PER_MOD.  The result being that the clk_enable() calls for uart3_ick
were not actually enabling the right bit.

Kevin
