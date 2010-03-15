From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI troubles
Date: Mon, 15 Mar 2010 10:38:38 -0400
Message-ID: <4B9E466E.3040405@whoi.edu>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4b9d9f11.9a15f10a.3902.6dc3-ATjtLOhZ0NVl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/14/2010 10:44 PM, Ben Gamari wrote:
> 
> When measuring the SIMO signal on the expansion connector with my daughterboard
> connected, I noticed that the daughterboard's level shifter appeared to be
> driving the signal higher than it should, to ~2.9 Volts. I then checked the
> 1.8V rail voltage and found that it too was higher than expected, again at 2.9
> volts. When I unplug the daughterboard, the 1.8V rail voltage returns to its
> expected value.
> 
> I'm both perplexed and concerned with this behavior. I completely fail to
> see how my board is raising the voltage on the 1.8V rail (schematic available
> at [3]).  While the BeagleBoard seems quite stable, I'm very concerned that
> perhaps the daughterboard over-drove the SIMO ball and burned out some subset
> of the OMAP.  Regardless, as mentioned earlier, I have verified the
> functionality of the same ball as a GPIO input. Thus, I am thoroughly confused.
> Is it possible that the ball's GPIO receiver could remain functional while the
> McSPI receiver is burned out?
>
> [3] http://goldnerlab.physics.umass.edu/git?p=tracker-board.git;a=summary

I'd be happy to check your circuit for you, if it were posted in a more
widely used format.  How about a PDF of the schematic.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
