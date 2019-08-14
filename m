From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: Regression in Linux next with show wakeup sources stats in sysfs
Date: Wed, 14 Aug 2019 00:08:39 -0700
Message-ID: <5d53b378.1c69fb81.31b2e.5077@mx.google.com>
References: <20190814063803.GY52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814063803.GY52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalesh Singh <kaleshsingh@google.com>, Tony Lindgren <tony@atomide.com>, Tri Vo <trong@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2019-08-13 23:38:03)
> Hi all,
>=20
> Looks like commit 986845e747af ("PM / wakeup: Show wakeup sources stats
> in sysfs") has caused a regression in Linux next where I can now get
> some errors like this during the boot:
>=20
> kobject_add_internal failed for wakeup10 (error: -2 parent: usb)
>=20
> Any ideas why this might be happening? Maybe some deferred probe
> related issue?
>=20

Yeah! Take a look at this thread[1] and please test out patches I'm
throwing out there like a total cowboy(d).

[1] https://lkml.kernel.org/r/1565731976.8572.16.camel@lca.pw
