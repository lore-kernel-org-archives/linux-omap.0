From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Tue, 26 Jun 2012 15:27:19 +0530
Message-ID: <CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
	<CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	<1340632161.3395.100.camel@deskari>
	<CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	<1340695166.2093.22.camel@lappyti>
	<CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	<1340701660.24530.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65115 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab2FZJ5U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 05:57:20 -0400
Received: by lbbgm6 with SMTP id gm6so7787591lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 02:57:19 -0700 (PDT)
In-Reply-To: <1340701660.24530.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 26 June 2012 14:37, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-06-26 at 14:02 +0530, Jassi Brar wrote:
>
>> Something non-omapdss in vanilla breaks suspend/resume.
>
> I was able to reproduce (probably) the same issue with omap3 overo. D=
oes
> this looks familiar:
>
> [ 2267.140197] ------------[ cut here ]------------
> [ 2267.145172] WARNING: at drivers/video/omap2/dss/dispc.c:377 dispc_=
runtime_get+0x60/0x7c [omapdss]
> ()
> [ 2267.154846] Modules linked in: omapfb panel_generic_dpi omapdss cf=
bimgblt cfbfillrect cfbcopyarea
> =A0[last unloaded: omapdss]
> [ 2267.166595] [<c001b61c>] (unwind_backtrace+0x0/0xf0) from [<c00402=
38>] (warn_slowpath_common+0x4c
> /0x64)
> [ 2267.176605] [<c0040238>] (warn_slowpath_common+0x4c/0x64) from [<c=
004026c>] (warn_slowpath_null+0
> x1c/0x24)
> [ 2267.186859] [<c004026c>] (warn_slowpath_null+0x1c/0x24) from [<bf0=
d7918>] (dispc_runtime_get+0x60
> /0x7c [omapdss])
> [ 2267.197814] [<bf0d7918>] (dispc_runtime_get+0x60/0x7c [omapdss]) f=
rom [<bf0e3148>] (omapdss_dpi_d
> isplay_enable+0x48/0x230 [omapdss])
> [ 2267.210479] [<bf0e3148>] (omapdss_dpi_display_enable+0x48/0x230 [o=
mapdss]) from [<bf110034>] (gen
> eric_dpi_panel_check_timings+0x30/0x7c [panel_generic_dpi])
> [ 2267.225311] [<bf110034>] (generic_dpi_panel_check_timings+0x30/0x7=
c [panel_generic_dpi]) from [<b
> f11008c>] (generic_dpi_panel_resume+0xc/0x1c [panel_generic_dpi])
> [ 2267.240722] [<bf11008c>] (generic_dpi_panel_resume+0xc/0x1c [panel=
_generic_dpi]) from [<bf0de654>
> ] (dss_resume_device+0x28/0x40 [omapdss])
> [ 2267.253936] [<bf0de654>] (dss_resume_device+0x28/0x40 [omapdss]) f=
rom [<c02bfb94>] (bus_for_each_
> dev+0x50/0x7c)
> [ 2267.264678] [<c02bfb94>] (bus_for_each_dev+0x50/0x7c) from [<c02c2=
87c>] (platform_pm_resume+0x2c/
> 0x50)
> [ 2267.274566] [<c02c287c>] (platform_pm_resume+0x2c/0x50) from [<c02=
c6da8>] (dpm_run_callback.clone
> .7+0x30/0xb0)
> [ 2267.285186] [<c02c6da8>] (dpm_run_callback.clone.7+0x30/0xb0) from=
 [<c02c7b2c>] (device_resume+0x
> c8/0x188)
> [ 2267.295471] [<c02c7b2c>] (device_resume+0xc8/0x188) from [<c02c7f5=
4>] (dpm_resume+0xfc/0x21c)
> [ 2267.304534] [<c02c7f54>] (dpm_resume+0xfc/0x21c) from [<c02c8208>]=
 (dpm_resume_end+0xc/0x18)
> [ 2267.313507] [<c02c8208>] (dpm_resume_end+0xc/0x18) from [<c007fbcc=
>] (suspend_devices_and_enter+0
> x15c/0x2d0)
> [ 2267.323913] [<c007fbcc>] (suspend_devices_and_enter+0x15c/0x2d0) f=
rom [<c007fecc>] (pm_suspend+0x
> 18c/0x208)
> [ 2267.334259] [<c007fecc>] (pm_suspend+0x18c/0x208) from [<c007f170>=
] (state_store+0x120/0x134)
> [ 2267.343292] [<c007f170>] (state_store+0x120/0x134) from [<c0262850=
>] (kobj_attr_store+0x14/0x20)
> [ 2267.352661] [<c0262850>] (kobj_attr_store+0x14/0x20) from [<c0169b=
6c>] (sysfs_write_file+0x100/0x
> 184)
> [ 2267.362457] [<c0169b6c>] (sysfs_write_file+0x100/0x184) from [<c01=
09008>] (vfs_write+0xb4/0x148)
> [ 2267.371795] [<c0109008>] (vfs_write+0xb4/0x148) from [<c0109290>] =
(sys_write+0x40/0x70)
> [ 2267.380310] [<c0109290>] (sys_write+0x40/0x70) from [<c0013d60>] (=
ret_fast_syscall+0x0/0x3c)
> [ 2267.389282] ---[ end trace 54fe7eea726ac84d ]---
> [ 2267.394592] dpm_run_callback(): platform_pm_resume+0x0/0x50 return=
s -13
> [ 2267.401641] PM: Device omapdss failed to resume: error -13
>
Seems similar, but I only tested OMAP4 HDMI.
thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
