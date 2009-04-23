From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 19:30:38 +0100
Message-ID: <20090423183038.GA6642@sirena.org.uk>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	<200904231220.14465.peter.ujfalusi@nokia.com>
	<b6ab3a160904230950g61ae6e78mac2f02ada111c40c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <b6ab3a160904230950g61ae6e78mac2f02ada111c40c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alejandro Blanca G." <alex.blanca@gmail.com>
Cc: ext twebb <taliaferro62@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, etorres@dextratech.com
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 23, 2009 at 11:50:25AM -0500, Alejandro Blanca G. wrote:

> Probably the issue we are seeing is related: we are having problems
> when doing playback and observe that the information corresponding to
> 2 channels is being sent only through the left channel. We might have
> some other problems too, since we are new to this kind of development,
> but maybe our observations or yours could be useful to stabilize the
> Beagle platform code.

Please check out the current ASoC branch - as previously mentioned there
has been quite a bit of work recently on the McBSP audio formatting:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
