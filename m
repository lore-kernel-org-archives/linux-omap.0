From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Wed, 08 Aug 2012 15:43:29 +0300
Message-ID: <50225EF1.4010203@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5022529D.3090406@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On 08/08/2012 02:50 PM, Benoit Cousson wrote:
>> +Required properties:
>> +- compatible : must be "ti,twl4030-audio"
>> +- ti,audio_mclk: Master clock frequency used on the board. Supported
>> +	         frequencies: 19200000, 26000000 and 38400000
> =

> Since you care about the frequency only you can use the generic
> attribute: clock-frequency (in your example, I2C is using it).

I see, I'll use replace the property with clock-frequency.

> That being said, since we do have the clock binding now, maybe we should
> create a clock provider at board level for the sys_clk and thus you will
> just have to create a phandle to it in your audio description.
> =

> In theory OMAP and other components will thus have to use that sys_clock
> reference as well.

And in the driver I would need to do for example:
clkp =3D clk_get(NULL, "audio_mclk");
clk_rate =3D clk_get_rate(clkp);
clk_put(clkp);

to get the frequency in this way?
Note that the twl4030-audio stack itself does not handle clocks at the mome=
nt
since the clock needed for the audio module is always running (HFCLKIN ->
HFCLKOUT -> AUDIO_MCLK (USB_MCLK)). All of this is within twl4030. Do we
really want to model this?

-- =

P=E9ter
