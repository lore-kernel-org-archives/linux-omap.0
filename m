From: Tony Lindgren <tony@atomide.com>
Subject: Re: is dynamic tick working?
Date: Fri, 26 May 2006 16:44:37 -0700
Message-ID: <20060526234436.GR4132@atomide.com>
References: <200605121905.13405.david-b@pacbell.net>
	<446793B2.6040408@nokia.com> <20060515092253.GD8368@atomide.com>
	<200605151511.11836.david-b@pacbell.net>
	<20060516065945.GF3413@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060516065945.GF3413@atomide.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [060517 13:59]:
> * David Brownell <david-b@pacbell.net> [060515 15:11]:
> > On Monday 15 May 2006 2:22 am, Tony Lindgren wrote:
> > > 
> > > OK, I've pushed Imre's patches. Can you check that everything got
> > > patched OK?
> > 
> > I attach three patches:
> > 
> >  - To make Mistral work better needs new callback), which worked for
> >    me (modulo writing the "disable" file wedging, gotta retest that);
> 
> I'll push this patch today.
>   
> >  - A quickie bitbang SPI adapter for the 1510-Innovator FPGA hookup to ads7846,
> >    untested beyond compiling (no Innovator here!);
> >  
> >  - Removing the old OMAP-specific Mistral and Innovator touchscreen drivers;
> >    this may be a trifle premature given the lack of Innovator testing
> 
> Let's try these patches out before pushing. Can somebody with an
> Innovator test these patches? 

Pushed the Innovator patches too, nobody complained in time :)

Tony
