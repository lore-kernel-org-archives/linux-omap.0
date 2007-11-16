From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix compiler error when I2C_OMAP is not set
Date: Fri, 16 Nov 2007 15:45:25 -0800
Message-ID: <20071116234524.GL32675@atomide.com>
References: <20071116003649.GA27407@party>
	<20071116110145.6d1ff472.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071116110145.6d1ff472.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [071116 01:01]:
> "ext Kyungmin Park" <kyungmin.park@samsung.com> wrote:
> 
> > Fix compiler error when I2C_OMAP is not set
> > 
> > --- a/include/asm-arm/arch-omap/common.h
> > +++ b/include/asm-arm/arch-omap/common.h
> >
> Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Pushing today.

Tony
