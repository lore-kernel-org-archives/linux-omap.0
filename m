From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 3/5] ARM: CTI: Convert CTI helpers to AMBA bus driver
Date: Thu, 13 Dec 2012 13:35:19 -0600
Message-ID: <50CA2DF7.2030802@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-4-git-send-email-jon-hunter@ti.com>
 <20121213150826.GM26540@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121213150826.GM26540-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 12/13/2012 09:08 AM, Will Deacon wrote:
> On Wed, Dec 12, 2012 at 09:43:06PM +0000, Jon Hunter wrote:
>> Convert the Cross Trigger Interface (CTI) helpers in cti.h into a
>> AMBA bus driver so that we can use device-tree to look-up the hardware
>> specific information such as base address and interrupt number during
>> the device probe. This also add APIs to request, cti_get() and release,
>> cti_put(), a CTI module so that drivers can allocate a module at
>> runtime.
>>
>> Currently, the driver only supports looking-up the CTI hardware
>> information via device-tree, however, the driver could be extended to
>> support non-device-tree configurations if needed for a particular
>> architecture.
>>
>> The CTI driver only currently supports CTI modules that have a single
>> CPU interrupt, however, could be extended in the future to support more
>> interrupts if a device requires this.
> 
> Aha, so elaborating on my earlier comments, we basically want to do the same
> thing for ETB I reckon. This does raise the question about namespaces
> though...
> 
>> +/**
>> + * struct cti - Cross Trigger Interface (CTI) struct
>> + *
>> + * @node:      Connects CTI instance to list of CTI instances
>> + * @dev:       Pointer to device structure
>> + * @base:      Mapped virtual address of the CTI module
>> + * @name:      Name associated with CTI instance
>> + * @irq:       Interrupt associated with CTI instance
>> + * @trig_out:  Trigger output associated with interrupt (@irq)
>> + * @reserved:  Used to indicate if CTI instance has been allocated
>> + * @enabled:   Used to indicate if CTI instance has been enabled
>> + */
>> +struct cti {
>> +       struct list_head node;
>> +       struct device *dev;
>> +       void __iomem *base;
>> +       const char *name;
>> +       int irq;
>> +       int trig_out;
>> +       bool reserved;
>> +       bool enabled;
>> +};
>> +
>> +#ifdef CONFIG_ARM_AMBA_CTI
>> +
>> +int cti_map_trigger(struct cti *cti, int trig_in, int trig_out, int chan);
>> +int cti_enable(struct cti *cti);
>> +int cti_disable(struct cti *cti);
>> +int cti_irq_ack(struct cti *cti);
>> +struct cti *cti_get(const char *name);
>> +void cti_put(struct cti *cti);
> 
> I wonder whether we should stick these all into a struct and have a general
> way to see which coresight devices we have and then retrieve their ops
> structures (so things like perf can walk a virtual coresight bus containing
> initialised devices).

Yes we could use a struct here. Hopefully, the enable/disable/get/put
could be used across coresight devices. I would need to think more about
the custom functions such as map_trigger which are specific to CTI.

> It might also help if we decide to describe the
> plumbing in the device tree, like Rob suggested.

Yes, I did propose adding more information to the binding for CTI to
describe trigger-ins/outs for a device. However, we could go a step
further and try and come up with a way to link the devices. Though I am
not sure if there are any other possible use-cases for CTI where that
may not be suitable and we just want to be able to configure it to map
trigger input to trigger output. Anyway, open to any ideas to improve this.

Cheers
Jon
