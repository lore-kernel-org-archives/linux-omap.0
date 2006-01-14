From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] McBSP support on omap24xx
Date: Fri, 13 Jan 2006 17:27:05 -0800
Message-ID: <20060114012705.GR5499@atomide.com>
References: <20060110105245.80937.qmail@web32913.mail.mud.yahoo.com>
	<0ISW0094BW7LPP@mmp2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <0ISW0094BW7LPP@mmp2.samsung.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [060110 20:52]:
> > 
> > > I wait you SPI patch, In fact, I don't know SPI framework.
> > > 
> > > To test audio, we also modify sound/oss/omap-* files.
> > > After some cleanup I will send it ASAP
> > 
> > Please post the McBSP and changed audio related files for 24xx, once
> > you get time to the list. Atelast McBSP code can be merged the git
> > tree, as audio works with your 24xx custom board.
> > 
> 
> Here's McBSP patch on omap24xx
> 
> Any comments are welcome.
> 
> p.s., Yes there's TSC mux settings for future use.

Thanks, updated for clk_enable and manually merged the mux entries. Can
you please verify?

Tony
