From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Wed, 22 Jan 2014 11:20:32 +0200
Message-ID: <52DF8D60.9020505@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk> <52D67099.1040904@ti.com>
 <20140115165100.3bfab96f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140115165100.3bfab96f@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/15/2014 05:51 PM, Jean-Francois Moine wrote:
> On Wed, 15 Jan 2014 13:27:21 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
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
> In the tda998x driver, the CTS_N is automatic (AIP_CNTRL_0_ACR_MAN is
> not set).
>
> Then, in my Cubox (Marvell A510 + tda19988), the 16, 24 and 32 bits
> formats are working well with I2S input at any rate.
>

Could you refer the kernel version (main line?) and the involved ASoC 
drivers so could take I a look if there is something I could do differently?

Best regards,
Jyri
