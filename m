From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type
 fails
Date: Fri, 18 Mar 2016 09:54:41 +0000
Message-ID: <56EBD061.6030502@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171550200.3978@nanos> <56EAC761.1040801@nvidia.com>
 <20160317151800.GH1184@io.lakedaemon.net> <56EAD93B.7040105@nvidia.com>
 <CAMuHMdU8PDUVZ8=S04fkahez1dh7JHjpj2-3w+Vfz05X=ZFMUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdU8PDUVZ8=S04fkahez1dh7JHjpj2-3w+Vfz05X=ZFMUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-renesas-soc-u79uwXL29Tb/PtFMR13I2A@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 18/03/16 09:20, Geert Uytterhoeven wrote:
> On Thu, Mar 17, 2016 at 5:20 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> On 17/03/16 15:18, Jason Cooper wrote:
>>> On Thu, Mar 17, 2016 at 03:04:01PM +0000, Jon Hunter wrote:
>>>> On 17/03/16 14:51, Thomas Gleixner wrote:
>>>>> On Thu, 17 Mar 2016, Jon Hunter wrote:
>>>>>> Setting the interrupt type for private peripheral interrupts (PPIs) may
>>>>>> not be supported by a given GIC because it is IMPLEMENTATION DEFINED
>>>>>> whether this is allowed. There is no way to know if setting the type is
>>>>>> supported for a given GIC and so the value written is read back to
>>>>>> verify it matches the desired configuration. If it does not match then
>>>>>> an error is return.
>>>>>>
>>>>>> There are cases where the interrupt configuration read from firmware
>>>>>> (such as a device-tree blob), has been incorrect and hence
>>>>>> gic_configure_irq() has returned an error. This error has gone
>>>>>> undetected because the error code returned was ignored but the interrupt
>>>>>> still worked fine because the configuration for the interrupt could not
>>>>>> be overwritten.
>>>>>>
>>>>>> Given that this has done undetected and we should only fail to set the
>>>>>> type for PPIs whose configuration cannot be changed anyway, don't return
>>>>>> an error and simply WARN if this fails. This will allows us to fix up any
>>>>>> places in the kernel where we should be checking the return status and
>>>>>> maintain back compatibility with firmware images that may have incorrect
>>>>>> interrupt configurations.
>>>>>
>>>>> Though silently returning 0 is really the wrong thing to do. You can add the
>>>>> warn, but why do you want to return success?
>>>>
>>>> Yes that would be the correct thing to do I agree. However, the problem
>>>> is that if we do this, then after the patch "irqdomain: Don't set type
>>>> when mapping an IRQ" is applied, we may break interrupts for some
>>>> existing device-tree binaries that have bad configuration (such as omap4
>>>> and tegra20/30 ... see patches 1 and 2) that have gone unnoticed. So it
>>>> is a back compatibility issue.
> 
> Indeed (also for sh73a0 and r8a7779).

Thanks. I was wondering if there are others. Do you know what the
correct setting should be? Ie. should it be IRQ_TYPE_EDGE_RISING as
well? I can then include this with OMAP and Tegra.

>>> This sounds like a textbook case for adding a boolean dt property.  If
>>> "can-set-ppi-type" is absent (old DT blobs and new blobs without the
>>> ability), warn and return zero.  If it's present, the driver can set the
>>> type, returning errors as encountered.
>>
>> True. However, if we did have this "can-set-ppi-type" property set for a
>> device, it really should never fail (unless someone specified it
>> incorrectly). So I am trying to understand the value in adding a new DT
>> property.
> 
> Do we really want to add properties that basically indicate that a description
> in DT is correct?
> 
> Alternatively, it can be fixed in the kernel in a DT quirk (if SoC == xxx then
> fix TWD).

I am not sure I fully understand your proposal, but please note that it
may not be just limited to the TWD (although this does appear to be the
one client that is wrong for a lot of SoCs). PPIs are also used for the
armv7/8 timers as well.

The problem is that we have a lot of SoCs with twd-timers and I have no
way to test all of these to know which could be a problem. So I thought
that warning would be a good first step to fixing them.

However, I am still trying to see the real value in returning an error
in this case. May be I am the only one with that perspective?

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
