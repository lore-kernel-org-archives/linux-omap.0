From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/5] ARM: OMAP2/3: intc: Add irqdomain support
Date: Mon, 9 Jan 2012 10:56:24 +0100
Message-ID: <4F0AB9C8.10501@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com> <1324388398-2683-3-git-send-email-b-cousson@ti.com> <20120106212230.GB7457@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56314 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab2AIJ4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 04:56:37 -0500
In-Reply-To: <20120106212230.GB7457@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: rob.herring@calxeda.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Grant,

On 1/6/2012 10:22 PM, Grant Likely wrote:
> On Tue, Dec 20, 2011 at 02:39:55PM +0100, Benoit Cousson wrote:

[...]

>> +	/*
>> +	 * XXX: Use a 0 irq_base for the moment since the legacy devices
>> +	 * created statically are expected a hwirq = irq mapping.
>> +	 * A proper offset will be added later, when IRQ resource creation
>> +	 * will be handled by DT.
>> +	 */
>> +	domain.irq_base = 0;
>> +	domain.nr_irq = nr_irqs;
>> +	domain.ops =&irq_domain_simple_ops;
>> +	irq_domain_add(&domain);
>
> The omap doesn't need anything special from irq_domain.  You can use
> irq_domain_add_simple().  A recent patch was posted that makes
> irq_domain_add_simple() accepts a nr_irqs parameter and returns the
> allocated irq domain.

Yes, I saw that, but in fact as discussed previously with Rob, even the 
irq_domain_add_simple should become useless when Rob's series to convert 
generic-chip to use irq_domain will be merged.

I have a patch ready for that, but like Nico for AT91, I decided to 
avoid that dependency for 3.3, since that series was not yet stable.

> However, that isn't enough reason for me to reject this patch if there
> is any opportunity to get it into v3.3 provided you promise to fix it
> up later.

Yes, I do :-)

> Acked-by: Grant Likely<grant.likely@secretlab.ca>

Thanks,
Benoit
