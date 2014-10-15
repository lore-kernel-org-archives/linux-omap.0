From: Pramod Gurav <pramod.gurav.etc@gmail.com>
Subject: Re: cpuidle and SW sleep
Date: Wed, 15 Oct 2014 16:08:04 +0530
Message-ID: <CAMf-jS=hkoDJa5vxp4kQmRLtrpquVavT+D1fM+w9OnSFc76t0w@mail.gmail.com>
References: <CAJ2oMh+W5vA96ftyRUA8V9fBx8xGA_26QkDt18A-j3+aw3TG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:55787 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaJOKiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 06:38:06 -0400
In-Reply-To: <CAJ2oMh+W5vA96ftyRUA8V9fBx8xGA_26QkDt18A-j3+aw3TG4Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org

On Wed, Oct 15, 2014 at 10:25 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> Hello,
>
> Is there anyone who can please explain the relation between SW sleep
> (such as udelay), to change of C-state as done by cpuidle ?

These are two different things, Ran.
udelay is a way to put simple delay between two functions. The cpu
will continue to perform other operations in a multithreded platform.

CPUIdle sleep states are mainly to achieve power saving by programming
cpus to difference states depending on how much time (estimated) a cpu
is going to be idle with algorithm. So each state will have latency
associated with it - enter, exit latency. If the cpu idle time falls
within any of C-state's latency that will be programmed. In different
state cpu will be programmed with different modes to achieve diff
power saving.

> How is wakeup done ? As far as I understand udelay is sw delay not HW.
System Wake up can be achieved by programming a wakeup source such as keypad.

>
> Thanks for you comments,
> Ran
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks and Regards
Pramod
