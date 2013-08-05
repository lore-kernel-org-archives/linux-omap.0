From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: AM4372: add few nodes
Date: Mon, 5 Aug 2013 11:36:07 +0530
Message-ID: <51FF40CF.4000008@ti.com>
References: <ffa2f76fcac54bfe76c234ffce0394fd2c25fe52.1375450395.git.afzal@ti.com>
 <6f0f838176ab93aac8dab4c3ab9d9f95a3027ff7.1375450395.git.afzal@ti.com>
 <51FCEE60.7080809@ti.com> <51FF335D.4050803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FF335D.4050803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, benoit.cousson@gmail.com, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <benoit.cousson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 05 August 2013 10:38 AM, Afzal Mohammed wrote:
> Hi Muguthan,
>
> On Saturday 03 August 2013 05:19 PM, Mugunthan V N wrote:
>> On 8/2/2013 7:16 PM, Afzal Mohammed wrote:
>
>>> +        mac: ethernet@4a100000 {
>>> +            compatible = "ti,am4372-cpsw","ti,cpsw";
>
>> compatibility "ti,am4372-cpsw" is not needed as driver has only
>> "ti,cpsw"
>> compatibility
>
> No, please read device tree documentation [1].
>
> DT is a pure hardware description, it does not depend on driver,
> dependency is only vice versa.

Thanks for the clarification

>
>>> +            reg = <0x4a100000 0x800
>>> +                   0x4a101200 0x100>;
>>> +            interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH
>>> +                      GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH
>>> +                      GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH
>>> +                      GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>>> +            ti,hwmods = "cpgmac0";
>>> +            status = "disabled";
>>> +        };
>
>> There are many other parameters which are missed here.
>
> Reason has been mentioned in the commit message, quoting relevant here
> again,
>
> >> For i2c, spi, cpsw & pwm - only the properties that were sure to be
> >> correct has been added (main intention is to make hwmod happy and
> >> avoid any later modification to here added properties).
>
> I really wanted to avoid a later patch that has a line starting with
> minus on DTS.
>
> Since you are working on cpsw support, can you help here with a patch
> for other properties.

Sure I can help you to add more DT entries which will not change
according to hardware

Regards
Mugunthan V N
