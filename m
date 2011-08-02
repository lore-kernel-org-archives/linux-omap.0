From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
	wake-up constraints
Date: Wed, 3 Aug 2011 00:16:17 +0200
Message-ID: <201108030016.18174.rjw@sisk.pl>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<201108022220.00019.rjw@sisk.pl> <8762mfecdk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8762mfecdk.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, August 02, 2011, Kevin Hilman wrote:
> [adding Mark Brown as we discussed similar topics a couple plumbers ago]
> 
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> [...]
> 
> >> >> The new class is only available from kernel drivers and so is not exported
> >> >> to user space.
> >> >
> >> > It should be available to user space, however, because in many cases drivers
> >> > simply have no idea what values to use (after all, the use decides if he
> >> > wants to trade worse video playback quality for better battery life, for
> >> > example).
> >> >
> >> 
> >> FWIW, I think it's wrong to expose the raw per-device constraints
> >> directly to userspace.
> >> 
> >> I think it's the responsibility of the subsystems (video, audio, input,
> >> etc.) to expose QoS knobs to userspace as they see fit and now allow
> >> userspace to tinker directly with QoS constraints.
> >
> > This assumes that those "subsystems" or rather "frameworks" (a bus type or
> > a device class is a subsystem in the terminology used throughout the PM
> > documentation) will (a) know about PM QoS and (b) will care to handle it.
> > Both (a) and (b) seem to be unrealistic IMHO.
> 
> I disagree and think that both are quite realistic (mainly because they
> exist today, albiet mostly out of tree because no generic QoS framework
> exist.  e.g. on OMAP, we have OMAP-specific *kernel* APIs for requesting
> per-device wakeup latencies, and drivers and frameworks are using them.)

I'm sure there are frameworks using such things.  I'm also sure there
are frameworks that don't.  BTW, the "we have it out of the tree" argument is
not very useful, so I'd appreciate it if you didn't use it.

> Most of these frameworks already have QoS constraints/requirements but
> have no generic way to express them.  That's why we're pushing for a
> generic constraints framework.
> 
> Consider video for example.  It's the kernel-side drivers, not user
> space apps, that know about the latency or throughput constraints based
> on e.g. frame rate, bytes/pixel, double/triple buffering, PIP, multiple
> displays, etc. etc.   
> 
> In this case, the video framework (V4L2) might not want any knobs
> exposed to userspace because userspace simply doesn't have the knowledge
> to set appropriate constraints.  I'm less familiar with audio, but I
> believe audio would be similar (sample rate, number of channels, mixing
> with other concurrent audio streams, etc. etc. are all known by the
> kernel-side code.)
> 
> On the other hand, consider touchscreen.  Touchscreens have a
> configurable sample rate which allows a trade-off between power savings
> and accuracy.  For example, low accuracy (and thus low power) would be
> fine for a UI which is only taking finger gestures, but if the
> application was doing handwriting recognition with a stylus, it would
> likely want higher accuracy (and consume more power.)
> 
> In this case, the kernel driver has no way of knowing what the
> application is doing, so some way for touchscreen apps to request this
> kind of constraint would be required.
> 
> My point is it should be up to each framework (audio, video,
> input/touchscreen) to expose a userspace interface to their users that
> makes sense for the *specific needs* of the framework.
> 
> Using the above examples, audio and video might not need (or want) to
> expose anything to userspace, where touchscreen would.  IMO, it would be
> much more obvious for a touchscreen app to use a new API in tslib (which
> it is already using) to set its constraints rather than having to use
> tslib for most things but a sysfs file for QoS.
> 
> > We already export wakeup and runtime PM knobs per device via sysfs and
> > I'm not so sure why PM QoS is different in that respect.
> 
> As stated above, because for many frameworks userspace simply does not
> have all (or any) of the knowledge to set the right constraints.

I still don't understand what's wrong with allowing user space to _add_
requirements.  The will only override the drivers' or frameworks' requirements
if they are stronger, so the functionality shouldn't be hurt.  They may cause
some more energy to be used, but if user space wants that, it's pretty much
fine by me.

Thanks,
Rafael
