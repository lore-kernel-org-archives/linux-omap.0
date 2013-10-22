From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v5 02/12] ASoC: davinci-evm: Add device
	tree binding
Date: Tue, 22 Oct 2013 15:26:11 +0300
Message-ID: <52666EE3.8070607@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
 <66c21e66320e30453e6deded0f37ef582b4fba7c.1382110089.git.jsarha@ti.com>
 <20131022110147.GA9388@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20131022110147.GA9388@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, joelf@ti.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/22/2013 02:01 PM, Mark Brown wrote:
> On Fri, Oct 18, 2013 at 06:37:41PM +0300, Jyri Sarha wrote:
>
>> +  TLV320AIC3X pins:
...
>
> These should be documented in the CODEC binding and not in the card
> driver, that way this doesn't need to be replicated in every machine and
> any future software compatible devices can just work with the existing
> binding.
>

Ok, I'll remove the codec pins.

>> +	ret = snd_soc_register_card(&evm_soc_card);
>
> This should be using devm_snd_soc_register_card().
>

Ok, I'll move on top of your for-next branch and change it.

>> +	/*
>> +	 * If dtb is there, the devices will be created dynamically.
>> +	 * Only register platfrom driver structure.
>> +	 */
>> +	if (of_have_populated_dt())
>> +		return platform_driver_register(&davinci_evm_driver);
>> +
>
> Why not register the driver unconditionally?
>

I am just trying touch the legacy davinci audio support as little as 
possible. Would registering the driver in non DT mode do some good?

Best regards,
Jyri
