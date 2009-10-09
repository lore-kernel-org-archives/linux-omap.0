From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: OMAP: RX-51 Machine driver and
 AIC34b_dummy driver
Date: Fri, 9 Oct 2009 13:19:55 +0100
Message-ID: <20091009121955.GF5082@sirena.org.uk>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
	<20091008131116.GB29176@rakim.wolfsonmicro.main>
	<20091009084400.34df690a.jhnikula@gmail.com>
	<20091009063720.GC6616@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20091009063720.GC6616@esdhcp037198.research.nokia.com>
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
Cc: alsa-devel@alsa-project.org, ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 09, 2009 at 09:37:20AM +0300, Eduardo Valentin wrote:
> On Fri, Oct 09, 2009 at 07:44:00AM +0200, Jarkko Nikula wrote:

> > Yep, dummy driver is for block B of AIC34 which is basically dual AIC33
> > in a same package.

> Yes. This is correct.

So to software it just looks like two devices at separate I2C addresses
so once multi CODEC support is present there will be no need to have
specific support for it at all?

> > Eduardo, please correct me if I remember wrong  but block B of AIC34 is
> > not used as an codec as such but more like an amplifier and analogic
> > mixer with digital parts unused. So with this dummy driver the HW
> > features were easier to support than to develop multiple intance
> > support for codec drivers.

> Yes. This is also correct. It is more like an amplifier / mixer.
> I think that's why you named it dummy :-).

> But I think I should add this info as a comment inside the code.

Some words or ASCII art in the machine driver would help a lot, I think.
