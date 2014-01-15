From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 REPOST 2/8] ASoC: davinci-evm: Add
 named clock reference to DT bindings
Date: Wed, 15 Jan 2014 13:12:03 +0200
Message-ID: <52D66D03.1040608@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <c1ae738c9b6cd9f2e595eed1f4981378ded46925.1387535302.git.jsarha@ti.com>
 <20131231131617.GZ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20131231131617.GZ31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/31/2013 03:16 PM, Mark Brown wrote:
> On Fri, Dec 20, 2013 at 12:38:27PM +0200, Jyri Sarha wrote:
>
>> +static int evm_startup(struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_card *soc_card = rtd->codec->card;
>> +	struct clk *mclk = ((struct snd_soc_card_drvdata_davinci *)
>> +			    snd_soc_card_get_drvdata(soc_card))->mclk;
>
> Why do you need to cast away void?  Ths indicates something is going
> wrong here though I can't see what.

I'll fix that.

>> +	mclk = of_clk_get_by_name(np, "ti,codec-clock");
>> +	if (PTR_ERR(mclk) == -EPROBE_DEFER) {
>> +		return -EPROBE_DEFER;
>> +	} else if (IS_ERR(mclk)) {
>> +		dev_dbg(&pdev->dev, "Codec clock not found.\n");
>> +		mclk = NULL;
>> +	}
>
> The driver will unconditionally enable and disable the clock which I'd
> not expect to work well if we got an error, I'd expect either NULL checks
> on use or a fixed clock to be registered from code in the case where
> we're using the old binding.
>

In the drivers/clk/clk.c the clk == NULL is always checked before using 
the pointer. However, adding NULL checks would save couple of 
lock-unlock cycles. I'll add them.

> I'd also expect to see devm_clk_get() used here, with the standard
> clock-names based lookup from DT.
>

I'll fix that.

Best regards,
Jyri
