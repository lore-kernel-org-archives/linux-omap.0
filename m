From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Mon, 12 Oct 2009 10:32:35 +0100
Message-ID: <20091012093235.GE3308@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
	<20091008131702.GC29176@rakim.wolfsonmicro.main>
	<1255064967.30157.178.camel@eenurkka-desktop>
	<20091009104458.GB5082@sirena.org.uk>
	<1255328261.30157.227.camel@eenurkka-desktop>
	<20091012091234.GB3308@rakim.wolfsonmicro.main>
	<1255339705.30157.241.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255339705.30157.241.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Tony Lindgren <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 12, 2009 at 12:28:25PM +0300, Eero Nurkkala wrote:

> As mentioned, in some (or most) cases the absolute sinetone level (dB)
> is expected constant. Even a volume change should not effect the
> sidetone level. Thus, if there's a change in volume, the sidetone gains
> should be readjusted. If that can happen automatically, that would
> be just nice =)

That's what you said, but could you please go into a bit more detail
about why you beleive that this should be the case?  Is there some
hardware limitation here?
