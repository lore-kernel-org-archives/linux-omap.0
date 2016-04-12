From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from
 binding document
Date: Tue, 12 Apr 2016 09:54:32 +0100
Message-ID: <570CB7C8.4090103@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
 <CAL_JsqLwvhbCnQzkRd1cyz+O6HU8a3X3MYoX=ChhuDyvdTWQYA@mail.gmail.com>
 <56EBBE38.6070303@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56EBBE38.6070303-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Rob, Mark, Marc,

On 18/03/16 08:37, Jon Hunter wrote:
> 
> On 17/03/16 20:14, Rob Herring wrote:
>> On Thu, Mar 17, 2016 at 9:19 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
>>> Domain properties") documented optional clock and power-dmoain properties
>>> for the ARM GIC. Currently, there are no users of these and for the
>>> Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
>>> functional clock and interface clock, that need to be enabled.
>>>
>>> To allow flexibility, drop the 'clock-names' from the GIC binding and
>>> just provide a list of clocks which the driver can parse. It is assumed
>>> that any clocks that are listed, need to be enabled in order to access
>>> the GIC.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> ---
>>>
>>> Please note that I am not sure if this will be popular, but I am trying
>>> to come up with a generic way to handle multiple clocks that may be
>>> required for accessing a GIC.
>>
>> It's not. :)
>>
>> We need to specify the number and order of clocks by compatible string
>> at a minimum. Sadly, ARM's GICs are well documented and include clock
>> names, so you can't just make up genericish names either which is
>> probably often the case.
> 
> Do you have any suggestions then?
> 
> I have had a look at the ARM TRMs and although I see that they do show
> the functional clock, there is no mention of whether there are any other
> clocks need in order to interface to the GIC (ie. bus clock). I know
> that for other SoCs such as OMAP it is common to have both a functional
> clock and interface clock. So I believe this is fairly common.

Any thoughts on how I should handle this for the Tegra AGIC?

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
