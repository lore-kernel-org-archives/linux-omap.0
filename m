From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 10:45:26 -0800
Message-ID: <20170124184526.GA25056@roeck-us.net>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124175800.GA15070@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 24, 2017 at 06:58:01PM +0100, Pavel Machek wrote:
> 
> > >>Right.
> > >>
> > >>Before reverting, can you please try if this patch works or not?
> > >
> > >Not really. Revert now. Sorry.
> > >
> > >Are you sure? This does not look equivalent to me at all.
> > >
> > >"name" file handling moved from drivers to the core, which added some
> > >crazy checks what name can contain. Even if this "works", what is the
> > >expected effect on the "name" file?
> > >
> > The hwmon name attribute must not include '-', as documented in
> > Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
> > Maybe in your world, but not in mine.
> 
> Well, lets revert the patch and then we can discuss what to do with
> the "name" problem.
> 
Not sure what the problem to be discussed is. Please provide details.

> Unfortunately, code enforces different rules than documentation says,

Please specify your problem with rules vs. documentation. You mean the
additional checks which also block wildcards and spaces/newline in the
name ? Are you having a problem with those ? What are those problems ?
I'll be more than happy to update the documentation if your problem
is with that mismatch.

To provide some detail: libsensors gets just as confused with wildcards
and whitespace/newline as it does with '-' in the reported name, which
is why those are blocked by the new API.

> and it is all visible to userspace.
> 
We are talking about a value reported by an attribute, not about an attribute.
Maybe the ABI Police thinks differently, but I do not count fixing the value
reported by an attribute as an ABI change.

Effecively, what this enforcement does is to make userspace actually work.
Ultimately that means, per your standard, that fixing values reported by the
kernel is not permitted under any circumstances, even if such changes result
in userspace actually working as intended as a result of that change.
I would argue that such an enforcement goes a little bit too far.

In addition, there is actually another problem solved by the patch you want to
have reverted: The current thermal code has another problem, which is that it
creates the name attribute _after_ registering the hwmon device. The udev event
for creating the hwmon device thus occurs before its mandatory name attribute
(and any other attribute, for that matter) exists, meaning that any userspace
handler acting on it would be completely unpredictable. Now _this_ is a real
ABI "change", since it fixes a race condition. I guess you are going to argue
that this isn't permitted either ?

Guenter
