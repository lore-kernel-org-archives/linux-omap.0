From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 25 Oct 2012 08:16:21 -0500
Message-ID: <50893BA5.8080600@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com> <508895D8.5000701@ti.com>
 <5088F19B.7050606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5088F19B.7050606@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: paul@pwsan.com, x0148406@ti.com, nsekhar@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On 10/25/2012 03:00 AM, Daniel Mack wrote:
> Hi Jon,
> 
> many thanks for your time to look at this.
> 
> On 25.10.2012 03:28, Jon Hunter wrote:
>> On 10/22/2012 02:55 PM, Daniel Mack wrote:
>>> diff --git a/Documentation/devicetree/bindings/bus/gpmc.txt b/Documentation/devicetree/bindings/bus/gpmc.txt
>>> new file mode 100644
>>> index 0000000..ef1c6e1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/bus/gpmc.txt
>>> @@ -0,0 +1,59 @@
>>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>>> +
>>> +The actual devices are instantiated from the child nodes of a GPMC node.
>>> +
>>> +Required properties:
>>> +
>>> + - compatible: Should be set to "ti,gpmc"
>>
>> Is this the only required property? I think that "reg" and "ti,hwmods"
>> are probably also required.
> 
> Well yes, but at least "reg" is commonly omitted as it's part of a more
> "generic" set of properties. But ok, I can add these.
> 
>> Also given that we are describing the hardware, I am wondering if the
>> number of chip-selects and wait signals should be defined here too. I
>> recall that different devices had different number of wait pins available.
> 
> Hmm, that number is currently hard-coded in GPMC_CS_NUM. It would take
> some effort to make that dynamic but I agree that this would be a good
> thing to have. Afzal?

I believe that today all OMAP/AM devices have 8 chip-selects so probably
not a big deal. However, given we are moving to DT it would be nice to
move away from having such #defines for hardware related items.

Cheers
Jon
