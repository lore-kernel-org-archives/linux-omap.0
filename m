From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 06:26:52 +0100
Message-ID: <4F30B61C.3020801@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com> <4F306016.9010203@ti.com> <20120207002405.GA18209@n2100.arm.linux.org.uk> <CACxGe6t0-10DOwrh_auvUtOUZ3SCgiz8vFrf35LejT+Py8q0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41995 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab2BGF1J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Feb 2012 00:27:09 -0500
In-Reply-To: <CACxGe6t0-10DOwrh_auvUtOUZ3SCgiz8vFrf35LejT+Py8q0zA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On 2/7/2012 5:35 AM, Grant Likely wrote:
> On Mon, Feb 6, 2012 at 5:24 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> On Tue, Feb 07, 2012 at 12:19:50AM +0100, Cousson, Benoit wrote:
>>> In theory that patch should not be even needed.
>>
>> In theory that change is needed to fix the obviously broken code which
>> is there at the moment.
>>
>> So, irrespective of whether OF gets permanently enabled or not, that ifdef
>> needs to go.
>>
>> But, forcing OF on at this point probably isn't a good idea (who knows
>> what else is lurking there) and there's a fairly simple and tested fix
>> for this as I've shown in my OMAP patch.
>>
>> That, I feel, is likely to have less side effects than force enabling
>> USE_OF.
>
> +1.  Fix the obvious bug in 3.3.  In 3.4 this hunk of code is going to
> be replaced anyway.

Yeah, but that's the point. You can fix that by either adding some more 
#ifdef in the driver knowing that this code will be completely removed 
in the next merge window, or you can fix that by adding the USE_OF in 
the omap2+ defconfig like it was supposed to be done originally.

The first one is a temp fix that will be thrown away whereas the second 
approach is the long term solution we have to implement anyway.

It looks to me that doing the long term solution instead of the temp fix 
is much more efficient and will avoid un-necessary churn.

Moreover, with Rob latest series, IRQ_DOMAIN will be enabled on every 
ARM platform, so the "depend IRQ_DOMAIN" that "fix" is removing right 
now will have to be added again once we will move that code to use 
genirq domain support.
Again, that seems to be a lot of churn for nothing...

Anyway, I guess it is Tony's call at the end, so I let him decide.

Regards,
Benoit

