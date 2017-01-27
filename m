From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 22:40:33 +0800
Message-ID: <1485528033.2469.61.camel@intel.com>
References: <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
         <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
         <20170123234912.GA2460@roeck-us.net>
         <20170124070639.GA5068@rzhang1-surface> <20170124073720.GB5603@amd>
         <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
         <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
         <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
         <1485481030.2469.15.camel@intel.com>
         <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
         <1485488382.2469.27.camel@intel.com>
         <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2017-01-26 at 22:27 -0800, Guenter Roeck wrote:
> On 01/26/2017 07:39 PM, Zhang Rui wrote:
> > 
> > On Thu, 2017-01-26 at 18:03 -0800, Guenter Roeck wrote:
> > > 
> > > On 01/26/2017 05:37 PM, Zhang Rui wrote:
> > > > 
> > > > 
> > > > On Wed, 2017-01-25 at 13:09 +0100, Pali Rohár wrote:
> > > > > 
> > > > > 
> > > > > On Wednesday 25 January 2017 12:12:33 Pavel Machek wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Hi!
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Right.
> > > > > > > > > > > 
> > > > > > > > > > > Before reverting, can you please try if this
> > > > > > > > > > > patch
> > > > > > > > > > > works
> > > > > > > > > > > or not?
> > > > > > > > > > Not really. Revert now. Sorry.
> > > > > > > > > > 
> > > > > > > > > > Are you sure? This does not look equivalent to me
> > > > > > > > > > at
> > > > > > > > > > all.
> > > > > > > > > > 
> > > > > > > > > > "name" file handling moved from drivers to the
> > > > > > > > > > core,
> > > > > > > > > > which
> > > > > > > > > > added some
> > > > > > > > > > crazy checks what name can contain. Even if this
> > > > > > > > > > "works",
> > > > > > > > > > what is the
> > > > > > > > > > expected effect on the "name" file?
> > > > > > > > > > 
> > > > > > > > > The hwmon name attribute must not include '-', as
> > > > > > > > > documented
> > > > > > > > > in
> > > > > > > > > Documentation/hwmon/sysfs-interface. Is enforcing
> > > > > > > > > that
> > > > > > > > > 'crazy' ?
> > > > > > > > > Maybe in your world, but not in mine.
> > > > > > > > Well, lets revert the patch and then we can discuss
> > > > > > > > what to
> > > > > > > > do
> > > > > > > > with
> > > > > > > > the "name" problem.
> > > > > > Ok, so the patch is on the way in. What to do next?
> > > > > > 
> > > > > > pavel@n900:/sys/class/hwmon$ cat hwmon0/name
> > > > > > bq27200-0
> > > > > > pavel@n900:/sys/class/hwmon$ cat hwmon1/name
> > > > > > rx51-battery
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > To provide some detail: libsensors gets just as confused
> > > > > > > with
> > > > > > > wildcards
> > > > > > > and whitespace/newline as it does with '-' in the
> > > > > > > reported
> > > > > > > name,
> > > > > > > which
> > > > > > > is why those are blocked by the new API.
> > > > > > Ok... Question is "does someone actually use hwmon*/name on
> > > > > > N900"?
> > > > > > If
> > > > > > so, we can't change it, but it is well possible that noone
> > > > > > is.
> > > > > IIRC hwmon is used on Nokia N900.
> > > > > 
> > > > > But I have not seen hwmon devices for bq27200 and rx51-
> > > > > battery
> > > > > yet.
> > > > > Those are power supply driver and auto-exporting them also
> > > > > via
> > > > > hwmon
> > > > > is
> > > > > something new, right? If yes, then we can use any name for
> > > > > those
> > > > > new
> > > > > hwmon devices as they cannot break userspace... as there is
> > > > > no
> > > > > userspace
> > > > > application for them.
> > > > > 
> > > > If this is the case, you'd better set
> > > > (struct thermal_zone_params)->no_hwmon when registering the
> > > > thermal
> > > > zone device, in which case, the hwmon device will not be
> > > > created.
> > > > 
> > > > In fact, I'd prefer to change tzp->no_hwmon to tzp->hwmon to
> > > > not
> > > > create
> > > > hwmon I/F by default, and see if there is anyone using it. If
> > > > yes,
> > > > we
> > > > can set the flag in soc thermal driver, explicitly, at
> > > > meantime, a
> > > > hwmon compatible name is required.
> > > > 
> > > > But one foreseeable result is that we may get bug reports from
> > > > end
> > > > user
> > > > that some sensors (acpitz, etc) are gone in 'sensors' output.
> > > > And
> > > > TBH,
> > > > I'm not quite sure if this can be counted as a regression or
> > > > not.
> > > > 
> > > That sounds like fun. Changing bq27200-0 to bq27200_0 is
> > > Forbidden by
> > > the ABI Police, but taking the entire device away is ok.
> > > 
> > No. IMO, it depends on if the interface is used or not.
> > If hwmon I/F is used, we can not take it away, nor change its name.
> Even if the use doesn't depend on that name ?
> 
when I said "the interface is used", I mean the name string is used.
> > 
> > If thermal zone I/F is used, we can not change it's 'type' name to
> > be
> > compatible with new hwmon API.
> > 
> You mean you can not fix the name to be compatible with libsensors.
> 

We can try to convert it to a libsensor-compatible string, either for
hwmon only, or for both thermal and hwmon. But this is an ABI change,
right?
And my understanding about the ABI change is that, if no one cares
about it, we're okay, or else, this is a regression, and we need to
fall back to the previous ABI immediately. In order to change it in a
long run, we need to make a note in Documentation/ABI/, and change it
sometime in the future (a couple of release cycles or even more).
This also happens when I was trying to delete the obsoltete

thanks,
rui

> Makes me wonder if there shouldn't be a rule that exploits must not
> be fixed if already exploited.
> 
> Guenter
> 
> > 
> > > 
> > > Anyway, sounds good to me. No one will use something that isn't
> > > there,
> > > and no one will realize that it could have been there, so I don't
> > > expect
> > > anyone to complain.
> > Yes, I agree.
> > 
> > thanks,
> > rui
> > 
