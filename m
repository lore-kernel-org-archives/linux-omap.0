From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/10] include: platform_data: Platform
 data header for OMAP4 ASoC audio
Date: Sat, 17 Dec 2011 09:36:45 +0000
Message-ID: <20111217093645.GH2833@opensource.wolfsonmicro.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
	<1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
	<20111214095745.GD3072@opensource.wolfsonmicro.com>
	<3652535.KtFJC1aH5Z@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <3652535.KtFJC1aH5Z@barack>
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
Cc: Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2011 at 03:02:44PM +0200, P=E9ter Ujfalusi wrote:
> On Wednesday 14 December 2011 17:57:47 Mark Brown wrote:

> > It seems like it might better in the long run to make this feature based
> > rather than enumerating the individual boards - that means that if
> > boards mix and match the features or add features on the side of
> > additional designs (eg, external amplifiers that need power control)
> > it's easier to scale the options.

> Yes this is planed for the Dtree support, but the aim here is to get work=
ing =

> audio on PandaBoard as well with upstream kernel.

Just do it right to start off with, the device tree bindings should
normally map closely onto the platform data where platform data exists
already and you're going to have to have the code structured by feature
anyway.
