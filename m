From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Mon, 12 Oct 2009 09:17:41 +0300
Message-ID: <1255328261.30157.227.camel@eenurkka-desktop>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
	<20091008131702.GC29176@rakim.wolfsonmicro.main>
	<1255064967.30157.178.camel@eenurkka-desktop>
	<20091009104458.GB5082@sirena.org.uk>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091009104458.GB5082@sirena.org.uk>
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

On Fri, 2009-10-09 at 12:44 +0200, ext Mark Brown wrote:
> On Fri, Oct 09, 2009 at 08:09:27AM +0300, Eero Nurkkala wrote:
> > On Thu, 2009-10-08 at 15:17 +0200, ext Mark Brown wrote:
> 
> > > This stuff, particularly the enable, probably wants to be pushed out via
> > > an ALSA API rather than via random sysfs stuff.  It'd be better to
> > > publish a control API here and then use that from within ALSA.
> 
> > Hmm. What would be the way to transfer 128 x s16 words; is there an ALSA
> > control for something like that already ? IIRC correctly, the max
> > bytesize per control is (or used to be) something like 256 bytes or so.
> > So that gets right at it. (that's the sidetone 128 tap FIR in question)
> 
> For things like the FIR you probably don't want to expose the entire
> table directly to user space.  Depending on the typical usage it may be
> that platform data is the appropriate mechanism, with some simpler thing
> presented to applications allowing switching between a limited set of
> settings.  sysfs may end up being the best option for the FIR setup.
> 
> My main concern here is that the control goes into the ALSA domain so
> that the audio drivers know what's going on with these sidetone paths,
> particular in terms of the routing.

Indeed. If I'm not totally wrong, the sidetone engineering is such,
that the sinetones should be of constant volume (this may depend on
the usecase). So, let's say we have the TPA6130 codec's volume used
along with a sidetone:

1. A change in TPA6130 volume should lead to a change in
   the sidetone's gain (if it's enabled). The change of gain
   is directly related to the change in the TPA's volume.

That said, if the sidetone's gain is of the domain [-2,2], how
could it translate into the TPA's nonlinear dB domain?. If
that may be resolved somehow feasibly, this sounds like a very
useful relation? Ideas?

This is all assumed that the FIR itself doesn't cause any gains
to the signal level at the desired frequency domain(s).

- Eero
