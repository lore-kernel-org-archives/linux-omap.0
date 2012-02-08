From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 17:16:36 +0100
Message-ID: <4F329FE4.2090300@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207172809.GD26764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34737 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab2BHQQw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 11:16:52 -0500
In-Reply-To: <20120207172809.GD26764@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Mark,

On 2/7/2012 6:28 PM, Mark Brown wrote:
> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
>
>> The twl changes were done like that because it was assuming that
>> USE_OF and thus IRQ_DOMAIN will be enabled by default for all OMAP2+
>> platforms at 3.3 time.  The whole point of doing that was to reduce
>> the ifdefery in every drivers we have to adapt to DT.
>
> Note that those drivers have been buildable on non-OMAP platforms for a
> very long time now in order to give better build coverage for the
> function drivers.

Yes, sure, but the only restriction I was adding is to make that driver 
dependent of the IRQ_DOMAIN stuff. That should be there by default on 
every ARM platform soon and this is there as well for PPC. So this will 
still be buildable on other platforms assuming they will support IRQ_DOMAIN.

The point is that once we will fully use the irq_domain support to 
generic-chip that Rob is working on for this driver, we will always need 
IRQ_DOMAIN enabled.

So far the IRQ_DOMAIN support is minimal and just needed for DT because 
that piece of infrastructure was not ready at that time.

Regards,
Benoit
