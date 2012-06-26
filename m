From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Tue, 26 Jun 2012 14:02:16 +0530
Message-ID: <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53154 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758476Ab2FZIcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 04:32:18 -0400
Received: by lbbgm6 with SMTP id gm6so7695937lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 01:32:16 -0700 (PDT)
In-Reply-To: <1340695166.2093.22.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 26 June 2012 12:49, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-25 at 22:36 +0530, Jassi Brar wrote:

>> >
>> > Normally if the driver does dispc_runtime_get() and dispc_read_reg(),
>> > the first call will enable the HW so the reg read works.
>> >
>> > But if the pm_runtime is disabled, say, during system suspend, with your
>> > patch dispc_runtime_get() will just return 0 without doing anything, and
>> > the dispc_read_reg() will crash because the HW is disabled (because
>> > nobody enabled it).
>> >
>> Hmm, I am not sure if new calls would/should be made to dispc.c after
>> the system has suspended and before resumed. That is, anything other
>> than from runtime_resume/suspend callbacks of DSS, DISPC, HDMI, VENC
>> and RFBI, which rightly don't touch any dss reg but only
>> enable/disable a clock.
>
> They do touch the registers. For example, dispc's callbacks save and
> restore the registers. The HW should be fully functional during the
> callbacks. The point of the callbacks is to suspend/resume the HW in
> question, which of course requires accessing the HW.
>
DISPC being held by HDMI, VENC and RFBI would be the last to suspend
and first to resume. And it won't have its registers touched between
dispc_runtime_suspend() and dispc_runtime_resume(), which seems ok to
me (?)
HDMI, VENC and RFBI directly fooling around with DISPC regs would have
been a problem, which isn't the case.

>> As we know, a subsystem should make sure any active work is cleared
>> out before suspending and set some flag so that nothing runs until it
>> has resumed. I don't say we can't crash the system with this patch,
>> but then we would be violating rules of suspend-resume.
>
> Let's go back a bit. I feel like I'm missing some pieces of information,
> as I still don't quite grasp the problem.
>
> In the patch you said this fixes an issue with HDMI. Can you tell more
> about the problem? What code path is being run? Any error messages?
>
> I tried system suspend with omap4-sdp and panda, with 3.5-rc2, but
> neither board seems to wake up from the suspend. Does it work for you?
>
Something non-omapdss in vanilla breaks suspend/resume.
Without this patch I see the upstream's display broken after the
suspend attempt.
    $ echo mem > /sys/power/state

I work on TILT tree, which has suspend/resume working after some more
local patches.
    http://git.linaro.org/gitweb?p=people/andygreen/kernel-tilt.git;a=shortlog;h=refs/heads/tilt-3.4

I don't have SDP so not sure, but it should simply be testable with
Panda4460 and the omap4plus_defconfig there.  Please feel free to ask
if you have any issue checking that out.

Thanks.
