From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: Regression in Linux next with show wakeup sources stats in sysfs
Date: Wed, 14 Aug 2019 07:56:50 -0700
Message-ID: <5d542133.1c69fb81.f5f57.0098@mx.google.com>
References: <20190814063803.GY52127@atomide.com> <5d53b378.1c69fb81.31b2e.5077@mx.google.com> <20190814073234.GZ52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814073234.GZ52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalesh Singh <kaleshsingh@google.com>, Tri Vo <trong@android.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2019-08-14 00:32:34)
> * Stephen Boyd <swboyd@chromium.org> [190814 07:09]:
> > Quoting Tony Lindgren (2019-08-13 23:38:03)
> > > Hi all,
> > >=20
> > > Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources sta=
ts
> > > in sysfs") has caused a regression in Linux next where I can now get
> > > some errors like this during the boot:
> > >=20
> > > kobject_add_internal failed for wakeup10 (error: -2 parent: usb)
> > >=20
> > > Any ideas why this might be happening? Maybe some deferred probe
> > > related issue?
> > >=20
> >=20
> > Yeah! Take a look at this thread[1] and please test out patches I'm
> > throwing out there like a total cowboy(d).
> >=20
> > [1] https://lkml.kernel.org/r/1565731976.8572.16.camel@lca.pw
>=20
> Oh OK thanks, looks like I'm a bit behind then. My test case turned
> out to be caused by device_init_wakeup() called before device_add() for
> power_supply in case that helps. In that case create_dir() will fail
> for kobject_add_internal(). Doing something like below fixes the
> issue, but seems like we probably have other similar issues as well.
> Adding Sebastian to Cc in case this might be a real problem despite
> the other issues.
>=20

Ah yeah. I sent a patch for power supply earlier[2], but now I'm
thinking that it would be better to take the approach in the thread I
mentioned where we just don't add sysfs stuff until when device_add() is
called.

[2] https://lkml.kernel.org/r/20190801213330.81079-1-swboyd@chromium.org
