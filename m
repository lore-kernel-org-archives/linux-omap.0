From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: SPI edge selection [was Re: Edge
	selecton on SPI bus]
Date: Fri, 26 May 2006 16:43:55 -0700
Message-ID: <20060526234355.GQ4132@atomide.com>
References: <1147691115.32613.10.camel@mammoth.research.nokia.com>
	<200605151159.37793.david-b@pacbell.net>
	<1147817569.27886.54.camel@mammoth.research.nokia.com>
	<200605161950.17041.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605161950.17041.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [060517 11:50]:
> 
> > I think the devices worked so far with this buggy logic since I suspect
> > a complementary problem in the TRM for the read edge selection HW flag.
> > I checked this against devices that are known to be using a given SPI
> > mode.
> 
> Hmm, I hope the attached GIF makes it through ... it shows the data
> and clock signals and their variations pretty clearly, though you need
> to understand that "out" means MOSI.
> 
> Agreed, the TRM is a bit opaque there.  There are three bits to
> cover two basic protocol options:  sample edge (2x) which seems
> to encode CPHA, and clock polarity which sure ought to be CPOL.  
> 
> 
> > Also at least the ads7846 was using incorrectly SPI mode 0, since it's
> > expecting writes on the falling / reads on the rising edge which maps to
> > mode 1.
> 
> Seems right ... does that give you more consistent sample readings?
> 
> 
> > I'm posting 3 patches to solve these issues.
> 
> They look OK to me.  I'd say to merge them to the OMAP tree; if no
> problems turn up, I'll push the ads7846 patch along soonish.

Pushed all 3 patches.

Tony
