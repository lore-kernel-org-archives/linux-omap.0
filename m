From: Tom Rini <trini@ti.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 09:46:28 -0500
Message-ID: <51263344.7010008@ti.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <20130221143716.GD17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51231 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773Ab3BUOqL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Feb 2013 09:46:11 -0500
In-Reply-To: <20130221143716.GD17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>

On 02/21/2013 09:37 AM, Russell King - ARM Linux wrote:
> (Dropped uboot mailing list because it constantly holds my mails for
> moderation.)
> 
> On Thu, Feb 21, 2013 at 09:08:58AM -0500, Tom Rini wrote:
>> On 02/21/2013 08:46 AM, Russell King - ARM Linux wrote:
>>> We're about to make it harder how?  By forcing them to use DT
>>> blobs? Or by forcing them to have to use the combined zImage + DT
>>> format because their boot loaders are soo broken that they can't
>>> deal with multiple images?
>>
>> None of that.  We're making it harder since most folks don't have a
>> board with 'bootz' built-in and the 'uImage' target doesn't build now
>> (unless, yes, you pass LOADADDR to make) so they either format it by
>> hand (/ adjust their local scripting) or do what you're doing.
> 
> And adjusting their process to pass an additional argument to the
> kernel make is too difficult?
> 
> So instead we have to change the kernel makefiles and scripting to
> create yet another uboot specific format, which is going to need
> them to edit their scripts in a much more invasive way _anyway_?
> 
> "or do what you're doing" - oh you mean, adding an additional column
> to the database configuration, digging out from the kernel git
> history what the load addresses should be, updating the database tables
> with that, editing the build system scripts to extract this new column
> from the database, and pass it into make... yes, complicated isn't it.
> Didn't take long to sort out though, and didn't require a load of new
> file formats to fix.

Shrug.  Time will tell if everyone adopts as easily as you have.

>>> Yes, things have become a _little_ harder since OMAP has switched
>>> to multiplatform, but it really isn't that bad.  My build and boot
>>> test system still works, and it uses uImage for all the OMAP
>>> platforms. You just have to give the right LOADADDR= argument to
>>> the kernel to make the uImage generation work again.  Sure, the
>>> resulting uImage can't be loaded at a different address, but you if
>>> you need to change that, you can quite easily move the existing
>>> uImage out and re-run make ARCH=arm uImage LOADADDR=<something
>>> else> and hey presto, you end up with the uImage generated for a
>>> different address.
>>>
>>> But: we wouldn't be in this situation if it weren't for these
>>> absurd uboot uImage formats in the first place.  Or even be needing
>>> this FIT stuff if zImage was just used directly.
>>
>> FIT isn't required.  FIT is just trying to offer a nice usability
>> thing to folks.  A point of device trees is a single image works in a
>> lot of places.  FIT gives you a single file works in a lot of places.
> 
> Well, FIT isn't everywhere either.  So really that argument doesn't
> stand for the same reasons that bootz support isn't everywhere either.
> 
> My SDP4430's uboot provided by TI uses uboot 1.1.4.  Therefore, it
> doesn't support FIT, nor bootz - only uImage.

Because I can easily see TI having given you an "odder" than usual
board, I won't suggest you simply run mainline U-Boot instead (and
enable CONFIG_CMD_BOOTZ).  I was wondering how old what we gave you was
tho, sigh.

>>> uboot dug _itself_ into this hole.  It's uboot's problem.
>>
>> A whole lot  of people dug this particular hole.  Joel is trying to
>> offer up a solution that maybe makes things easier for everyone.  Or
>> it gets rejected here too and distros will come up with their N
>> different ways to try and provide easier experiences to the end user.
> 
> FIT just propagates the "boot loader specific file format" absurdity
> which was a mistake when uImage came along...

Would you feel better about it if something else parsed FIT too?

-- 
Tom
