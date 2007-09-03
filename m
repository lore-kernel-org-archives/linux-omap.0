From: Tony Lindgren <tony@atomide.com>
Subject: Re: [01/17 PATCH] MMC: OMAP: Introduces new structures for MMC
	multislot support.
Date: Mon, 3 Sep 2007 08:45:11 -0700
Message-ID: <20070903154510.GC21056@atomide.com>
References: <46C5F08D.7070207@indt.org.br>
	<200708171445.28921.david-b@pacbell.net>
	<200708171455.15439.david-b@pacbell.net>
	<46DC1262.1000002@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46DC1262.1000002@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [070903 07:00]:
> ext David Brownell wrote:
> > On Friday 17 August 2007, David Brownell wrote:
> >   
> >> On Friday 17 August 2007, Carlos Aguiar wrote:
> >>     
> >>> Introduces new structures for MMC multislot support.
> >>>       
> >> Seems like #1 and #2 should be a single patch, since
> >> after #1 it won't compile ...
> >>     
> >
> >   
> Hi Dave,
> > ... and maybe #3, and ... ?
> >   
> You're right! But this 'level of granularity' of the patches was
> requested by Tony.

Huh? Naturally the patch series should compile and work after each
step no matter what "level of granularity".

> > Also, this doesn't look to me primarily like "multislot"
> > support.  It's also "stop relying on GPIOs" for various
> > things that newer boards handle with external chips
> > (like CD and WP switches), and "move board-specific code
> > out of the MMC driver"...
> >   
> The concept of multislot applied here is to provide a code (and needed
> modifications) that runs OMAP platforms with a single and/or two MMC slots.

Carlos, what Dave is saying above is that the patches don't do what you have
in the patch description. You should try to do a series of independent
easy to read patches that match the patch description.

Regards,

Tony
