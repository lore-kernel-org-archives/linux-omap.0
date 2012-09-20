From: Paul Walmsley <paul@pwsan.com>
Subject: Re: rcu self-detected stall messages on OMAP3, 4 boards
Date: Thu, 20 Sep 2012 07:56:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com> <20120913011208.GT4257@linux.vnet.ibm.com> <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com> <20120920000351.GI2455@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120920000351.GI2455@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>, linux-kernel@vger.kernel.org, bbruce@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, santosh.shilimkar@ti.com, jon-hunter@ti.com, snijsure@grid-net.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 19 Sep 2012, Paul E. McKenney wrote:

> On Thu, Sep 13, 2012 at 06:52:10PM +0000, Paul Walmsley wrote:
> 
> > On Wed, 12 Sep 2012, Paul E. McKenney wrote:
>  
> > > Subodh Nijsure (also CCed) reported something that might be similar on
> > > ARM, and also reported that setting the following got rid of the stalls:
> > > 
> > > 	CONFIG_CPU_IDLE=y
> > > 	CONFIG_CPU_IDLE_GOV_LADDER=y
> > > 	CONFIG_CPU_IDLE_GOV_MENU=y
> > > 
> > > At which point he was happy, which was good, but which also left the
> > > underlying problem unsolved.  Do these affect your system?  If so,
> > > do they cause a different ARM idle loop to be executed?
> > 
> > Will give this a try.  What board was Subodh using?
> 
> Any news on trying the above settings?

Sorry, haven't had the chance to try it yet due to the impending merge 
window opening.  Once things settle down I'll give it a try -- or maybe 
someone else can test it in the meantime.


- Paul
