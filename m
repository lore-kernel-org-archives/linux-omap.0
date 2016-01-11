From: Guenter Roeck <linux@roeck-us.net>
Subject: arm qemu boot failures in -next due to 'PM / Domains: add setter for
 dev.pm_domain'
Date: Mon, 11 Jan 2016 09:51:06 -0800
Message-ID: <5693EB8A.40802@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I see 6 out of 24 arm qemu tests failing in next-20160111. Bisect points
to commit 989561de9b51 ("PM / Domains: add setter for dev.pm_domain").
Failures are silent - there is no output on the console.
Affected tests are

arm:beagle:multi_v7_defconfig:omap3-beagle
arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
arm:overo:multi_v7_defconfig:omap3-overo-tobi
arm:beagle:omap2plus_defconfig:omap3-beagle
arm:beaglexm:omap2plus_defconfig:omap3-beagle-xm
arm:overo:omap2plus_defconfig:omap3-overo-tobi

For details please see the 'next' column at http://server.roeck-us.net:8010/builders.

Reverting the offending commit fixes the problems.

Please let me know if there is anything I can do to help tracking down the problem.

Thanks,
Guenter

---
bisect log:

# bad: [bf976ab690dea9d0ee260fc8881fef511a0e3566] Add linux-next specific files for 20160111
# good: [168309855a7d1e16db751e9c647119fe2d2dc878] Linux 4.4-rc8
git bisect start 'HEAD' 'v4.4-rc8'
# bad: [a4fcd5c159c2b7a080f6c9fbefe8a85302390513] Merge remote-tracking branch 'crypto/master'
git bisect bad a4fcd5c159c2b7a080f6c9fbefe8a85302390513
# good: [9d242008d7c9e46327364a57793bada3509ebf0f] Merge remote-tracking branch 'hwmon-staging/hwmon-next'
git bisect good 9d242008d7c9e46327364a57793bada3509ebf0f
# good: [cc69d3dbbbfa134df2a7e7a72da6484c5d34fb0d] batman-adv: Change ifconfig examples to iproute2
git bisect good cc69d3dbbbfa134df2a7e7a72da6484c5d34fb0d
# bad: [995bfc729f919f2fe70e06d56aca3ffa90e0ebe6] Merge remote-tracking branch 'pm/linux-next'
git bisect bad 995bfc729f919f2fe70e06d56aca3ffa90e0ebe6
# good: [e27bc2ab8e774738b9c7c0356beab3a9ebdb3903] Merge ../mc_dvb into to_next
git bisect good e27bc2ab8e774738b9c7c0356beab3a9ebdb3903
# good: [f851f1f95258dd413ee6c09a889732d0a88c1b23] Merge branch 'pm-cpufreq' into linux-next
git bisect good f851f1f95258dd413ee6c09a889732d0a88c1b23
# good: [5bced7a1834aabf4ad348bbf59404ff45fdf569b] Merge branch 'kbuild/misc' into kbuild/for-next
git bisect good 5bced7a1834aabf4ad348bbf59404ff45fdf569b
# good: [44858e07ff879048f8f5cf315715ecc23d1a8462] Merge branch 'for-4.5' into for-next
git bisect good 44858e07ff879048f8f5cf315715ecc23d1a8462
# good: [e03445d23fdc32c167841b7dd9c3ff92c4b02d5d] Merge branch 'kbuild/misc' into kbuild/for-next
git bisect good e03445d23fdc32c167841b7dd9c3ff92c4b02d5d
# good: [31778c3c5abf4fb70c3465b072cd18f0a6e795f8] Merge branch 'powercap' into linux-next
git bisect good 31778c3c5abf4fb70c3465b072cd18f0a6e795f8
# bad: [e3345db85068ddb937fc0ba40dfc39c293dad977] USB / PM: Allow USB devices to remain runtime-suspended when sleeping
git bisect bad e3345db85068ddb937fc0ba40dfc39c293dad977
# good: [6b9cb42752dafba3761dde0002ca58ca518b6311] device core: add device_is_bound()
git bisect good 6b9cb42752dafba3761dde0002ca58ca518b6311
# bad: [aa8e54b559479d0cb7eb632ba443b8cacd20cd4b] PM / sleep: Go direct_complete if driver has no callbacks
git bisect bad aa8e54b559479d0cb7eb632ba443b8cacd20cd4b
# bad: [989561de9b5112999475b406557d9c7e9e59c041] PM / Domains: add setter for dev.pm_domain
git bisect bad 989561de9b5112999475b406557d9c7e9e59c041
# first bad commit: [989561de9b5112999475b406557d9c7e9e59c041] PM / Domains: add setter for dev.pm_domain
