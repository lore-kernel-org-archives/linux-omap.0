From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: usage of sparse or other trick for improved type safety
Date: Tue, 12 Jun 2012 16:34:43 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73C43B977@DLEE10.ent.ti.com>
References: <EF62F09C0797D947AD4180A1043C0DF73C423E7B@DLEE10.ent.ti.com>
 <20120525075328.GM17852@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49956 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab2FLQfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 12:35:03 -0400
In-Reply-To: <20120525075328.GM17852@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "jean.pihet@newoldbits.com" <jean.pihet@newoldbits.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pasam, Vijay" <vpasam@ti.com>

Hi Tony,

> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, May 25, 2012 2:53 AM

Thanks for quick input.  Apologies on slow ack of it.

> Before we had these frameworks in place it was often hard to debug when
> something
> did not work for some omaps. Things would just not work or would stop
> working
> for some drivers with no ideas what was going on. So yeah, having these
> kind of
> frameworks in place has helped a lot to avoid breakage like you're
> describing
> above.

Trees which had to hit the lowest power states for full customer boards all employed some form of abstraction of clock, power, voltage. The one today in mainline today is the most clean. Aspects around auto-generation are very good even if a bit big in size.

Perhaps main grump I hear is the number of abstraction layers sometimes makes debugging difficult. It would be nice to find smart tricks for compile to prune away some.

Still one can experience some of the mystery issues, as the PRCM connection to IP-device utilizes a protocol which the device side can mess up. If the device does not shut down its local function and associated clocks cleanly it will show 'stuck in transition' and this gates final global changes. In one of the closed implementation we would bug() drivers who did not shut down their internal clocks properly before allowing global clock release.  Most of the issues seen in field are at drivers/peripheral-ip.


> For some external subsystems it might be possible to let the omap kernel
> manage
> powerdomains and other resource via remote proc interface, assuming these
> registers are ioremapped in the omap kernel side and not owned by the
> external
> subsystem. The messaging to do this would add some undesired latencies
> though,
> but maybe those would not be so critical for the external subsystems as
> they
> tend to be full on or completely off type accelerators.

Humm. Maybe for some. Guess walking what is used and sorting might tell.

The way some subsystems 'ideal' operation is described from designers implies tight control of timing and sequence for things like power state. A RPC doesn't feel like it fits with intent. However... practically speaking from 'full system view' RPC may fit sometimes. A subsystem exporting hooks to save 100uW using its optimal state set against other components running in 500mW range minimizes usefulness.
 
> The other alternative of course is to implement similar frameworks for the
> external subsystems. Some of this might be possible to implement as simple
> macros with some type checks if it's subsystem specific. For doing it for
> all omap devices, macros were soon found not to be enough as the various
> bits all over need to be linked together for managing various resources.

Agree. 

I don't know insides of all subsystems.  Though what I know or hear is kind of a mixed picture.

OMAP has an ultra high level of integration. As such you might find something like DSP-Bios may provide a good hook but quick integration of a previously standalone single purpose piece does not have time to be readapted.

The type checking question kind of grows out of this.  Linux might today offer a clean run-time api which is place where high wall should be built with type check.  But... the driver might not be able to function yet with the API alone given state of evolution of both ends.

Review question was pointing re-hitting of bugs for what could be argued 'ideal' internal framework api. How to fix up what is in use by real drivers or to add/fix external api so its useful should be roadmap.

Regards,
Richard W.

