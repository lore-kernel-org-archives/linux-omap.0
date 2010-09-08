From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] OMAP: McBSP: Fix static function warning
Date: Wed, 8 Sep 2010 10:28:36 +0300
Message-ID: <20100908102836.04e64383.jhnikula@gmail.com>
References: <1283916223-23567-1-git-send-email-manjugk@ti.com>
	<201009080903.09652.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201009080903.09652.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Nishanth Menon <nm@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, "ext G,
	Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, 8 Sep 2010 09:03:09 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> On Wednesday 08 September 2010 06:23:43 ext G, Manjunath Kondaiah wrote:
> > This patch fixes sparse warning due non declaration of static function
> > 
> > sound/soc/omap/omap-mcbsp.c:783:5: warning: symbol
> > 'omap_mcbsp_st_info_volsw' was not declared. Should it be static?
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: alsa-devel@alsa-project.org
> > Cc: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Nishanth Menon <nm@ti.com>
> 
> The patch name could be ASoC: omap-mcbsp: ...
> 
> Other than that:
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Yep, name should start with ASoC.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
