From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Mon, 12 Oct 2009 13:28:48 +0300
Message-ID: <1255343328.30157.261.camel@eenurkka-desktop>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
	<20091008131702.GC29176@rakim.wolfsonmicro.main>
	<1255064967.30157.178.camel@eenurkka-desktop>
	<20091009104458.GB5082@sirena.org.uk>
	<1255328261.30157.227.camel@eenurkka-desktop>
	<20091012091234.GB3308@rakim.wolfsonmicro.main>
	<1255339705.30157.241.camel@eenurkka-desktop>
	<20091012093235.GE3308@rakim.wolfsonmicro.main>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091012093235.GE3308@rakim.wolfsonmicro.main>
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

On Mon, 2009-10-12 at 11:32 +0200, ext Mark Brown wrote:
> On Mon, Oct 12, 2009 at 12:28:25PM +0300, Eero Nurkkala wrote:
> 
> > As mentioned, in some (or most) cases the absolute sinetone level (dB)
> > is expected constant. Even a volume change should not effect the
> > sidetone level. Thus, if there's a change in volume, the sidetone gains
> > should be readjusted. If that can happen automatically, that would
> > be just nice =)
> 
> That's what you said, but could you please go into a bit more detail
> about why you beleive that this should be the case?  Is there some
> hardware limitation here?

No HW limits here... it's all about the hmm, "friendliness" of
sidetones.

"The more intense the side-tone, the less intensely the speaker talks."
(June 12, 1948) [REF]

So changing the headset volume should not make the speaker talk
more/less intensely? Of course it all depends... this is just one
aspect to this.


[REF]

LOUDNESS OF SPEAKING: THE EFFECT OF THE INTENSITY
OF SIDE-TONE UPON THE INTENSITY OF THE SPEAKER
Kenyon College 
Acoustic Laboratory
Gambier, Ohio 
School of Aviation Medicine and Research
N.A.S., Pensacola, Florida
