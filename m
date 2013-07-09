From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 2/3] drivers: spi: Add qspi flash controller
Date: Tue, 9 Jul 2013 09:53:21 -0500
Message-ID: <20130709145321.GA1680@kahuna>
References: <1373290980-17883-1-git-send-email-sourav.poddar@ti.com>
	<1373290980-17883-3-git-send-email-sourav.poddar@ti.com>
	<20130708203330.GA28322@kahuna>
	<20130709065143.GC5552@arwen.pp.htv.fi> <51DC072F.40704@ti.com>
	<20130709144043.GV27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130709144043.GV27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 15:40-20130709, Mark Brown wrote:
> On Tue, Jul 09, 2013 at 07:50:55AM -0500, Nishanth Menon wrote:
> 
> > with this input and looking closer, I think I see what you are saying now:
> > dra7xxx_qspi_prepare_xfer -> does a pm_runtime_get_sync
> > dra7xxx_qspi_unprepare_xfer -> does a pm_runtime_mark_last_busy,
> > pm_runtime_put_autosuspend
> 
> > In between these calls, you have the remaining xfer calls going on.
> > we are assuming here that autosuspend timeout should be greater than
> > the time to complete the worst case transfer.
> 
> No, autosuspend will do nothing so long as there are references to the
> device held.  The effect of autosuspend is to delay power down after the
> last reference has been dropped, otherwise things run normally.

Thanks on the clarification. That concludes my confusion on the topic
:).

-- 
Regards,
Nishanth Menon

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
