From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv6 2/2] ASoC: TWL6040: Add twl6040 codec
 driver
Date: Thu, 18 Mar 2010 08:43:48 +0000
Message-ID: <1268901828.3773.3.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCE662AC372@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE662AC372@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-03-17 at 17:42 -0500, Olaya, Margarita wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Initial version of TWL6040 codec driver.
> 
> The TWL6040 codec uses a proprietary PDM-based digital audio interface.
> Audio paths supported are:
> 
> - Input: Main Mic, Sub Mic, Headset Mic, Auxiliary-FM Left/Right
> - Output: Headset Left/Right, Handsfree Left/Right
> 
> TWL6040 codec supports power-up/down manual and automatic sequence.
> Manual sequence is done through a specific register writes sequence.
> Automatic sequence is done when the codec is powered-up through the
> external AUDPWRON line. The completion of the sequence is signaled
> through the audio interrupt.
> 
> TWL6040 codec sysclk can be provided by: low-power or high
> performance PLL:
> 
> - The low-power PLL takes a low-frequency input at 32,768 Hz and
> generates an approximate of 17.64 or 19.2 MHz (for 44.1 KHz and 48 KHz
> respectively)
> 
> - The high-performance PLL generates an exact 19.2 MHz clock signal
> from high-frequency input at 12/19.2/26/38.4 MHz.
> 
> Low-power playback mode is a special scenario where only headset path
> (headset DAC and driver) is active.
> 
> For the particular case of headset path, PLL being used defines the
> headset power mode: low-power, high-performance.
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
