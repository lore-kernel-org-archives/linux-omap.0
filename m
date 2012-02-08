From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ASoC related suspend problems on OMAP3
Date: Wed, 08 Feb 2012 10:29:29 +0200
Message-ID: <4F323269.6090008@ti.com>
References: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41796 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755536Ab2BHI3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 03:29:30 -0500
Received: by lagk11 with SMTP id k11so277824lag.29
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 00:29:28 -0800 (PST)
In-Reply-To: <CANOLnOMhetqt0ZCCfS0UwnfE0DxLhLhK9=7t0BaQ1SUsv0OWjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

On 02/08/2012 02:34 AM, Grazvydas Ignotas wrote:
> Hi,
>=20
> On OMAP3 pandora, system suspend stops working properly after using
> audio at least once:
>=20
> (just after boot):
> # echo mem > /sys/power/state
> [   12.578186] PM: Entering mem sleep
> [   12.678802] PM: suspend of devices complete after 92.834 msecs
> [   12.688201] PM: late suspend of devices complete after 3.173 msecs
> [   17.607971] Successfully put all powerdomains to target state
>=20
> # aplay /dev/zero
> ^C
> # echo mem > /sys/power/state
> [  104.404663] PM: suspend of devices complete after 78.794 msecs
> [  104.413909] PM: late suspend of devices complete after 3.021 msecs
> [  106.601196] Powerdomain (per_pwrdm) didn't enter target state 1
> [  106.607421] Powerdomain (core_pwrdm) didn't enter target state 1
> [  106.613739] Could not enter target state in pm_suspend
>=20
> I'm seeing this on 3.2, unable to verify on current Linus HEAD as
> something else is preventing core/per low power states there.
> Any ideas what could be causing this? Perhaps some clock is left enab=
led?

I would bet that some clocks left enabled, but it as far as I can tell
the audio path is well balanced in regards of clocks.

So I'm not sure, but I just checked with 3.3-rc2 on Beagle xM (Rev C):

after boot:
# echo mem > /sys/power/state
[  163.776153] Freezing user space processes ...
[  163.804595] (elapsed 0.02 seconds) done.
[  163.808746] Freezing remaining freezable tasks ... (elapsed 0.02 sec=
onds)
[  163.837097] Suspending console(s) (use no_console_suspend to debug)
[  164.019042] PM: suspend of devices complete after 157.684 msecs
[  164.025115] PM: late suspend of devices complete after 6.011 msecs
[  164.025238] Disabling non-boot CPUs ...
[  172.497528] Successfully put all powerdomains to target state

aplay <some wav>

# echo mem > /sys/power/state
[  300.574920] Freezing user space processes ...
[  300.602874] (elapsed 0.02 seconds) done.
[  300.607025] Freezing remaining freezable tasks ... (elapsed 0.02 sec=
onds)
[  300.635620] Suspending console(s) (use no_console_suspend to debug)
[  300.809692] PM: suspend of devices complete after 149.810 msecs
[  300.814117] PM: late suspend of devices complete after 4.364 msecs
[  300.814147] Disabling non-boot CPUs ...
[  309.520721] Successfully put all powerdomains to target state

Here it seams to be OK...
You could try to compare the clock counts after boot, and after the apl=
ay:

cat /sys/kernel/debug/clock/summary

if they differ we leave have unbalanced clock handling...

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
