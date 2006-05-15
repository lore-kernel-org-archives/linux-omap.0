From: David Brownell <david-b@pacbell.net>
Subject: Re: Edge selecton on SPI bus
Date: Mon, 15 May 2006 11:59:36 -0700
Message-ID: <200605151159.37793.david-b@pacbell.net>
References: <1147691115.32613.10.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1147691115.32613.10.camel@mammoth.research.nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Monday 15 May 2006 4:05 am, Imre Deak wrote:
> Hi,
> 
> I think the edge selection in the omap_uwire and omap2_mcspi is borked.
> I have a patch for it, but I'd like to ask first if my assumption is
> right:
> On the SPI / uWire bus by definition you can only configure a mode (one
> of the 4 modes), in which the read / write takes place on opposite
> edges. That is you can't configure for example a read rising edge /
> write rising edge mode.

That's my understanding, yes.  Consider that if you connect MOSI directly
to MISO for a loopback configuration, what you send is supposed to exactly
match what you receive ... that couldn't happen if there were no settling
time between setting MOSI and reading MISO.

That WRITE_FALLING | READ_FALLING always did look goofy, but I recall it
as more or less a direct translation from the old driver.  In any case
the REVISIT note seems to have gotten lost.

- Dave



> On OMAP2 this I even see from the fact that you can set the reading edge
> and the writing edge is implied.
> 
> --Imre
> 
> 
