From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Wed, 25 Jan 2017 13:09:18 +0100
Message-ID: <20170125120918.GA7936@pali>
References: <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd>
 <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125111233.GB3912@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 January 2017 12:12:33 Pavel Machek wrote:
> Hi!
> 
> > > > >>Right.
> > > > >>
> > > > >>Before reverting, can you please try if this patch works or not?
> > > > >
> > > > >Not really. Revert now. Sorry.
> > > > >
> > > > >Are you sure? This does not look equivalent to me at all.
> > > > >
> > > > >"name" file handling moved from drivers to the core, which added some
> > > > >crazy checks what name can contain. Even if this "works", what is the
> > > > >expected effect on the "name" file?
> > > > >
> > > > The hwmon name attribute must not include '-', as documented in
> > > > Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> > > > Maybe in your world, but not in mine.
> > > 
> > > Well, lets revert the patch and then we can discuss what to do with
> > > the "name" problem.
> 
> Ok, so the patch is on the way in. What to do next?
> 
> pavel@n900:/sys/class/hwmon$ cat hwmon0/name
> bq27200-0
> pavel@n900:/sys/class/hwmon$ cat hwmon1/name
> rx51-battery
> 
> > To provide some detail: libsensors gets just as confused with wildcards
> > and whitespace/newline as it does with '-' in the reported name, which
> > is why those are blocked by the new API.
> 
> Ok... Question is "does someone actually use hwmon*/name on N900"? If
> so, we can't change it, but it is well possible that noone is.

IIRC hwmon is used on Nokia N900.

But I have not seen hwmon devices for bq27200 and rx51-battery yet.
Those are power supply driver and auto-exporting them also via hwmon is
something new, right? If yes, then we can use any name for those new
hwmon devices as they cannot break userspace... as there is no userspace
application for them.

> Next question is .. are there other drivers affected? Do we want to do
> '-' -> '_' in the core or somewhere in the drivers? We might want to
> do the change in early in 4.11 and see what breaks....

IIRC hwmon core does not accept '-' for a long time (maybe all 4.x
versions?).

-- 
Pali Rohár
pali.rohar@gmail.com
