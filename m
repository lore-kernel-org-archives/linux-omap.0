From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
 constraints for streams
Date: Tue, 1 Jun 2010 10:38:28 +0300
Message-ID: <20100601103828.55e7b394.jhnikula@gmail.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005311457.22699.peter.ujfalusi@nokia.com>
	<20100601093807.f4a9ec27.jhnikula@gmail.com>
	<201006010947.09640.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <201006010947.09640.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, ext@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, 1 Jun 2010 09:47:09 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> I like the following naming:
> omap_mcbsp_hwrule_min_buffersize()
> omap_mcbsp_hwrule_max_periodsize()
> 
Looks clear to me.

> Also, I think there is no point to limit the lower period size in threshold mode 
> to 32, so I will remove that as well I think.
> 
What was the reason why period size cannot be bigger than threshold?
This constraint was there before your patch but I don't remember reason
for it.

Should it be opposite that period size cannot be smaller than threshold?


-- 
Jarkko
