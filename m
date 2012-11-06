From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Tue, 6 Nov 2012 10:27:54 +0100
Message-ID: <CAORVsuUm4zKoSaZQ0D=gf3toKHWznjfNvQ+q4=jsgkRaJXygMg@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
	<20121025101212.GD21217@arwen.pp.htv.fi>
	<20121026201539.GD29548@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
	<20121029200032.GD30152@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
	<20121030123254.GD29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
	<20121030125419.GG29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
	<CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
	<87fw4u3oh5.fsf@deeprootsystems.com>
	<CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
	<alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com>
	<CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com>
	<CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com>
	<alpine.DEB.2.00.1211050313130.23228@utopia.booyaka.com>
	<CAORVsuUGcydD13-VcaNjmAmrsyo9ZVHGTRoSKgLyr4-Bkw7zhg@mail.gmail.com>
	<87fw4neh0i.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39574 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2KFJ1z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 04:27:55 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so253211iea.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 01:27:54 -0800 (PST)
In-Reply-To: <87fw4neh0i.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Kevin, Paul,

On Tue, Nov 6, 2012 at 1:01 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
> [...]
>
>> I ran some intensive stress tests on the I2C and ... unfortunately I
>> could not trigger the problem. It looks like the issue is caused by
>> some transient situation where the CORE and/or I2C is in a low power
>> state.
>
> FYI... I just ran across what appears to be the same bug on 3430/n900
> during suspend/resume testing.  With CPUidle enabled, this happens every
> time.
>
> Reverting the I2C QoS patch makes it work again.

That makes sense with CPU_IDLE enabled and suspend. The cause of the
problem is that the cpuidle influences the MPU and CORE states,
depending on the constraints set and the latency figures for the power
domains (in arch/arm/mach-omap2/cpuidle34xx.c). Since the latency
numbers have not been updated to measured (i.e. realistic) values in
too-low power state is used, hence the timeout problem.

Note: that does not explain why the I2C timeout issue is present
without CPU_IDLE enabled, since in that case PM QoS should not have
any effect on the power domains states.

So yes the PM QoS I2C patch shall be reverted as long as the PM QoS
support for OMAP is not merged in.

For the records here are the patches that have been submitted to
support the OMAP PM QoS:
- func power states [1],
- OMAP PM QoS support [2], which includes the latency figures update
and which depends on [1],
- the conversion of I2C to PM QoS [3],
- the removal of the old no-op OMAP PM API [4], which depends on [3],

The chicken-and-egg problem is clearly visible since [3] depends on [2].

What to do now with those patches?
As said above [3] and [4] must be held until [1] and [2] are merged in.

[1] http://marc.info/?l=linux-arm-kernel&m=134744383120921&w=2
[2] http://marc.info/?l=linux-omap&m=134795835604288&w=2
[3] http://marc.info/?l=linux-omap&m=134815730108344&w=2
[4] http://marc.info/?l=linux-omap&m=134795836904299&w=2

> Kevin

Thanks for testing and reporting the issue.

Jean

>
>
> # rtcwake -m mem -s 1
> Date:    Fri Dec 31 17:00:34 MST 1999
> hwclock: Sat Jan  1 00:00:34 2000  0.000000 seconds
> [   38.819732] omap_i2c omap_i2c.1: timeout waiting for bus ready
> wakeup from "mem" at Sat Jan  1 00:00:36 2000
> [   38.841949] PM: Syncing filesystems ... done.
> [   38.859466] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   38.885284] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [   38.916412] Suspending console(s) (use no_console_suspend to debug)
> [   39.944274] omap_i2c omap_i2c.1: timeout waiting for bus ready
> [   39.944305] twl: i2c_read failed to transfer all messages
> [   39.944305] twl_rtc: Could not read TWLregister D - error -110
> [   39.944335] twl_rtc twl_rtc: twl_rtc_read_time: reading CTRL_REG, error -110
> [   40.975524] omap_i2c omap_i2c.1: timeout waiting for bus ready
> [   40.975555] twl: i2c_read failed to transfer all messages
> [   40.975555] VMMC2_IO_18: failed to disable
> [   40.978698] PM: suspend of devices complete after 2049.163 msecs
> [   40.984222] PM: late suspend of devices complete after 5.493 msecs
> [   40.992126] PM: noirq suspend of devices complete after 7.873 msecs
> [   40.992187] Disabling non-boot CPUs ...
> [   40.992675] Successfully put all powerdomains to target state
> [   40.997009] PM: noirq resume of devices complete after 4.058 msecs
> [   41.002014] PM: early resume of devices complete after 3.601 msecs
> [   41.179016] PM: resume of devices complete after 176.818 msecs
> [   41.277740] Restarting tasks ... done.
> real    0m 3.50s
> user    0m 0.00s
> sys     0m 0.10s
> Date:    Fri Dec 31 17:00:40 MST 1999
> hwclock: Sat Jan  1 00:00:40 2000  0.000000 seconds
