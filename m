From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type
 fails
Date: Mon, 11 Apr 2016 16:39:20 +0100
Message-ID: <570BC528.9050601@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
 <alpine.DEB.2.11.1603171550200.3978@nanos> <56EAC761.1040801@nvidia.com>
 <20160409115854.492090a5@arm.com> <570BC34A.5030806@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570BC34A.5030806-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/04/16 16:31, Jon Hunter wrote:
> Hi Mark,
> 
> On 09/04/16 11:58, Marc Zyngier wrote:
>> On Thu, 17 Mar 2016 15:04:01 +0000
>> Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>
>>>
>>> On 17/03/16 14:51, Thomas Gleixner wrote:
>>>> On Thu, 17 Mar 2016, Jon Hunter wrote:
>>>>
>>>>> Setting the interrupt type for private peripheral interrupts (PPIs) may
>>>>> not be supported by a given GIC because it is IMPLEMENTATION DEFINED
>>>>> whether this is allowed. There is no way to know if setting the type is
>>>>> supported for a given GIC and so the value written is read back to
>>>>> verify it matches the desired configuration. If it does not match then
>>>>> an error is return.
>>>>>
>>>>> There are cases where the interrupt configuration read from firmware
>>>>> (such as a device-tree blob), has been incorrect and hence
>>>>> gic_configure_irq() has returned an error. This error has gone
>>>>> undetected because the error code returned was ignored but the interrupt
>>>>> still worked fine because the configuration for the interrupt could not
>>>>> be overwritten.
>>>>>
>>>>> Given that this has done undetected and we should only fail to set the
>>>>> type for PPIs whose configuration cannot be changed anyway, don't return
>>>>> an error and simply WARN if this fails. This will allows us to fix up any
>>>>> places in the kernel where we should be checking the return status and
>>>>> maintain back compatibility with firmware images that may have incorrect
>>>>> interrupt configurations.
>>>>
>>>> Though silently returning 0 is really the wrong thing to do. You can add the
>>>> warn, but why do you want to return success?
>>>
>>> Yes that would be the correct thing to do I agree. However, the problem
>>> is that if we do this, then after the patch "irqdomain: Don't set type
>>> when mapping an IRQ" is applied, we may break interrupts for some
>>> existing device-tree binaries that have bad configuration (such as omap4
>>> and tegra20/30 ... see patches 1 and 2) that have gone unnoticed. So it
>>> is a back compatibility issue.
>>>
>>> If you are wondering why these interrupts break after "irqdomain: Don't
>>> set type when mapping an IRQ", it is because today
>>> irq_create_fwspec_mapping() does not check the return code from setting
>>> the type, but if we defer setting the type until __setup_irq() which
>>> does check the return code, then all of a sudden interrupts that were
>>> working (even with bad configurations) start to fail.
>>>
>>> The reason why I opted not to return an error code from
>>> gic_configure_irq() is it really can't fail. The failure being reported
>>> does not prevent the interrupt from working, but tells you your
>>> configuration does not match the hardware setting which you cannot
>>> overwrite.
>>>
>>> So to maintain back compatibility and avoid any silent errors, I opted
>>> to make it a WARN and not return an error.
>>>
>>> If people are ok with potentially breaking interrupts for device-tree
>>> binaries with bad settings, then I am ok to return an error here.
>>
>> I think we need to phase things. Let's start with warning people for a
>> few kernel releases. Actively maintained platforms will quickly address
>> the issue (fixing their DT). As I see it, this issue seems rather
>> widespread (even kvmtool outputs a DT with the wrong triggering
>> information).
>>
>> Once we've fixed the bulk of the platforms and virtual environments, we
>> can start thinking about making it fail harder.
> 
> Ok, so are you OK with this patch as-is? If so, can I add your ACK?

It depends where you plan to handle the error. Ideally, I'd keep on
returning the error (because that's the right thing to do), and move the
WARN_ON() into the core code. We'd keep on ignoring the error as we're
doing today, but we'd scream about it.

After a couple of releases, we'd turn the WARN_ON into a hard fail.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
