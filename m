From: Milo Kim <milo.kim@ti.com>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Mon, 28 Dec 2015 09:56:20 +0900
Message-ID: <568088B4.6090207@ti.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151223115632.GS16023@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 23/12/15 20:56, Mark Brown wrote:
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
>
>> +	gpio = lp->pdata->enable_gpio;
>> +	if (!gpio_is_valid(gpio))
>> +		return 0;
>> +
>> +	/* Always set enable GPIO high. */
>> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
>> +	if (ret) {
>> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
>> +		return ret;
>> +	}
>
> This isn't really adding support for the enable GPIO as the changelog
> suggests, it's requesting but not managing the GPIO.  Since there is
> core support for manging enable GPIOs this seems especially silly,
> please tell the core about the GPIO and then it will work at runtime
> too.
>

With reference to my previous mail, external GPIOs for LDO3 and BUCK2 in 
LP8725 can be specified through regulator_config.ena_gpio. BUCK2 only 
can be controlled by external pin when CONFIG pin is grounded.

Please see the description at page 5 of the datasheet.

	http://www.ti.com/lit/ds/symlink/lp8725.pdf

Best regards,
Milo
