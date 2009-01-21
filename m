From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Complete Beagleboard support
Date: Wed, 21 Jan 2009 11:35:51 +0000
Message-ID: <20090121113535.GB22213@sirena.org.uk>
References: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com>
	<200901210953.36630.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <200901210953.36630.peter.ujfalusi@nokia.com>
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
Cc: ext Steve Sakoman <sakoman@gmail.com>, alsa-devel@alsa-project.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 21, 2009 at 09:53:36AM +0200, Peter Ujfalusi wrote:

> for ure now you can build it, but does it actually works?
> I mean there has been quite a bit of change in the twl4030
> codec driver... The DAPM routing implementation might require
> some change in the board file also (SND_SOC_DAPM_HP,
> SND_SOC_DAPM_LINE, etc).

The DAPM default is that all the endpoints are on so it should work fine
but possibly won't be optimal so further tuning patches may be required.

I'll apply the patch since it's going to be needed whatever the case.
