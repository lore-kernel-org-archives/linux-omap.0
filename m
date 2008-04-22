From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 1/1] ASoC: Add drivers for the
	Texas	Instruments OMAP processors
Date: Tue, 22 Apr 2008 09:49:28 +0100
Message-ID: <20080422084928.GA1853@rakim.wolfsonmicro.main>
References: <1207300948-11598-1-git-send-email-jarkko.nikula@nokia.com>
	<1207300948-11598-2-git-send-email-jarkko.nikula@nokia.com>
	<20080421181614.GZ12099@atomide.com>
	<20080422094845.722a949c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20080422094845.722a949c.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 22, 2008 at 09:48:45AM +0300, Jarkko Nikula wrote:
> "ext Tony Lindgren" <tony@atomide.com> wrote:

> > The platform_device_register() should be done in board-*.c files.

> This is a valid point. I think it should be possible to have also in
> ASoC v1 e.g n810_mcbsp_aic33 driver whose probe function would be more
> or less like n810_soc_init now. At least sound/soc/fsl/mpc8610_hpcd.c is
> doing similar thing.

> Mark, any thoughts?

Leave it as-is for ASoC v1, the soc-audio device can't meaningfully be
defined in the platform data.  ASoC v2 lets you define a device for the
platform driver for the particular board (as well as for things like I2S
controllers on the SoC) which deals with this a lot better.
