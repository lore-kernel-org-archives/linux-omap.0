From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Mon, 23 Jan 2017 09:10:05 -0800
Message-ID: <20170123171005.GA23924@roeck-us.net>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170123144031.GA7870@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com, rui.zhang@intel.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2017 at 03:40:31PM +0100, Pavel Machek wrote:
> On Mon 2017-01-23 06:31:31, Guenter Roeck wrote:
> > On 01/23/2017 06:19 AM, Pavel Machek wrote:
> > >Hi!
> > >
> > >>It seems that battery driver stopped working on N900 between -rc4 and
> > >>-rc5.
> > >
> > >pavel@amd:/data/l/linux-n900$ git bisect log
> > ># bad: [41f283973653dc44af47585fa79fb6da6ffdc2e2] Merge
> > >/data//l/clean-cg into mini-v4.10
> > ># good: [4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185] It seems mainline
> > >-rc4 did have a fix for the sound issue. Use that one.
> > >git bisect start 'mini-v4.10'
> > >'4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185'
> > ># good: [e90665a5d38b17fdbe484a85fbba917a7006522d] Merge tag
> > >'ceph-for-4.10-rc5' of git://github.com/ceph/ceph-client
> > >git bisect good e90665a5d38b17fdbe484a85fbba917a7006522d
> > ># good: [83fd57a740bb19286959b3085eb93532f3e7ef2c] Merge tag
> > >'powerpc-4.10-2' of
> > >git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> > >git bisect good 83fd57a740bb19286959b3085eb93532f3e7ef2c
> > ># good: [c497f8d17246720afe680ea1a8fa6e48e75af852] Merge tag
> > >'usb-4.10-rc5' of
> > >git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> > >git bisect good c497f8d17246720afe680ea1a8fa6e48e75af852
> > ># bad: [bb6c01c2dde67b165cf7c808b0f00677b6f94b96] Merge branch
> > >'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
> > >git bisect bad bb6c01c2dde67b165cf7c808b0f00677b6f94b96
> > ># good: [18591add41ec9558ce0e32ef88626c18cc70c686] thermal: rockchip:
> > >handle set_trips without the trip points
> > >git bisect good 18591add41ec9558ce0e32ef88626c18cc70c686
> > ># bad: [f53345e8cf027d03187b9417f1f8883c516e1a5b] thermal: core: move
> > >tz->device.groups cleanup to thermal_release
> > >git bisect bad f53345e8cf027d03187b9417f1f8883c516e1a5b
> > ># bad: [7611fb68062f8d7f416f3272894d1edf7bbff29c] thermal:
> > >thermal_hwmon: Convert to hwmon_device_register_with_info()
> > >git bisect bad 7611fb68062f8d7f416f3272894d1edf7bbff29c
> > ># first bad commit: [7611fb68062f8d7f416f3272894d1edf7bbff29c]
> > >thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
> > >pavel@amd:/data/l/linux-n900$
> > >
> > >pavel@amd:/data/l/linux-n900$ git bisect log
> > ># bad: [41f283973653dc44af47585fa79fb6da6ffdc2e2] Merge
> > >/data//l/clean-cg into mini-v4.10
> > ># good: [4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185] It seems mainline
> > >-rc4 did have a fix for the sound issue. Use that one.
> > >git bisect start 'mini-v4.10'
> > >'4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185'
> > ># good: [e90665a5d38b17fdbe484a85fbba917a7006522d] Merge tag
> > >'ceph-for-4.10-rc5' of git://github.com/ceph/ceph-client
> > >git bisect good e90665a5d38b17fdbe484a85fbba917a7006522d
> > ># good: [83fd57a740bb19286959b3085eb93532f3e7ef2c] Merge tag
> > >'powerpc-4.10-2' of
> > >git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> > >git bisect good 83fd57a740bb19286959b3085eb93532f3e7ef2c
> > ># good: [c497f8d17246720afe680ea1a8fa6e48e75af852] Merge tag
> > >'usb-4.10-rc5' of
> > >git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> > >git bisect good c497f8d17246720afe680ea1a8fa6e48e75af852
> > ># bad: [bb6c01c2dde67b165cf7c808b0f00677b6f94b96] Merge branch
> > >'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
> > >git bisect bad bb6c01c2dde67b165cf7c808b0f00677b6f94b96
> > ># good: [18591add41ec9558ce0e32ef88626c18cc70c686] thermal: rockchip:
> > >handle set_trips without the trip points
> > >git bisect good 18591add41ec9558ce0e32ef88626c18cc70c686
> > ># bad: [f53345e8cf027d03187b9417f1f8883c516e1a5b] thermal: core: move
> > >tz->device.groups cleanup to thermal_release
> > >git bisect bad f53345e8cf027d03187b9417f1f8883c516e1a5b
> > ># bad: [7611fb68062f8d7f416f3272894d1edf7bbff29c] thermal:
> > >thermal_hwmon: Convert to hwmon_device_register_with_info()
> > >git bisect bad 7611fb68062f8d7f416f3272894d1edf7bbff29c
> > ># first bad commit: [7611fb68062f8d7f416f3272894d1edf7bbff29c]
> > >thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
> > >pavel@amd:/data/l/linux-n900$
> > >
> > >7611fb68062f8d7f416f3272894d1edf7bbff29c is the first bad commit
> > >commit 7611fb68062f8d7f416f3272894d1edf7bbff29c
> > >Author: Fabio Estevam <fabio.estevam@nxp.com>
> > >Date:   Tue Dec 27 15:31:49 2016 -0200
> > >
> > >    thermal: thermal_hwmon: Convert to
> > >    hwmon_device_register_with_info()
> > >
> > >    Booting Linux on a mx6q based board leads to the following
> > >    warning:
> > >
> > >    (NULL device *): hwmon_device_register() is deprecated. Please
> > >    convert the
> > >        driver to use hwmon_device_register_with_info().
> > >
> > >    ,so do as suggested.
> > >
> > >    Also, this results in the core taking care of creating the 'name'
> > >        attribute, so drop the code doing that from the thermal
> > >        driver.
> > >
> > > Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > >
> > >:040000 040000 b3f6095ab53677277c2f9d75cb6430afb6825765
> > >156a18e983a22b8ae43c7b312a4e1c63017f0e26 M	drivers
> > >
> > >I'll try to revert it on the top of v4.10-rc5 now... and yes, it fixes
> > >the issue.
> > >
> > >Any idea what went wrong and how to fix that?
> > >
> > >Anyway as we are at -rc5 and this is warning fix that caused a
> > >regression on different hardware... it should be reverted.
> > >
> > Agreed.
> > 
> > What exactly does "stopped working" mean ? That might help understanding
> > what went wrong.
> 
> /sys files related to battery no longer appear. I beieve this has
> something to do with it:
> 
> [    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' property
> of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
> [    2.375946] input: TSC2005 touchscreen as
> /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
> [    2.392120] rx51-battery: probe of n900-battery failed with error
> -22
> [    2.399902] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
> 

Only problem I can imagine is that power_supply_register() fails registering
the thermal zone, which in turn would suggest that the offending patch might
not work at all, at least not under some circumstances. So it should
definitely be reverted until we figure out the problem.

Guenter
