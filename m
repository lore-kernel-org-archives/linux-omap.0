From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/3] ARM: OMAP1: ams-delta: set up
 regulator over modem reset GPIO pin
Date: Mon, 5 Mar 2012 11:27:43 -0800
Message-ID: <20120305192742.GK12083@atomide.com>
References: <1330963512-20413-1-git-send-email-jkrzyszt@tis.icnet.pl>
	<1330963512-20413-2-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1330963512-20413-2-git-send-email-jkrzyszt@tis.icnet.pl>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120305 07:35]:
> The Amstrad Delta on-board latch2 bit named MODEM_NRESET, now available
> as a GPIO pin AMS_DELTA_GPIO_PIN_NMODEM_RESET, is used to power up/down
> (bring into/out of a reset state) two distinct on-board devices
> simultaneously: the modem, and the voice codec. As a consequence, that
> bit is, or can be, manipulated concurrently by two drivers, or their
> platform provided hooks.
> 
> Instead of updating those drivers to use the gpiolib API as a new method
> of controlling the MODEM_NRESET pin state, like it was done to other
> drivers accessing latch2 pins, and still being vulnerable to potential
> concurrency conflicts, or trying to solve that sharing issue with a
> custom piece of code, set up a fixed regulator device on top of that
> GPIO pin, with the intention of updating both drivers to manipulate that
> regulator, not the GPIO pin directly.
> 
> Before the ASoC driver is updated and the modem platform data expanded
> with a power management callback for switching its power, the
> ams_delta_latch_write() function, which still provides the old API for
> accessing latch2 functionality from not updated drivers, is modified to
> toggle the regulator instead of the MODEM_NRESET GPIO pin.  A helper
> function provided for balancing the regulator enable/disable operations,
> together with the consumer data needed for tracking the regulator state,
> will be removed once the drivers are updated.
> 
> Depends on patch series "ARM: OMAP1: ams-delta: replace custom I/O with
> GPIO".
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> v2 -> v3 changes:
> * fix section mismatch isue.
> 
> Changes against initial version:
> * rename consumer setup elements to match their final, modem only
>   related purpose,
> * initialize the regulator pointer and mutex before first use, then
>   omit testing that pointer against NULL value

Thanks, applying all three into ams-delta branch.

Regards,

Tony
