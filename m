From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 00/20] OMAP ASoC changes in
	DMA	utilization
Date: Wed, 19 Aug 2009 09:26:33 +0100
Message-ID: <20090819082632.GA19168@sirena.org.uk>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
	<20090817170549.f0adf2a4.jhnikula@gmail.com>
	<20090819074011.GA25559@esdhcp037198.research.nokia.com>
	<20090819074835.GB25559@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090819074835.GB25559@esdhcp037198.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 19, 2009 at 10:48:35AM +0300, Eduardo Valentin wrote:
> On Wed, Aug 19, 2009 at 09:40:12AM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:

> > About these changes. I have one doubt. What is the correct tree to base them?
> > There are changes under arch/arm/plat-omap/ and under sound/soc/omap/.

...

> > Please do not apply this version. Let's define this first, then I send
> > the correct version.

> There is 1 Jarkko's patch which changes arch/arm/plat-omap/ which is already
> in Takashi's tree, IIRC.

I believe there's colisons with the OMAP1 stuff too.  Might be worth
applying these on a branch and then providing merges into both the ASoC
and OMAP trees?
