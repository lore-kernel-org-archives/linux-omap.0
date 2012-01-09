From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2 4/4] ASoC: OMAP: ams-delta: drop
 .set_bias_level callback
Date: Mon, 09 Jan 2012 11:53:35 +0000
Message-ID: <1326110015.24178.5.camel@odin>
References: <1325214296-2888-5-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1325214296-2888-5-git-send-email-jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2011-12-30 at 04:04 +0100, Janusz Krzysztofik wrote:
> This functionality has just been implemented in the cx20442 codec
> driver, no need to keep it here duplicated.
> 
> Once done, remove the no longer used AMS_DELTA_LATCH2_MODEM_NRESET
> symbol from the board header file and a call to the regulator_toggle()
> helper function from the old API wrapper found in the board file.  While
> being at it, simplify the way the modem .pm callback handles the
> regulator, and drop that no longer used helper function and its related
> consumer setup elements completely.
> 
> Depends on patch 3/4 "ARM: OMAP1: ams-delta: update the modem to use
> regulator API"
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> Changes against initial version:
> * don't move consumer setup elements, now named to indicated their
>   modem related purpose, down the file,
> * don't track the regulator enavble/disable state, compare new target
>   power state with the old one instead; thanks to Mark Brown for
>   suggesting this simplification,
> * actually drop all references to AMS_DELTA_LATCH2_MODEM_NRESET.
> 
>  arch/arm/mach-omap1/board-ams-delta.c             |   42 +++-----------------
>  arch/arm/plat-omap/include/plat/board-ams-delta.h |    1 -
>  sound/soc/omap/ams-delta.c                        |   32 ----------------
>  3 files changed, 7 insertions(+), 68 deletions(-)

I tried to apply against ASoC but it failed with the omap files. It may
be better for this patch to go via Tony. 

2/4 applies and builds ok, but if there is a runtime dependency on the
rest it should go via Tony too.

Thanks

Liam
