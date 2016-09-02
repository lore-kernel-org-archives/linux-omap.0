From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add PM QoS support for
 McBSP to prevent glitches
Date: Fri, 2 Sep 2016 13:09:23 -0700
Message-ID: <20160902200922.getqf6xbiivvamj5@atomide.com>
References: <925ded57-1e91-3db6-9e82-3a3ff5775412@ti.com>
 <20160831141340.h24szdqjnicmt2ew@atomide.com>
 <20160831165959.3sldcjxaci3kdx6z@atomide.com>
 <eef88aa4-b829-1889-f083-eb0359c0dac6@ti.com>
 <20160831194107.wijnbmdns2jjvzkv@atomide.com>
 <5af44090-6902-2ade-be78-378843757a0a@ti.com>
 <20160901145006.xr3ux63cg6f5bh7p@atomide.com>
 <b3a254b2-948f-f04d-3289-fb8fb9f9ab23@ti.com>
 <20160902155437.GA4152@amd>
 <2ff0fe3b-d2a2-6186-1091-6aa802eb3596@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <2ff0fe3b-d2a2-6186-1091-6aa802eb3596@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160902 12:45]:
> On 09/02/2016 06:54 PM, Pavel Machek wrote:
> >>
> >> I wonder why we have not seen this before? I can not recall anything like this
> >> with n900 (Jarkko might know that better) neither with n9/n950. On the n9/n950
> >> I have even put the OMAP3 to OFF during audio playback with the
> > 
> > I was seeing something like that with 4.x kernel on Nokia N900.
> 
> So it must be possible to reproduce it on BeagleBoard-xm... I will try to get
> the PM working on it and let's see (hear).

Yeah you can do that quite easily with current mainline or next with
omap2plus_defconfig. Just use minimal modules and make sure *hci USB
kernel modules are not loaded. So root on MMC, not NFS. The same goes
for few other modules, at least hsi and isp used to block idle but I
have not checked the recent status for those.

Then just configure uart timeouts and enable off idle, see the script
below.

The playback test I use is just something like:

modprobe snd_soc_omap_mcbsp
modprobe snd_soc_twl4030
modprobe snd_soc_omap_twl4030
alsactl restore
watch -n5 grep core_pwrdm /sys/kernel/debug/pm_debug/count &
#mpg123 test.mp3
aplay test.wav
killall watch

Then you should see core_pwrdm ret counts increase during playback
after maybe 10 or 20 seconds into playing.

Note that I've been mostly using my torpedo board as it has smsc911x
on gpmc and allows off idle with NFSroot. Should be very similar
configuration as on beagleboard xm.

Regards,

Tony

8< ------------------
#!/bin/bash

uarts=$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
for uart in $uarts; do
	echo 3000 > $uart/autosuspend_delay_ms 2>&1
done

uarts=$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
for uart in $uarts; do
	echo enabled > $uart/wakeup 2>&1
	echo auto > $uart/control 2>&1
done

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
