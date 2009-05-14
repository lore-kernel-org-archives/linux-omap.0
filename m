From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Added OMAP3 EVM support in ASoC.
Date: Thu, 14 May 2009 17:07:21 +0100
Message-ID: <1242317241.31458.1764.camel@finisterre>
References: <1242289759-6577-1-git-send-email-anuj.aggarwal@ti.com>
	<20090514153927.GI5593@atomide.com>
	(sfid-20090514_163939_160429_A1614EC5)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090514153927.GI5593@atomide.com>
	(sfid-20090514_163939_160429_A1614EC5)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2009-05-14 at 08:39 -0700, Tony Lindgren wrote:
> Are there still some problems from ASoC point of view to
> convert ASoC to do the platform_device_alloc() from
> board init files?

This is still something that needs to be done for cards - the driver is
always called soc-audio. It needs an update to allow the platform device
for the codec to call snd_soc_register_card() directly to support this
but there's not much demand at the minute, I'm more concerned with
getting the CODEC drivers converted to use the standard device model to
register first.
