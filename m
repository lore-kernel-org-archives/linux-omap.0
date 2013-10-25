From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] Documentation: DTS: bq27xxx are trivial i2c devices
Date: Fri, 25 Oct 2013 20:56:34 +0100
Message-ID: <20131025195634.EEBECC40531@trevor.secretlab.ca>
References: <1382446577-28270-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382446577-28270-1-git-send-email-sre@debian.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sebastian Reichel <sre@debian.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 22 Oct 2013 14:56:16 +0200, Sebastian Reichel <sre@debian.org> wrote:
> Add all chips supported by the bq27xxx driver to the list
> of trivial i2c devices.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index ad6a738..d3a29ce 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -58,6 +58,9 @@ stm,m41t00		Serial Access TIMEKEEPER
>  stm,m41t62		Serial real-time clock (RTC) with alarm
>  stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
>  taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> -ti,tsc2003		I2C Touch-Screen Controller
> +ti,bq27200		Battery Monitor
> +ti,bq27500		Battery Monitor
> +ti,bq27425		Battery Monitor
>  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>  ti,tmp275		Digital Temperature Sensor
> +ti,tsc2003		I2C Touch-Screen Controller
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
