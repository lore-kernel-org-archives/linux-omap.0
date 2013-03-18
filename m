From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 12:14:47 -0600
Message-ID: <51475997.2060008@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130222160044.GA16357@quad.lixom.net> <20130318163648.GA3722@amd.pavel.ucw.cz> <20130318164426.GI30923@n2100.arm.linux.org.uk> <20130318174931.GB4230@amd.pavel.ucw.cz> <20130318175746.GJ30923@n2100.arm.linux.org.uk> <20130318180458.GC4230@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45912 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab3CRSOv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 14:14:51 -0400
In-Reply-To: <20130318180458.GC4230@amd.pavel.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, "Rini, Tom" <trini@ti.com>, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 03/18/2013 12:04 PM, Pavel Machek wrote:
> On Mon 2013-03-18 17:57:46, Russell King - ARM Linux wrote:
>> On Mon, Mar 18, 2013 at 06:49:32PM +0100, Pavel Machek wrote:
>>> What I wanted to say is that kernel build traditionaly produced
>>> something useful, something bootloader can actually boot. Currently,
>>> make uImage produces u-boot image. Please keep that capability.
>>
>> Unfortunately, there is a fundamental problem with uImage.  It encodes
>> the load address, and that is utterly incompatible with the goal of
>> having a kernel image which boots on multiple platforms.
>>
>> uImage isn't going anywhere for the time being, but you will find
>> that:
>>
>> a) recent kernels will just wrap the zImage without a DTB, so
>>    appended DTBs can't be used with it
>> b) it won't work with MULTIPLATFORM-enabled kernels, unless you
>>    provide make with a LOADADDR= argument to tell it where the
>>    uImage is to be loaded - which is platform specific.
>>
>> (b) fundamentally can't be solved in kbuild.  If you want to use
>> uImage with multiple platforms from the same zImage, then you need
>> to generate multiple uImage files with different load addresses.
>> That's purely - and solely - down to the dysfunctional uImage format.
> 
> I know. uImage is not perfect. But solution should be "adopt a better
> format" (ARM FIT?), not "drop support for making useful images
> altogether" as Olof proposed before.

Raw zImage /is/ the useful format that should be adopted.

