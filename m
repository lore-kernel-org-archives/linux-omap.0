From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Tue, 26 Jun 2012 22:31:28 +0530
Message-ID: <CAJe_ZheXSquxOtOD9iPyQjZ-jxWKzVGZHYkjM=wC37qgMZeJug@mail.gmail.com>
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
	<CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	<1340712213.24530.21.camel@deskari>
	<CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
	<1340723296.24530.68.camel@deskari>
	<CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
	<1340723514.24530.70.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36791 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809Ab2FZRBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 13:01:31 -0400
Received: by lbbgm6 with SMTP id gm6so329703lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 10:01:29 -0700 (PDT)
In-Reply-To: <1340723514.24530.70.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 26 June 2012 20:41, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-06-26 at 20:39 +0530, Jassi Brar wrote:
>> On 26 June 2012 20:38, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > On Tue, 2012-06-26 at 20:19 +0530, Jassi Brar wrote:
>> >> On 26 June 2012 17:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> >> > On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:
>> >> >
>> >> >> Seems similar, but I only tested OMAP4 HDMI.
>> >> >
>> >> > Would something like this one below work for you? It fixes the issues on
>> >> > my overo board.
>> >> >
>> >> I think this should work too (I will get to test it only tomorrow).
>> >>
>> >> Though I don't think it'll fix stack spew when run without
>> >> CONFIG_PM_RUNTIME. Maybe we could simply remove the WARN_ON in the
>> >> xxx_runtime_put() as Alan noted?
>> >
>> > Yes, that's a different issue. I'll look at that also.
>> >
>> Well, my patch took care of that also. But I agree, that could be
>> added separately as well.
>
> Well, I don't agree that your patch is correct =). I don't think it's
> right to skip runtime get and put when pm_runtime_enabled() returns
> false.
>
While I think your patch is simpler and achieve the same, I also think
your fears about this patch are unfounded.

A quick snack for thought...
>
> But if pm_runtime_get_sync() returns an error, it means the HW has not
> been resumed successfully, and is not operational,
>
Not always. The HW could be in RPM_ACTIVE state while PM on it could
be disabled, if the returned error is -EACCESS.   And
pm_runtime_enabled() only catches a potential -EACCESS.


BTW, I just tested your patch and it worked for me as well. But as
suspected, it doesn't help the stack spew of CONFIG_PM_RUNTIME:=n

So I understand, I only need to resend the other three patches ?

Thanks.
