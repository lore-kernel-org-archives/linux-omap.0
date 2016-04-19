From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 05/15] irqchip: Mask the non-type/sense bits when
 translating an IRQ
Date: Tue, 19 Apr 2016 15:23:35 +0100
Message-ID: <57163F67.4090303@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-6-git-send-email-jonathanh@nvidia.com>
 <20160409120333.3982c53b@arm.com> <57163D2F.5020005@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57163D2F.5020005-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 19/04/16 15:14, Jon Hunter wrote:
> 
> On 09/04/16 12:03, Marc Zyngier wrote:
>> On Thu, 17 Mar 2016 14:19:09 +0000
>> Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>
>>> The firmware parameter that contains the IRQ sense bits may also contain
>>> other data. When return the IRQ type, bits outside of these sense bits
>>> should be masked. If these bits are not masked and
>>> irq_create_fwspec_mapping() is called to map an IRQ, then the comparison
>>> of the type returned from irq_domain_translate() will never match
>>> that returned by irq_get_trigger_type() (because this function masks the
>>> none sense bits) and so we will always call irq_set_irq_type() to program
>>> the type even if it was not really necessary.
>>>
>>> Currently, the downside to this is unnecessarily re-programmming the type
>>> but nevertheless this should be avoided.
>>>
>>> The Tegra LIC, TI Crossbar and GIC-V3 irqchips all have client instances
>>> (from reviewing the device-tree sources) where bits outside the IRQ sense
>>> bits are set, but do not mask these bits. Therefore, ensure these bits
>>> are masked for these irqchips.
>>
>> For GICv3, this shouldn't be the case. The DT clearly says that the 3rd
>> field should only contain the trigger description. It looks like people
>> have been copying their GICv2 DT and simply slapped the v3 description
>> in the middle, without changing their interrupt specifiers. Duh.
> 
> Hmmm ... I was just double checking on this for the gic-v3 by wading
> through the DTS files, and may be there is no issue here. However,
> looking at the current code it is a bit inconsistent between firmware
> types ...
> 
>  static int gic_irq_domain_translate(struct irq_domain *d,
>                                      struct irq_fwspec *fwspec,
>                                      unsigned long *hwirq,
>                                      unsigned int *type)
>  {
>          if (is_of_node(fwspec->fwnode)) {
>                  if (fwspec->param_count < 3)
>                          return -EINVAL;
> 
>                  switch (fwspec->param[0]) {
>                  case 0:                 /* SPI */
>                          *hwirq = fwspec->param[1] + 32;
>                          break;
>                  case 1:                 /* PPI */
>                          *hwirq = fwspec->param[1] + 16;
>                          break;
>                  case GIC_IRQ_TYPE_LPI:  /* LPI */
>                          *hwirq = fwspec->param[1];
>                          break;
>                  default:
>                          return -EINVAL;
>                  }
> 
>                  *type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>                  return 0;
>          }
> 
>          if (is_fwnode_irqchip(fwspec->fwnode)) {
>                  if(fwspec->param_count != 2)
>                          return -EINVAL;
> 
>                  *hwirq = fwspec->param[0];
>                  *type = fwspec->param[1];

That's because param[1] doesn't really come from the firmware. It is
actually provided directly by acpi_dev_get_irq_type, so more or less
guaranteed to be a valid value.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
