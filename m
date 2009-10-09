From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 11:36:42 +0100
Message-ID: <20091009103642.GA5082@sirena.org.uk>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<200910081638.24229.peter.ujfalusi@nokia.com>
	<20091008135342.GJ29176@rakim.wolfsonmicro.main>
	<200910090953.21066.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200910090953.21066.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 09, 2009 at 09:53:21AM +0300, Peter Ujfalusi wrote:
> On Thursday 08 October 2009 16:53:42 ext Mark Brown wrote:

> Adding a widget with actual alsa control seams to be problematic, since those 
> are working with the codec's registers, so adding such a widget would require to 
> implement a new set of .info .get  and .set functions for the TPA alone.

Yes, chips like this are the major reason for needing to support having
more than one CODEC device in the core.

> Or should I add individual HP for the two channels:
> HP("TPA6130A2 Headphone Left")
> HP("TPA6130A2 Headphone Right")

> Than in machine driver just connect (for example rx51):
> {"TPA6130A2 Left", NULL, "LLOUT"},
> {"TPA6130A2 Right", NULL, "RLOUT"},

That's what I was thinking of, yes.
