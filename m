From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 net-next 05/12] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Fri, 25 Oct 2019 10:47:20 -0700
Message-ID: <caf68306-46ce-f97d-b45a-0fc1cd5323f7@gmail.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-6-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191024100914.16840-6-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/24/19 3:09 AM, Grygorii Strashko wrote:
> Add bindings for the new TI CPSW switch driver. Comparing to the legacy
> bindings (net/cpsw.txt):
> - ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
> marked as "disabled" if not physically wired.
> - all deprecated properties dropped;
> - all legacy propertiies dropped which represent constant HW cpapbilities
> (cpdma_channels, ale_entries, bd_ram_size, mac_control, slaves,
> active_slave)
> - TI CPTS DT properties are reused as is, but grouped in "cpts" sub-node
> - TI Davinci MDIO DT bindings are reused as is, because Davinci MDIO is
> reused.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---

[snip]
> +- mdio : CPSW MDIO bus block description
> +	- bus_freq : MDIO Bus frequency

clock-frequency is a more typical property to describe the bus clock's
frequency, that is what i2c and spi do.

> +	See bindings/net/mdio.txt and davinci-mdio.txt
> +
> +- cpts : The Common Platform Time Sync (CPTS) module description
> +	- clocks : should contain the CPTS reference clock
> +	- clock-names : should be "cpts"
> +	See bindings/clock/clock-bindings.txt
> +
> +	Optional properties - all ports:
> +	- cpts_clock_mult : Numerator to convert input clock ticks into ns
> +	- cpts_clock_shift : Denominator to convert input clock ticks into ns
> +			  Mult and shift will be calculated basing on CPTS
> +			  rftclk frequency if both cpts_clock_shift and
> +			  cpts_clock_mult properties are not provided.

Why would those two be needed that would be modeled in the Linux Common
Clock Framework?
-- 
Florian
