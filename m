From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 13:52:18 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112161320040.12660@utopia.booyaka.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com> <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com> <1324023504.1859.11.camel@deskari> <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com> <1324025267.1859.29.camel@deskari>
 <alpine.DEB.2.00.1112160211400.12660@utopia.booyaka.com> <20111216171906.GZ32251@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33026 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964999Ab1LPUwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 15:52:19 -0500
In-Reply-To: <20111216171906.GZ32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

Hi

On Fri, 16 Dec 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [111216 00:41]:
> > On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
> > 
> > > On Fri, 2011-12-16 at 01:27 -0700, Paul Walmsley wrote:
> > > > On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
> > > > 
> > > > > But with DT we can't use func pointers in platform_data either, right?
> > > > 
> > > > In the future, if someone wants to run a platform_data-less kernel, 
> > > > they'll have to come up with a replacement mechanism for these.  Several 
> > > > replacements have been proposed internally, such as having an 
> > > > omap_bus/omap_device for devices with OMAP-specific integration, but right 
> > > > now there are more pressing crises to deal with...
> > > 
> > > Ok. Benoit was telling me not to use pdata, so I thought it's a hard
> > > rule for DT. He didn't give me a clear alternative, though =).
> > 
> > As far as I know, we've got no other choice.  And if we don't add these, 
> > then not only will current code be broken, but when the time comes to 
> > convert away from using platform_data function pointers, then no one will 
> > know what functions should be exposed from the integration code for the 
> > driver to call.
> 
> There really should not be any need for platform_data with device tree.

Sure, if there's some replacement way for drivers to call integration 
functions.  Right now there's no substitute, AFAIK.  So far no one who has 
written that platform_data function pointers should not be used has been 
able to come up with a concrete alternative.

> Idling a device should be done with pm_runtime calls. Then the
> bus code should idle the right device, in this case using the hwmod
> calls.

There seems to be some misunderstanding here...

This patch falls into one of two cases, as discussed further in 

   http://marc.info/?l=linux-omap&m=132402667320943&w=2

If the device never needs to run in smart-idle wakeup mode, then what you 
wrote is right -- there's no need for a new device->integration function 
call here.  The HWMOD_SWSUP_SIDLE flag should work fine, and no 
new platform_data function pointers are needed.

However, if the device does occasionally need to run at different levels 
of "idle", as several of our devices do, then some new device->integration 
function calls are indeed needed.  PM runtime doesn't provide an interface 
for varying gradations of "idle".  This was discussed with Rafael and 
Magnus a few months ago at LinuxCon Japan, and Rafael indicated at the 
time that he felt those should be implemented by some other mechanism, 
outside PM runtime.  This makes some sense since it's not clear right now 
(to me, anyway) how to implement something like this in a completely 
generic way.

...

Generally speaking, there are several integration functions that we either 
call now via platform_data function pointers, or will need to call in the 
future, from drivers.  Even after the device tree conversion.  Adjusting 
the idle state that an IP block can enter when it enters PM runtime idle 
is one set.  Implementing integration-level device reset while the device 
is enabled is another -- PM runtime (rightly in my view) doesn't have 
anything to do with that.

> Most of the platform_data function pointers can be replaced with
> Linux generic calls for regulator framework etc. If some frameworks
> are missing, then that's obviously a problem that should be addressed.

As written here:

   http://marc.info/?l=linux-omap&m=132402415520208&w=2

there seem to be a few different options for long-term approaches.  But 
implementing these will take quite some time and discussion.  Depending on 
what's done, the solution might touch a lot of code.  In the meantime we 
have bugs that should be fixed.  Dealing with them now with platform_data 
function pointers has the nice side benefit that it provides visibility to 
the remaining operations that do need to cross the device->integration 
boundary.

So in case it was unclear, I'm not advocating platform_data function 
pointers are the long-term answer.  But they seem to be an important step 
in the transition to whatever mechanism appears next, since no alternative 
seems to exist.

> Different devices can be handled with a combination of compatible
> flag + data. For example, take a look at drivers/tty/serial/of_serial.c
> and note how the of_platform_serial_table has a .data pointer for
> each different device.

Hmm, I don't quite understand this part.  You're referring to 
non-executable data here?


- Paul
