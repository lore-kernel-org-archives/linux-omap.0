From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 2/3] drivers: spi: Add qspi flash controller
Date: Thu, 18 Jul 2013 20:25:05 +0530
Message-ID: <51E801C9.60609@ti.com>
References: <1374141687-10790-1-git-send-email-sourav.poddar@ti.com>
	<1374141687-10790-3-git-send-email-sourav.poddar@ti.com>
	<20130718104233.GG22506@sirena.org.uk> <51E7D569.2010709@ti.com>
	<20130718131822.GN22506@sirena.org.uk>
	<20130718133158.GA1628@arwen.pp.htv.fi>
	<20130718144241.GO22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130718144241.GO22506-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,
On Thursday 18 July 2013 08:12 PM, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 04:31:58PM +0300, Felipe Balbi wrote:
>> On Thu, Jul 18, 2013 at 02:18:22PM +0100, Mark Brown wrote:
>>> So why do we report that we handled the interrupt then?  Shouldn't we at
>>> least warn if we're getting spurious IRQs?
>> not spurious. OMAP has two sets of IRQ status registers. One is call
>> IRQSTATUS$n (n = 0, 1, ...) and IRQSTATUS_RAW$n.
>> IRQSTATUS$n will only enable the bits which fired IRQs and aren't
>> masked while IRQSTATUS_RAW$n will also enable the bits which are masked.
>> I could never come up with a use case where we would need to handle IRQs
>> which we decided to mask, but perhaps there might be some cases, I don't
>> know.
>> Based on that, I believe Sourav is reading IRQSTATUS_RAW$n, then he need
>> to clear the masked bits.
> That's not the issue - the issue is that if none of the unmasked
> interrupts are being asserted we shouldn't be in the interrupt handler
> in the first place but the driver silently accepts that and reports that
> it handled the interrupt.
I believe this is what you hinted at doing..

there is a QSPI_INTR_STATUS_ENABLED_CLEAR register, which indicated the 
interrupt
status.
if nothing is set in the above register, I should return IRQ_NONE.

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
