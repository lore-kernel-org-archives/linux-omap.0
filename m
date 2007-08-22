From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: OMAP2 McSPI code cleanup
Date: Wed, 22 Aug 2007 00:10:25 -0700
Message-ID: <20070822071024.GG24985@atomide.com>
References: <003901c7e0a3$08dc39d0$e1ac580a@swcenter.sec.samsung.co.kr>
	<200708170851.41052.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708170851.41052.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070817 08:52]:
> On Friday 17 August 2007, you wrote:
> > ARM: OMAP: OMAP2 McSPI code cleanup
> 
> SPI patches don't merge via the ARM or OMAP patch streams...
> 
> If you just send them for the OMAP tree they won't necessarily
> go upstream unless the SPI maintainer happens to notice them.

Yeah, we must get more active in general on the lists with I2C,
MMC, framebuffer...

> > Remove unused variable & write space

I'll push this to linux-omap while waiting for this to trickle
down from the mainline kernel.

Tony
