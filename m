From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 5/7] ASoC: TWL6030: Add support for
	low-power mode
Date: Mon, 28 Sep 2009 14:28:00 +0100
Message-ID: <20090928132800.GD31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90A391E3@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 25, 2009 at 09:03:30PM -0500, Lopez Cruz, Misael wrote:

> TWL6030 codec supports two power modes: low-power and high
> performance.

> In low-power mode, headset downlink must be the only path enabled
> and components in that path (headset DAC and driver) should be in
> that mode too. In this mode, codec can stream audio at 44.1 and
> 48 kHz if sys clock from CLK32K is configured to 17.64 and 19.2
> MHz using low-power PLL, respectively.

> In high-performance mode, codec can only work at 19.2 MHz from
> high-performance PLL. All paths supported in the codec can be used
> but audio can be streamed only at 48 kHz.

The driver should also set constraints at runtime so that applications
know they shouldn't use an unsupported sample rate.  See wm8988 for an
example of doing this - it has some similar SYSCLK based restrictions.

It also strikes me that this is something that should be exposed to user
space since if there's a 19.2MHz MCLK it's something that the system
could reasonably want to activate and deactivate on the fly.  For bonus
points the driver could prevent switching to low power mode if any paths
are active which conflict with it.  Doing it automatically would be
ideal but since it sounds like a performance degradation to use low
power mode that's not really suitable.
