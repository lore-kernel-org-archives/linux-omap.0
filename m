From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] alsa: add beagleboard SoC configuration.
Date: Wed, 22 Oct 2008 21:44:48 +0100
Message-ID: <20081022204445.GC7537@sirena.org.uk>
References: <1224692929-15108-1-git-send-email-felipe.contreras@gmail.com>
	<20081022165300.GX7341@atomide.com>
	<200810221236.38336.david-b@pacbell.net>
	<5e088bd90810221330m7f40293du96897afb41f98169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <5e088bd90810221330m7f40293du96897afb41f98169@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 22, 2008 at 01:30:26PM -0700, Steve Sakoman wrote:

> At the time, the feedback from the alsa-devel list was that they were
> OK with these patches living in linux-omap until the twl4030 driver
> was mainline ready.

Indeed.  The only blocker was that TWL4030 codec support breaks the
build of SND_SOC_ALL_CODECS without the core support for the chip - I
gave it my ack otherwise already.  Since the core support has now been
merged by Linus this shouldn't be an issue once ALSA has synchronised
with mainline.

> I am happy to resubmit the patches, if that is what folks want.  I'm
> copying alsa-devel so they can weigh in on the decision.

Once mainline is merged up to the ASoC topic branch it should be fine to
go via ALSA.  I've got some other stuff waiting for that to happen
myself so if you want to send a patch queue I can queue that in there.
I was going to wait for rc1 before asking Takashi to merge up to the
ASoC branches.
