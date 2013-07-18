From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 2/3] drivers: spi: Add qspi flash controller
Date: Thu, 18 Jul 2013 15:59:59 -0500
Message-ID: <51E8574F.3000905@ti.com>
References: <1374141687-10790-1-git-send-email-sourav.poddar@ti.com>
	<1374141687-10790-3-git-send-email-sourav.poddar@ti.com>
	<CA+7tXij7W_F0ZTQZ=YvK+qOLO+O-6WpTKxLerv8NXyrdydt7FA@mail.gmail.com>
	<20130718203934.GT22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130718203934.GT22506-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 07/18/2013 03:39 PM, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 12:08:30PM -0700, Trent Piepho wrote:
>> On Thu, Jul 18, 2013 at 3:01 AM, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org> wrote:
>
>>> +- ti,hwmods: Name of the hwmod associated to the QSPI
>
>> What is ti,hwmods?  It's not clear from the description.  It also
>> doesn't appear to be used in the driver.  At least, I did not find any
>> occurrence of "hwmods" in the driver code.
>
> It's a generic thing for all OMAPs which is handled by the core SoC
> support transparently on TI chips.
>
Here are some ancient documentation for the same (pre-device tree) world[1]
bindings documentation is available: 
Documentation/devicetree/bindings/arm/omap/omap.txt


[1] http://omapedia.org/wiki/HWMOD

-- 
Regards,
Nishanth Menon

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
