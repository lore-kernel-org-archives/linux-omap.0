From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 29 Jan 2010 17:23:02 +0200
Message-ID: <20100129172302.15e5b096.jhnikula@gmail.com>
References: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com>
	<20100128185702.6c1c0f04.jhnikula@gmail.com>
	<alpine.DEB.2.00.1001291638470.11819@tumpelo.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.DEB.2.00.1001291638470.11819@tumpelo.nmp.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilkka Koskinen <ikoskine@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jan 2010 16:51:16 +0200 (EET)
Ilkka Koskinen <ikoskine@nokia.com> wrote:

> > Set applies well on top of vanilla but the patch 1 doesn't apply on
> > linux-omap due commit bcbb73c6fe8544bb50cddb8b5df0e2fcbb08b4b0.
> 
> I guess that's the case, since I just tested the patches on top 
> linux-omap-2.6 master and sound tree...
> 
Yeah, McBSP is always bit problematic as it spreads between two
subsystems. Some recent patches has been pushed via ALSA tree but now
that would lead to conflict.

> > I was thinking that it makes sense to base the patch 1 on top of McBSP
> > register cache patches from Janusz Krzysztofik after Tony applies
> > them (+ having cache for ST regs). That avoid conflicts in mainline
> > and makes the sidetone also ready for McBSP context save/restore
> > functionality.
> 
> I'm ok with that. So would you suggest me to prepare the cache patch for 
> ST registers? If so, would it be possible to make it as follow-up patch?
> 
That's ok. As there is no currently implementation for context
save/restore in McBSP, the follow-up patch is even better than doing
everything in the patch 2.


-- 
Jarkko
