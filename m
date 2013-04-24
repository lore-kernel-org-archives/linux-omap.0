From: wally bkg <wb666greene-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Long latencies in spidev device driver break real-time performance on
	Panda/Beagle
Date: Wed, 24 Apr 2013 07:56:41 -0500
Message-ID: <CANGjJb6FNHyUW5U3=sUMOEpUSuDjCF25a14AxkNDkoBnvjr2qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I've been trying to run a real-time process to feed a D/A chip using the
spidev driver but am finding the call to /dev/spidevX.Y is responsible for
"random" very long latencies that do not occur if I call the "driver" to
toggle a GPIO pin instead.

My most recent attempts have been with Robert Nelson's 3.9-rc6 kernel for
the Pandaboard ES and he has suggested I contact the OMAP and SPI
maintainers, hence I am sending this message.

Details are here:
http://eewiki.net/display/linuxonarm/PandaBoard_Comments?focusedCommentId=13599653&#comment-13599653

A sample test program that will illustrate the issue can be downloaded
here:
http://eewiki.net/download/attachments/12059008/swave_spidev.c?version=1&modificationDate=1365778735227&api=v2


Robert has run this test code (after changing the GPIO and spidev name
strings for the Beagleboard) and has found the xM is much closer to usable,
but what is curious is that the worst case and number of "missed samples"
are made worse when running as root.

Hoping you have a solution.
--wally.
------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
