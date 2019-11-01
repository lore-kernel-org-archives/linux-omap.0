From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v5 net-next 05/12] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Fri, 1 Nov 2019 10:36:25 -0700
Message-ID: <5c286f76-d108-5d78-dd8f-19e1baf64396@gmail.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-6-grygorii.strashko@ti.com>
 <caf68306-46ce-f97d-b45a-0fc1cd5323f7@gmail.com>
 <6e64b70e-604a-b8c6-12ce-7977ffa4ed5a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6e64b70e-604a-b8c6-12ce-7977ffa4ed5a@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/1/19 10:25 AM, Grygorii Strashko wrote:
> Hi Florian,
> 
> On 25/10/2019 20:47, Florian Fainelli wrote:
>> On 10/24/19 3:09 AM, Grygorii Strashko wrote:
>>> Add bindings for the new TI CPSW switch driver. Comparing to the legacy
>>> bindings (net/cpsw.txt):
>>> - ports definition follows DSA bindings (net/dsa/dsa.txt) and ports
>>> can be
>>> marked as "disabled" if not physically wired.
>>> - all deprecated properties dropped;
>>> - all legacy propertiies dropped which represent constant HW
>>> cpapbilities
>>> (cpdma_channels, ale_entries, bd_ram_size, mac_control, slaves,
>>> active_slave)
>>> - TI CPTS DT properties are reused as is, but grouped in "cpts" sub-node
>>> - TI Davinci MDIO DT bindings are reused as is, because Davinci MDIO is
>>> reused.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>
>> [snip]
>>> +- mdio : CPSW MDIO bus block description
>>> +    - bus_freq : MDIO Bus frequency
>>
>> clock-frequency is a more typical property to describe the bus clock's
>> frequency, that is what i2c and spi do.
> 
> The MDIO is re-used here unchanged (including bindings).
> i think, I could try to add standard optional property "bus-frequency"
> to MDIO bindings
> as separate series, and deprecate "bus_freq".

What is wrong with 'clock-frequency'?

Documentation/devicetree/bindings/i2c/i2c.txt:

- clock-frequency
        frequency of bus clock in Hz.

Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt:

- clock-frequency: the MDIO bus clock that must be output by the MDIO bus
  hardware, if absent, the default hardware values are used

Maybe this is a bit of a misnomer as it is usually considered a
replacement for the lack of a proper "clocks" property with a clock
provider, but we can flip the coin around any way we want, it looks
almost the same.
-- 
Florian
