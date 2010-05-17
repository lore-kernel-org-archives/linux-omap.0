From: Brian Swetland <swetland@google.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 11:45:32 -0700
Message-ID: <AANLkTillcFg_y-GeXJNBuIYiGvht-NBZPxwdb71qDui0@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	 <87hbm6cz90.fsf@deeprootsystems.com>
	 <1274115885.4418.59.camel@mulgrave.site>
	 <20100517174647.GA11512@gandalf>
	 <1274119179.4418.68.camel@mulgrave.site>
	 <20100517181252.GA14260@gandalf>
	 <AANLkTikueXPEWEHQt-Fl3Xvb3EB4ntsBlJUjjtmpinGK@mail.gmail.com>
	 <20100517183904.GA14047@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:45424 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab0EQSpg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 14:45:36 -0400
In-Reply-To: <20100517183904.GA14047@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: James Bottomley <James.Bottomley@suse.de>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>

On Mon, May 17, 2010 at 11:39 AM, Felipe Balbi <me@felipebalbi.com> wro=
te:
> Hi,
>
> On Mon, May 17, 2010 at 11:26:59AM -0700, Brian Swetland wrote:
>> We (Google) would like to allow completely open app distribution wit=
h
>> minimal hurdles, and avoid the walled garden approach. =C2=A0Toward =
this
>> goal we're not even requiring the use of a central app store for
>> distribution.
>
> I understand that, but still we should be telling developers what
> they're doing wrong so that they can improve themselves as profession=
als
> and still make the final device better.

I agree.  Which is why we develop tools to help developers understand
what their apps are doing.

>> For a large majority of apps, running in the background while the
>> device is asleep (screen off) is not essential, they don't request t=
he
>> "keep device awake" permission, never hold a wakelock, etc. =C2=A0Th=
ose
>> that do need to do this have the permission, may hold suspend
>> blockers, and are accounted for.
>
> but can anyone write an app that holds a suspend_blocker ?? If so, th=
en
> your goal is already broken, right ? I mean, if anyone can keep a
> suspend_blocker held forever, you'll never ever sleep, right ? While
> with runtime, if you keep the keypad open, only the keypad and the pa=
ths
> directly related to it (probably the i2c controller and the power dom=
ain
> where the i2c controller sits) will be kept alive, no ?

No, you'll never suspend, which is different from never going to the
lowest CPU power state.  On shipping Android devices we aggressively
completely power down the CPU in idle whenever we can (based on
latency requirements generally).  We power off peripherals whenever
they're not in use.

This is why I've stated previously that I don't think runtime PM and
opportunistic suspend are competitive features.  Everyone who cares
about minimizing power should want runtime pm or at least similar
functionality (our drivers have always powered down peripherals when
not in use, even while the device is open, etc, prior to the existence
of runtime PM).

If your environment is such that going to full suspend will not gain
you anything, then don't use opportunistic suspend.  We find that
there are savings to be had with this model in Android which is why we
use it.  If you are going to use opportunistic suspend,
suspend_blockers provide useful functionality.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
