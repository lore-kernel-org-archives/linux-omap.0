From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 2/3] drivers: spi: Add qspi flash controller
Date: Tue, 9 Jul 2013 07:32:43 -0500
Message-ID: <51DC02EB.8070905@ti.com>
References: <1373290980-17883-1-git-send-email-sourav.poddar@ti.com>
	<1373290980-17883-3-git-send-email-sourav.poddar@ti.com>
	<20130708203330.GA28322@kahuna>
	<20130709065143.GC5552@arwen.pp.htv.fi>
	<20130709100525.GR27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130709100525.GR27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/09/2013 05:05 AM, Mark Brown wrote:
> On Tue, Jul 09, 2013 at 09:51:43AM +0300, Felipe Balbi wrote:
>
>>> Looks like a case to use regmap?
>>> Dumb q: why cant we use regmap_spi? worst case, you should be able to
>
>> read regmap-spi and you'll see why it can't be used in this case.
>
>> regmap-spi is for SPI clients who want to read their register map
>> through SPI commands. This is a driver for the SPI master which has its
>> registers memory mapped.
>
> Indeed, regmap-spi would be a client of this driver.  Though there is
> regmap-mmio which may be helpful, on the other hand it's relatively
> heavyweight and SPI can be a bit performance sensitive so perhaps it's
> not awesome here.  Russell did mention the idea of some helpers along a
> similar style though, they may be a good idea but nobody wrote them yet.
>
Fair enough. I am starting to see at least a second driver (internally 
for DRA7 IRQ/DMA crossbar) doing the same handling for different bit 
sized registers. maybe now is the time for us to create a lighter 
version of mmio. mmio at least the last I looked uses spinlocks and is 
fairly fast. But, I agree, when the client of regmap uses locks to 
protect operations of their own, regmap might be a bit of an overhead. 
that said, replicating regmap logic in the driver looks a bit weird and 
might allow the basis for other drivers to do the same as well as some 
users of mmio would consider themselves performance sensitive :(.

-- 
Regards,
Nishanth Menon

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
