From: Tony Lindgren <tony@atomide.com>
Subject: Re: OSK5912 and CF and network broken?
Date: Wed, 15 Mar 2006 10:36:45 -0800
Message-ID: <20060315183645.GC14010@atomide.com>
References: <20060315183006.GA16873@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060315183006.GA16873@smtp.west.cox.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tom Rini <trini@kernel.crashing.org> [060315 10:31]:
> Hello.  I'm trying to use current linux-omap-2.6 (source.mvista.com one)
> git with the omap_osk_5912_defconfig and with U-Boot 1.1.4 release (+ 2
> patches from this list).  I can bring the board up just fine but when I
> insert a CF device I see:
> pccard: PCMCIA card inserted into slot 0
> pcmcia: registering new device pcmcia0.0
> NETDEV WATCHDOG: eth0: transmit timed out
> ...
> NETDEV WATCHDOG: eth0: transmit timed out
> pccard: card ejected from slot 0
> 
> Has anyone seen this before?  Or should I just looking at the interrupt
> routes?  I'm assuming that the board does support me using both CF and
> network at the same time.  Thanks!

This should not happen... It sounds like an issue with the flash bus timings.
Might be worth grepping for EMIFS_CS values.

Tony
