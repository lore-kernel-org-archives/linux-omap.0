From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Mon, 05 Nov 2012 16:01:33 -0800
Message-ID: <87fw4neh0i.fsf@deeprootsystems.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54447 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2KFABe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 19:01:34 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so4305583pad.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 16:01:33 -0800 (PST)
In-Reply-To: <CAORVsuUGcydD13-VcaNjmAmrsyo9ZVHGTRoSKgLyr4-Bkw7zhg@mail.gmail.com>
	(Jean Pihet's message of "Mon, 5 Nov 2012 10:26:27 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

> I ran some intensive stress tests on the I2C and ... unfortunately I
> could not trigger the problem. It looks like the issue is caused by
> some transient situation where the CORE and/or I2C is in a low power
> state.

FYI... I just ran across what appears to be the same bug on 3430/n900
during suspend/resume testing.  With CPUidle enabled, this happens every
time.

Reverting the I2C QoS patch makes it work again.

Kevin


# rtcwake -m mem -s 1
Date:    Fri Dec 31 17:00:34 MST 1999
hwclock: Sat Jan  1 00:00:34 2000  0.000000 seconds
[   38.819732] omap_i2c omap_i2c.1: timeout waiting for bus ready
wakeup from "mem" at Sat Jan  1 00:00:36 2000
[   38.841949] PM: Syncing filesystems ... done.
[   38.859466] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   38.885284] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   38.916412] Suspending console(s) (use no_console_suspend to debug)
[   39.944274] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   39.944305] twl: i2c_read failed to transfer all messages
[   39.944305] twl_rtc: Could not read TWLregister D - error -110
[   39.944335] twl_rtc twl_rtc: twl_rtc_read_time: reading CTRL_REG, error -110
[   40.975524] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   40.975555] twl: i2c_read failed to transfer all messages
[   40.975555] VMMC2_IO_18: failed to disable
[   40.978698] PM: suspend of devices complete after 2049.163 msecs
[   40.984222] PM: late suspend of devices complete after 5.493 msecs
[   40.992126] PM: noirq suspend of devices complete after 7.873 msecs
[   40.992187] Disabling non-boot CPUs ...
[   40.992675] Successfully put all powerdomains to target state
[   40.997009] PM: noirq resume of devices complete after 4.058 msecs
[   41.002014] PM: early resume of devices complete after 3.601 msecs
[   41.179016] PM: resume of devices complete after 176.818 msecs
[   41.277740] Restarting tasks ... done.
real    0m 3.50s
user    0m 0.00s
sys     0m 0.10s
Date:    Fri Dec 31 17:00:40 MST 1999
hwclock: Sat Jan  1 00:00:40 2000  0.000000 seconds
