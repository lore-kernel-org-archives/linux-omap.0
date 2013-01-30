From: Sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH] arm: dts: omap4-sdp: Add I2c pinctrl data
Date: Wed, 30 Jan 2013 12:10:18 +0530
Message-ID: <5108C052.3070604@ti.com>
References: <1359371865-27907-1-git-send-email-sourav.poddar@ti.com> <1359527158.14894.37.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359527158.14894.37.camel@cumari.coelho.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Luciano,
On Wednesday 30 January 2013 11:55 AM, Luciano Coelho wrote:
> Hi Sourav,
>
> On Mon, 2013-01-28 at 16:47 +0530, Sourav Poddar wrote:
>> Booting 3.8-rc4 om omap 4430sdp results in the following error
>>
>> omap_i2c 48070000.i2c: did not get pins for i2c error: -19
>> [    1.024261] omap_i2c 48070000.i2c: bus 0 rev0.12 at 100 kHz
>> [    1.030181] omap_i2c 48072000.i2c: did not get pins for i2c error: -19
>> [    1.037384] omap_i2c 48072000.i2c: bus 1 rev0.12 at 400 kHz
>> [    1.043762] omap_i2c 48060000.i2c: did not get pins for i2c error: -19
>> [    1.050964] omap_i2c 48060000.i2c: bus 2 rev0.12 at 100 kHz
>> [    1.056823] omap_i2c 4807a000.i2c: did not get pins for i2c error: -19
>> [    1.064025] omap_i2c 4807a000.i2c: bus 3 rev0.12 at 400 kHz
>>
>> This happens because omap4 dts file is not adapted to use i2c through pinctrl
>> framework. Populating i2c pinctrl data to get rid of the error.
>>
>> Tested on omap4430 sdp with 3.8-rc4 kernel.
>>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
> Could you do the same thing for panda? I'm getting the same kind of
> errors with it:
Sure, I will do that.
> [    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model: TI OMAP4 PandaBoard
> [...]
> [    2.884826] omap_i2c 48072000.i2c: did not get pins for i2c error: -19
> [    2.890686] omap_i2c 48072000.i2c: bus 1 rev0.11 at 400 kHz
> [    2.892028] omap_i2c 48060000.i2c: did not get pins for i2c error: -19
> [    2.899047] omap_i2c 48060000.i2c: bus 2 rev0.11 at 100 kHz
> [    2.906677] omap_i2c 48350000.i2c: did not get pins for i2c error: -19
> [    2.912872] omap_i2c 48350000.i2c: bus 3 rev0.11 at 400 kHz
>
> --
> Cheers,
> Luca.
>
Thanks,
Sourav
