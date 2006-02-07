From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap clock.h question
Date: Tue, 7 Feb 2006 12:52:23 -0800
Message-ID: <20060207205222.GD27148@atomide.com>
References: <20060207185951.GA5897@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060207185951.GA5897@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Brian Swetland <swetland@google.com> [060207 11:06]:
> 
> I'm trying to get the MMC driver working on OMAP730 -- currently it
> fails in probe because it can't obtain "mmc1_ck".  clocks.h has a
> definition for this, but only for 1510/16xx/310.  OMAP730 appears to use
> a different config register (PERSEUS_PCC_CONF) to enable this clock.
> 
> What's the correct way to support this?  Define another clock struct
> with the same name, but setup for 730?  

Yes, just add another clock for 730. BTW, the mmc driver is about to
change where you just request mmc_ick and mmc_fck on all omaps.

Tony
