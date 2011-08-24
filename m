From: Kevin Hilman <khilman@ti.com>
Subject: Re: How to handle named resources with DT?
Date: Wed, 24 Aug 2011 12:15:03 -0700
Message-ID: <87r54a1v0o.fsf@ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110812030218.GP30552@yookeroo.fritz.box>
	<20110812084106.GC19467@legolas.emea.dhcp.ti.com>
	<201108121635.42953.arnd@arndb.de> <4E45422D.4050708@ti.com>
	<CACxGe6s-2EAuvSqzn6yzDvCyVXa8vVVqG2X=1XFrUBnB=jsdxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41758 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab1HXTPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 15:15:09 -0400
Received: by mail-gy0-f182.google.com with SMTP id 10so1301729gyd.41
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 12:15:08 -0700 (PDT)
In-Reply-To: <CACxGe6s-2EAuvSqzn6yzDvCyVXa8vVVqG2X=1XFrUBnB=jsdxQ@mail.gmail.com>
	(Grant Likely's message of "Fri, 12 Aug 2011 11:21:43 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Walmsley <paul@pwsan.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, Aug 12, 2011 at 9:09 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> On 8/12/2011 4:35 PM, Arnd Bergmann wrote:
 
[...]

>>
>>> I think it's much easier to change the existing users of _byname over
>>> to fixed indexes than to come up with a new scheme that is better.

I disagree.  It's not only about ordering.  More on that below.

>> As you said previously, since we have to support both legacy probing and DT
>> for some time, it will be easier for these drivers to rely on the same API.
>>
>> Considering that adding that new property is not a huge effort anyway and
>> _byname API is a standard API that any driver should be able to use if
>> needed, it still worth adding the DT support for named resources for my
>> point of view.
>
> The assumption being made here is that the current Linux
> implementation detail dictates the binding design, but it does not.
>
> Binding authors should certainly look at the Linux implementation for
> inspiration, but established DT patterns still prevail if they are
> suitable for describing the hardware. In this case the pattern is that
> tuples in the reg property are strongly ordered and specified by the
> driver binding.
>
> So, I remain unconvinced that the 'reg' property binding is
> insufficient.  

If significant, in-tree usages of the feature for platform_devices is
not enough, What are you looking for as convincing arguments? 

> I have no plans to merge support for fetching _byname values from the
> device tree.

I find this an unfortunate position to hold to in this climate of
consolidation.

One of the goals of consolidation is to have core features handled by
core code.  To me this is a classic trade-off.  Either we implement it
in core code, or we force all the users (drivers, in this case) to
implement it themselves.  IMO, consolidation should be pointing us to
solving these kinds of problems in core code, rather than spreading it
across a bunch of drivers (and device code where the data lives.)
Especially so in this case since there are existing, in-tree users
demonstrating the usefulness of _byname.

Not implementing this in core code means all drivers using _byname have
to be converted, adding multiple lines of (IMHO ugly) code when it could
be implemented cleanly by core code, keeping drivers much more readable.
To me, the fact that there would also be an API difference compared to
the existing platform_device probing (which will stay for the forseeable
future) would be a major eye-sore in the drivers.

In addition, converting all the drivers away from _byname is not just a
matter of changing the drivers.  It also means of course you have to
make sure that all of the data is in order.  On OMAP, that means
reworking and/or regenerating all of the hwmod data to ensure it is in
the right order.  Sounds like the kind of churn that would get us
flamed.

But that's not all...

It's not just about data ordering.  As already pointed out, use of
_byname is also used to differentiate between different
versions/capabilities of the IP.  The driver can determine based on the
availability of a named resource the capabilities of the device.
Forcing resource ordering means some other mechanism also has to be
added for detection of the IP version and/or capabilities.

In summary, with the push towards consolidation, we're also trying to
have common drivers that support multiple versions of an IP across
differnet SoCs with varying capabilities.  Having named resources on the
platform_device is an established way of handling this cleanly in the
driver without the driver having to check SoC-specific or IP-version
specific registers.

Kevin
