From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Wed, 13 Jul 2011 08:25:07 +0900
Message-ID: <20110712232505.GA17710@opensource.wolfsonmicro.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
	<2323058.DqPoNzVktU@barack>
	<20110709010808.GC18860@opensource.wolfsonmicro.com>
	<4479173.gaSts1MLKP@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4479173.gaSts1MLKP@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Cousson,
	Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Lopez Cruz,
	Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 12, 2011 at 10:35:53PM +0300, P=E9ter Ujfalusi wrote:

> Just to avoid confusion (in my part): if I split this patch to one big + =

> several small incremental patches, which eventually lead to the current =

> situation is what you were asking for?

The rest of the patch looked fine from a code point of view so probably
just leave that as-is and improve the changelog - the delayed_work was
the only real issue I saw from a code point of view and the bit I was
suggesting to split out into a separate patch.

> With the patches I can document the reasoning behind the non standard =

> workarounds. Probably if we see them spread out, we might be able to find =

> better ways for them...

Yeah, and like I say if it were controlled by the machine driver it'd be
better.
