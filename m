From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Mon, 25 Jun 2012 22:36:23 +0530
Message-ID: <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
	<CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	<1340632161.3395.100.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51920 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080Ab2FYRGZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 13:06:25 -0400
Received: by lbbgm6 with SMTP id gm6so6754504lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 10:06:23 -0700 (PDT)
In-Reply-To: <1340632161.3395.100.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 25 June 2012 19:19, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-06-25 at 19:01 +0530, Jassi Brar wrote:

>> > /* this accesses a register, but the HW is disabled? */
>> > dispc_read_reg(FOO);
>> >
>> .... the H/W is already always enabled if CONFIG_PM_RUNTIME is not d=
efined.
>>
>> If CONFIG_PM_RUNTIME is indeed defined, =A0pm_runtime_enabled() will
>> always return true after pm_runtime_enable() =A0unless someone disab=
les
>> it explicitly - omapdss or the RPM stack(during suspend/resume).
>> OMAPDSS never does so in the lifetime of a driver. =A0So the only pe=
riod
>> in which pm_runtime_enabled() returns false, is when the platform is
>> suspending, suspended or resuming.
>
> Right. So what happens in my example above?
>
> Normally if the driver does dispc_runtime_get() and dispc_read_reg(),
> the first call will enable the HW so the reg read works.
>
> But if the pm_runtime is disabled, say, during system suspend, with y=
our
> patch dispc_runtime_get() will just return 0 without doing anything, =
and
> the dispc_read_reg() will crash because the HW is disabled (because
> nobody enabled it).
>
Hmm, I am not sure if new calls would/should be made to dispc.c after
the system has suspended and before resumed. That is, anything other
than from runtime_resume/suspend callbacks of DSS, DISPC, HDMI, VENC
and RFBI, which rightly don't touch any dss reg but only
enable/disable a clock.
As we know, a subsystem should make sure any active work is cleared
out before suspending and set some flag so that nothing runs until it
has resumed. I don't say we can't crash the system with this patch,
but then we would be violating rules of suspend-resume.


>>
>> As I said, for omapdss, PM is disabled (not device deactivated) only
>> during rpm suspend/resume.
>> And it should be no different than any lock protected section
>> preempted by suspend-resume before reaching its end.
>
> I'm not sure if I understand... If the driver does dispc_runtime_get(=
)
> while the PM is disabled, say, during system resume, dispc_runtime_ge=
t()
> will do nothing and return 0. The driver thinks it succeeded, and wil=
l
> call dispc_runtime_put() later.
>
> Calling the dispc_runtime_put() could happen very soon, while runtime=
 PM
> is still disabled, in which case everything works fine. But there's n=
o
> rule to say dispc_runtime_put() has to be called very soon after
> dispc_runtime_get(). The driver might as well call put later, when
> runtime PM is enabled.
>
> This would end up with a pm_runtime_put call without a matching
> pm_runtime_get call.
>
Again, we need to see if there is really some situation where
something new is attempted before the subsystem has resumed. If there
is indeed, maybe omapdss need to flag it's suspended and prevent such
thing until it has resumed.
Btw, even without this patch, when dispc_runtime_get() does return
error under rpm disabled, we disturb the dev.power.usage_count balance
by not calling dispc_runtime_put()
This patch doesn't make everything perfect, but only improve upon the
current situation.

thnx
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
