From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending patches mostly pushed, please check
Date: Tue, 3 Jan 2006 16:09:00 -0800
Message-ID: <20060104000900.GU6034@atomide.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com>
	<20060103204135.GA11610@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060103204135.GA11610@orphique>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [060103 12:41]:
> On Tue, Jan 03, 2006 at 11:13:56AM -0800, Tony Lindgren wrote:
> > Hi all,
> > 
> > I've pushed bunch of patches listed. Please check the status of
> > your patches below.
> > 
> > Also reply to this thread if you know if a patch that you think
> > should be pushed and has not been pushed yet. 
> 
> Umm, here is one more :-)
> 
> Remove support for board Netstar. I hope it helped to sort out various
> needs to drivers and now when nearly everything [1] was converted to
> platform device there is no more need to bother you with updates to
> board file :-). I'll maintain it as separate patch (using PTXdist).
> Thanks for all the fish :-)

OK, so long :) Pushing today.
 
> Best regards,
> 	ladis
> 
> [1] Oh, it seems USB host driver still contains those
>     machine_is_omap_xxx. Will fix that later...

OK

Tony
