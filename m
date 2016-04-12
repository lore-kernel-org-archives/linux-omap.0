From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type
 fails
Date: Tue, 12 Apr 2016 09:50:34 +0100
Message-ID: <570CB6DA.2050909@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171550200.3978@nanos> <56EAC761.1040801@nvidia.com>
 <20160409115854.492090a5@arm.com> <570BC34A.5030806@nvidia.com>
 <570BC528.9050601@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570BC528.9050601-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 11/04/16 16:39, Marc Zyngier wrote:
> On 11/04/16 16:31, Jon Hunter wrote:
>> On 09/04/16 11:58, Marc Zyngier wrote:

[snip]

>>> I think we need to phase things. Let's start with warning people for a
>>> few kernel releases. Actively maintained platforms will quickly address
>>> the issue (fixing their DT). As I see it, this issue seems rather
>>> widespread (even kvmtool outputs a DT with the wrong triggering
>>> information).
>>>
>>> Once we've fixed the bulk of the platforms and virtual environments, we
>>> can start thinking about making it fail harder.
>>
>> Ok, so are you OK with this patch as-is? If so, can I add your ACK?
> 
> It depends where you plan to handle the error. Ideally, I'd keep on
> returning the error (because that's the right thing to do), and move the
> WARN_ON() into the core code. We'd keep on ignoring the error as we're
> doing today, but we'd scream about it.
> 
> After a couple of releases, we'd turn the WARN_ON into a hard fail.
> 
> Thoughts?

I agree that would be best/ideal, but looking at it, I don't believe it
is possible and this is why I have not done that so far.

If we were to add the WARN to the core code, then we would need to add a
warning everywhere __irq_set_trigger() is called. One of the places it
is called today is from __setup_irq() and today this does the right
thing and handle any error returned. The problem is that in
irq_create_fwspec_mapping() we have never checked the return code from
irq_set_irq_type() (which calls __irq_set_trigger()) or attempted to
handle any errors. So the problem is that depending on the path through
which the type is programmed, errors may or may not be detected. This is
the actual headache :-(

Given that this problem so far only pertains to GIC PPI interrupts and
that it is a not a catastrophic error (interrupts still work fine), I
was thinking we add the warning to the GIC driver.

May be a less severe change would be to only return an error if
configuring an SPI fails and if it is a PPI then simply WARN and
carry-on as we assume we cannot change it.

I hope this summarises the issue a bit further.

Cheers
Jon




--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
