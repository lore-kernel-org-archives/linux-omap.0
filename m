From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 07/10] ASoC: OMAP: ams-delta: Drive
	modem/codec pins over GPIO API
Date: Wed, 21 Dec 2011 23:14:39 +0100
Message-ID: <201112212314.39844.jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
	<1324492424.8478.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1324492424.8478.5.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 21 of December 2011 at 19:33:44, Liam Girdwood wrote:
> On Sun, 2011-12-11 at 21:12 +0100, Janusz Krzysztofik wrote:
> > Don't use Amstrad Delta custom I/O functions any longer, replace them
> > with GPIO. Old pin definitions, no longer used by the modem bits either,
> > can be dropped.
> > 
> > Depends on patch 2/10 "ARM: OMAP1: Convert Amstrad E3 latches to
> > basic_mmio_gpio".
> > 
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> Applied.

Hi,
I'm sorry, but I've probably missed to infrom you explicitly, i.e. other 
than in a cover letter to v2 of this series, that this particular patch 
has been dropped from the series. I've already started working on an 
alternative solution, which I intend to submit as a separate set. It 
will be free of potentail problems with two devices, a modem and the 
sound card, accessing the same GPIO pins concurrently. For the 
MODEM_NRESET pin I've already set up a virtual regulator on top of it, 
and for the MODEM_CODEC pin I'll probably choose a virtual clock (pinmux 
would match the hardware more closely here, but it looks too complicated 
to me). Moreover, I've already started to move all those GPIO pin 
related functions, i.e. bias control, digital mute and line discipline 
interaction, from the board file to the codec driver, where all those 
seem to belong.

Having this patch applied will conflict with the regultor and the clock 
solutions, taking control over those two GPIO pins. Please revert this 
patch, or reset it if still possible.

Thanks,
Janusz
