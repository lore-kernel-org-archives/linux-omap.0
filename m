From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: HDMI on OMAP4460: clk rate mismatch warning
Date: Wed, 16 Apr 2014 18:11:13 +0200
Message-ID: <CAGhQ9Vx0RojsC=c8L_Dhg0u3uGRP3boiEtuq9XZPNMmEVtHWBg@mail.gmail.com>
References: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>
	<534E17B3.5050109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:38976 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422643AbaDPQLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 12:11:15 -0400
Received: by mail-lb0-f169.google.com with SMTP id q8so8538490lbi.28
        for <linux-omap@vger.kernel.org>; Wed, 16 Apr 2014 09:11:14 -0700 (PDT)
In-Reply-To: <534E17B3.5050109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

On 16 April 2014 07:40, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 15/04/14 20:36, Joachim Eastwood wrote:
>> Hello,
>>
>> I am trying to get HDMI work with DT on my VAR-STK-OM44 (4460) board.
>> But during kernel boot I get the following message:
>>
>> [ 0.953796] ------------[ cut here ]------------
>> [ 0.953826] WARNING: CPU: 0 PID: 1 at
>> drivers/video/omap2/dss/dss.c:483 dss_set_fck_rate+0x7c/0x8c()
>> [ 0.953826] clk rate mismatch: 153600000 != 170666666
>
> I have a fix (attached) for this in fbdev-fixes, which I'll probably be
> sending to Linus today. I couldn't send it in the main fbdev pull
> request, as it depended on clk driver changes. And it's not fatal, most
> likely things work fine even with the warning.

The warning disappeared after the patch. Thanks.
Feel free to add: Tested-By: Joachim Eastwood <manabian@gmail.com>


>> [ 0.954345] OMAP DSS rev 4.0
>> [ 0.956970] connector-hdmi connector.10: failed to find video source
>> [ 0.957031] connector-hdmi: probe of connector.10 failed with error -22
>> [ 0.959167] omapfb omapfb: no displays
>> [ 0.961547] omapfb omapfb: failed to setup omapfb
>> [ 0.961578] platform omapfb: Driver omapfb requests probe deferral
>
> Your DT data is not right. The shorter endpoint format you use is not
> supported. Have a look at arch/arm/boot/dts/omap4-panda-common.dtsi for
> an example.
>
> Also the HDMI driver does not currently work if the OMAP HDMI is
> directly connected to the HDMI connector. Panda and 4430 SDP boards use
> TPD12S015 chip in between. This should be fixed in the future, but at
> the moment you'll see problems if your board does not have that chip.

This board (VAR-STK-OM44) has a TPD12S521 which has no controllable
settings so adding a driver for it would be pretty meaningless. I
think it's the same situation with Gumstix Parlor. That board also
just have a very simple HDMI transmitter which shouldn't require a
driver.

But never the less I got HDMI working on my board adding the tpd21s015
nodes and providing a dummy gpio for "CT CP HPD". This works but it's
a bit hacky.

During boot I got this warning from the tpd12s015 driver:
[ 2.955444] WARNING: CPU: 0 PID: 16 at
drivers/video/omap2/displays-new/encoder-tpd12s015.c:87
tpd_connect+0xb8/0xc8()
[ 2.955444] Modules linked in:
[ 2.955444] CPU: 0 PID: 16 Comm: kworker/u4:1 Not tainted
3.15.0-rc1-00058-ge6c0e0fdf274-dirty #33
[ 2.979309] Workqueue: deferwq deferred_probe_work_func
[ 2.984863] [<c0014f48>] (unwind_backtrace) from [<c0011c2c>]
(show_stack+0x10/0x14)
[ 3.000427] [<c0011c2c>] (show_stack) from [<c05cb494>] (dump_stack+0x84/0x94)
[ 3.008087] [<c05cb494>] (dump_stack) from [<c0036ba8>]
(warn_slowpath_common+0x70/0x8c)
[ 3.016632] [<c0036ba8>] (warn_slowpath_common) from [<c0036c60>]
(warn_slowpath_null+0x1c/0x24)
[ 3.025878] [<c0036c60>] (warn_slowpath_null) from [<c02c8d30>]
(tpd_connect+0xb8/0xc8)
[ 3.034332] [<c02c8d30>] (tpd_connect) from [<c031f640>] (pdev_probe+0x40/0xdc)
[ 3.042053] [<c031f640>] (pdev_probe) from [<c0330474>]
(platform_drv_probe+0x18/0x48)
[ 3.042083] [<c0330474>] (platform_drv_probe) from [<c032ecf8>]
(driver_probe_device+0x124/0x240)
[ 3.059722] [<c032ecf8>] (driver_probe_device) from [<c032d370>]
(bus_for_each_drv+0x58/0x8c)
[ 3.068695] [<c032d370>] (bus_for_each_drv) from [<c032eba4>]
(device_attach+0x78/0x8c)
[ 3.077148] [<c032eba4>] (device_attach) from [<c032e22c>]
(bus_probe_device+0x88/0xac)
[ 3.085571] [<c032e22c>] (bus_probe_device) from [<c032e674>]
(deferred_probe_work_func+0x6c/0xa0)
[ 3.095031] [<c032e674>] (deferred_probe_work_func) from [<c004edb0>]
(process_one_work+0x1b0/0x4c4)
[ 3.095031] [<c004edb0>] (process_one_work) from [<c004fc74>]
(worker_thread+0x13c/0x3dc)
[ 3.113220] [<c004fc74>] (worker_thread) from [<c0055844>] (kthread+0xe0/0xf4)
[ 3.121032] [<c0055844>] (kthread) from [<c000e2c8>] (ret_from_fork+0x14/0x2c)
[ 3.128631] ---[ end trace 7cb21223a2b91cf6 ]---

One other thing.
Does HDMI audio work with DT or is that a still TODO?
I am only getting probe deferral's from omap-hdmi-audio. Haven't look
to far into it.

regards
Joachim Eastwood
