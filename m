From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Mon, 12 Oct 2009 12:28:25 +0300
Message-ID: <1255339705.30157.241.camel@eenurkka-desktop>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
	<20091008131702.GC29176@rakim.wolfsonmicro.main>
	<1255064967.30157.178.camel@eenurkka-desktop>
	<20091009104458.GB5082@sirena.org.uk>
	<1255328261.30157.227.camel@eenurkka-desktop>
	<20091012091234.GB3308@rakim.wolfsonmicro.main>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091012091234.GB3308@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 2009-10-12 at 11:12 +0200, ext Mark Brown wrote:
> On Mon, Oct 12, 2009 at 09:17:41AM +0300, Eero Nurkkala wrote:
> 
> > Indeed. If I'm not totally wrong, the sidetone engineering is such,
> > that the sinetones should be of constant volume (this may depend on
> > the usecase). So, let's say we have the TPA6130 codec's volume used
> > along with a sidetone:
> 
> > 1. A change in TPA6130 volume should lead to a change in
> >    the sidetone's gain (if it's enabled). The change of gain
> >    is directly related to the change in the TPA's volume.
> 
> Could you go into more detail about why there should be a relationship
> between the two gains?

As mentioned, in some (or most) cases the absolute sinetone level (dB)
is expected constant. Even a volume change should not effect the
sidetone level. Thus, if there's a change in volume, the sidetone gains
should be readjusted. If that can happen automatically, that would
be just nice =)

I don't know whether there "should" be a relationship, but if there was,
that'd be very useful. But it gets complicated as there may be
several volume controls in the path. Anyway, that was just an idea that
may just as well be ignored.
