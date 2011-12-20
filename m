From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/10] include: platform_data: Platform
 data header for OMAP4 ASoC audio
Date: Tue, 20 Dec 2011 00:24:43 +0000
Message-ID: <20111220002442.GA2860@opensource.wolfsonmicro.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
	<1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
	<20111214095745.GD3072@opensource.wolfsonmicro.com>
	<3652535.KtFJC1aH5Z@barack>
	<20111217093645.GH2833@opensource.wolfsonmicro.com>
	<4EEF4485.8050809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4EEF4485.8050809@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 19, 2011 at 04:04:53PM +0200, Peter Ujfalusi wrote:
> On 12/17/2011 11:36 AM, Mark Brown wrote:

> > Just do it right to start off with, the device tree bindings should
> > normally map closely onto the platform data where platform data exists
> > already and you're going to have to have the code structured by feature
> > anyway.

> I do not want to 'bloat' the board files under mach-omap2 for sdp4430,
> Panda with string arrays to pass the DAPM routing from there to the ASoC
> machine driver to construct the board specific routing.

I don't know that you need to push the full DAPM table down there,
there's certainly way more compact ways of representing selections like
this.

> All of this sort of thing will go away with DT in the future (including
> the platform_data).

I'm not really happy with this as a reason for pushing low quality stuff
in - either the code isn't going to be around long so we may as well
jump to what we meant to do or it's going to be there for long enough
that people will have to work with it (and perhaps pick it up as a
reference).

> struct omap-abe-twl6040-connection {
> 	const char *sink;
> 	const char *source;
> };

omap-abe-mcbsp--mcpdm-twl4030?  :P

To be honest if you're going to do this I don't understand why you'd
bother defining this type which you'll just have to translate into a
dapm_route.
