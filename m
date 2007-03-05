From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] add ssi/Kconfig to arch/arm/Kconfig
Date: Mon, 5 Mar 2007 12:32:00 -0800
Message-ID: <20070305203200.GA23319@skellington.corp.google.com.corp.google.com>
References: <85ps7pgphq.fsf@orfeo.duckcorp.org>
	<45EAFDBA.9010406@googlemail.com>
	<85r6s4damj.fsf@orfeo.duckcorp.org>
	<20070305100136.GC17801@atomide.com>
	<45EC7605.8060808@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45EC7605.8060808@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

[Dirk Behme <dirk.behme@googlemail.com>]
> >
> >I agree, let's get rid of the old drivers/ssi, anything using it should
> >be updated to use drivers/spi.
> 
> Yes.

...

> * drivers/video/omap/lcd_p2.c
> 
> -> update to use drivers/spi/omap-uwire
> -> jekyll & B Jp & Brian Swetland?

I'm not actively working with p2/fsample at the moment and the next
couple weeks are looking pretty busy -- I'm happy to take a look at
this when I get some cycles, but I'm not sure when that'll be.

If somebody wants to take a shot at just getting it to build under
the new interface, I can try to verify that it works on fsample 
at some point.

Brian
