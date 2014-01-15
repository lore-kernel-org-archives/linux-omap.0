From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Wed, 15 Jan 2014 15:48:29 +0200
Message-ID: <52D691AD.3010206@iki.fi>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <52D67099.1040904@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

15.01.2014 13:27, Jyri Sarha kirjoitti:
> On 12/31/2013 03:25 PM, Mark Brown wrote:
>> On Fri, Dec 20, 2013 at 12:39:38PM +0200, Jyri Sarha wrote:
>>> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
>>> The 8 least significant bits are ignored.
>>
>> Where does this constraint come from?
>>
> 
>  From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N 
> register statically to a value that works only with 4 byte samples. 
> According to my tests it is possible to support 3 and 2 byte samples too 
> by changing the CTS_N register value, but I am not sure if the 
> configuration can be changed on the fly. My data sheet of the nxp chip 
> is very vague about the register definitions, but I suppose the register 
> configures some clock divider on the chip. HDMI supports only upto 24bit 
> audio and the data sheet states that any extraneous least significant 
> bits are ignored.

That sounds strange, CTS/N values only depend on audio sample rate and
TMDS/video clock, not on the audio format or the size of samples (HDMI
spec sec 7.2 - Audio Sample Clock Capture and Regeneration).

Sure there isn't anything more going on (like the used HDMI sink being
more tolerant to wrong CTS/N with 4-byte samples, or more likely
something else I can't immediately think of)?


BTW, radeon driver has some code that calculates static CTS/N values
since the hw autogeneration is not reliable there:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/radeon/r600_hdmi.c
Not that it directly helps now, but just for the record...

-- 
Anssi Hannula
