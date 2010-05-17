From: Mike Chan <mike@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 11:47:42 -0700
Message-ID: <AANLkTikr08_76kTyd9QjizeDJMs4JZAMSvCdTk0gGnve@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	 <87hbm6cz90.fsf@deeprootsystems.com>
	 <1274115885.4418.59.camel@mulgrave.site>
	 <20100517174647.GA11512@gandalf>
	 <1274119179.4418.68.camel@mulgrave.site>
	 <20100517181252.GA14260@gandalf>
	 <AANLkTikueXPEWEHQt-Fl3Xvb3EB4ntsBlJUjjtmpinGK@mail.gmail.com>
	 <20100517183904.GA14047@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100517183904.GA14047@gandalf>
Sender: linux-kernel-owner@vger.kernel.org
To: me@felipebalbi.com
Cc: Brian Swetland <swetland@google.com>, James Bottomley <James.Bottomley@suse.de>, Kevin Hilman <khilman@deeprootsystems.com>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 17, 2010 at 11:39 AM, Felipe Balbi <me@felipebalbi.com> wro=
te:
> Hi,
>
> On Mon, May 17, 2010 at 11:26:59AM -0700, Brian Swetland wrote:
>> We (Google) would like to allow completely open app distribution wit=
h
>> minimal hurdles, and avoid the walled garden approach. =A0Toward thi=
s
>> goal we're not even requiring the use of a central app store for
>> distribution.
>
> I understand that, but still we should be telling developers what
> they're doing wrong so that they can improve themselves as profession=
als
> and still make the final device better.
>

We currently do track power usage per-application which is displayed
in the phone UI. (Settings -> About Phone -> Battery Usage).  We also
provide several (although not perfect) command line utilities for
developers to see their power impact system.

We are constantly working on ways to improve tracking and make such
power data more accessible to developers so they can see how their
applications are impacting battery life.

>> Obviously, given the ability to run *any* app, users will run into b=
ad
>> (or perhaps just less-than-optimal-powerwise) apps. =A0Being able to
>> provide the best possible battery life (in spite of
>> sometimes-nonoptimal userspace apps) and simultaneously informing
>> users about which apps are better/worse for their battery life is a
>> goal here.
>
> I see. Just hope MeeGo doesn't venture on the same waters :-s
>
>> For a large majority of apps, running in the background while the
>> device is asleep (screen off) is not essential, they don't request t=
he
>> "keep device awake" permission, never hold a wakelock, etc. =A0Those
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
>

Any app can grab a suspend blocker, and the stats are logged, and if
you're app is abusing wakelocks and CPU resource it will show up in
the "Battery Use" panel.

-- Mike

>> Unrelated to apps, the ability to say "please enter suspend as soon =
as
>> there's no more work (kernel or userspace) preventing it", in a
>> simple, non-racy way is useful.
>
> I just tend to agree with Kevin on questioning how different how
> different this actually is from runtime_pm. I guess I would need to d=
ig
> through some documentation in order to understand but it seems really
> similar.
>
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
