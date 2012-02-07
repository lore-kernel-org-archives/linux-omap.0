From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 01:54:57 +0100
Message-ID: <4F307661.6030706@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207002405.GA18209@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37287 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820Ab2BGAzR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Feb 2012 19:55:17 -0500
In-Reply-To: <20120207002405.GA18209@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Russell,

On 2/7/2012 1:24 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
>> In theory that patch should not be even needed.
>
> In theory that change is needed to fix the obviously broken code which
> is there at the moment.

Well, both patches were supposed to be merged during the last merge 
window, so this code is not broken but was just assuming that the proper 
default configs were there. It is an integration issue between two 
feature trees.

> So, irrespective of whether OF gets permanently enabled or not, that ifdef
> needs to go.

The whole point of adding USE_OF in default omap2plus_config was to 
avoid all the #ifdef that supporting both OF and non-OF build will generate.

> But, forcing OF on at this point probably isn't a good idea (who knows
> what else is lurking there) and there's a fairly simple and tested fix
> for this as I've shown in my OMAP patch.

The issues we are facing right now are already due to the usage of 
config that are not the default ones (omap2plus_defconfig), so adding 
even more options will just lead to even more potential build breaks in 
the future.
I think we need to reduce the amount of options we can support in order 
to avoid the current issues and not adding some more.

Since it was already agreed by the whole arm-soc community that DT is 
the only way to go, I guess that the sooner we enable that the better it is.

> That, I feel, is likely to have less side effects than force enabling
> USE_OF.

If we never enable USE_OF by default, we will never know...
So far I did not observe any regression by enabling USE_OF with a legacy 
board boot.

Regards,
Benoit



