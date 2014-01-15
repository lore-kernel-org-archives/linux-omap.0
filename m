From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Wed, 15 Jan 2014 18:28:14 +0200
Message-ID: <52D6B71E.5000702@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
 <52D691AD.3010206@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <52D691AD.3010206@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/15/2014 03:48 PM, Anssi Hannula wrote:
> 15.01.2014 13:27, Jyri Sarha kirjoitti:
>> On 12/31/2013 03:25 PM, Mark Brown wrote:
>>> On Fri, Dec 20, 2013 at 12:39:38PM +0200, Jyri Sarha wrote:
>>>> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
>>>> The 8 least significant bits are ignored.
>>>
>>> Where does this constraint come from?
>>>
>>
>>   From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N
>> register statically to a value that works only with 4 byte samples.
>> According to my tests it is possible to support 3 and 2 byte samples too
>> by changing the CTS_N register value, but I am not sure if the
>> configuration can be changed on the fly. My data sheet of the nxp chip
>> is very vague about the register definitions, but I suppose the register
>> configures some clock divider on the chip. HDMI supports only upto 24bit
>> audio and the data sheet states that any extraneous least significant
>> bits are ignored.
>
> That sounds strange, CTS/N values only depend on audio sample rate and
> TMDS/video clock, not on the audio format or the size of samples (HDMI
> spec sec 7.2 - Audio Sample Clock Capture and Regeneration).
>
> Sure there isn't anything more going on (like the used HDMI sink being
> more tolerant to wrong CTS/N with 4-byte samples, or more likely
> something else I can't immediately think of)?
>

On theoretical level I am not really sure about anything, because have 
not been able to get my hands on proper NXP TDA19988 documentation.

However, while playing around with my Beaglebone-Black I have have found 
out in practice that by changing CTS_N register's (page 0x11 reg 0x0c) 
K_SEL bits (bit 2 to 0)[1] I can get 2, 3 and 4 byte samples to work 
consistently by setting:

K_SEL = 1 for SNDRV_PCM_FORMAT_S16_LE
K_SEL = 2 for SNDRV_PCM_FORMAT_S24_3LE
K_SEL = 3 for SNDRV_PCM_FORMAT_S32_LE

Because I do not really know what is going on, I did not want to suggest 
any changes to the driver and just use the format that works with the 
current driver version.

The HDMI sinks I have been using are a Toshiba 22B2LF1G and Thomson 
42E90NF32 televisions. About those I just know that they both behave the 
same way.

Best regards,
Jyri

[1] The closest data sheet that has any description about the chip 
registers I have found is this: 
http://media.digikey.com/pdf/Data%20Sheets/NXP%20PDFs/TDA9983B.pdf
