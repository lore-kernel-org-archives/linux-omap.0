From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there is CAM domain ACTIVE
Date: Tue, 31 Jan 2012 09:23:36 -0800
Message-ID: <87r4yfokfb.fsf@ti.com>
References: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
	<CAORVsuWYvvZ_kp=9OTYMjDBibbsOSuBmkUU+u9mb_hKpL80d1Q@mail.gmail.com>
	<20120127140349.GE15297@valkosipuli.localdomain>
	<CAORVsuU+Gw5kAh13pgsxCH1B=q5Vs1QBwAfJ520p9AzkTyRjig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:52496 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1752803Ab2AaRXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 12:23:42 -0500
Received: by mail-bk0-f54.google.com with SMTP id zx1so323075bkb.27
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 09:23:41 -0800 (PST)
In-Reply-To: <CAORVsuU+Gw5kAh13pgsxCH1B=q5Vs1QBwAfJ520p9AzkTyRjig@mail.gmail.com>
	(Jean Pihet's message of "Tue, 31 Jan 2012 10:34:09 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin, Paul,
>
> On Fri, Jan 27, 2012 at 3:03 PM, Sakari Ailus <sakari.ailus@iki.fi> w=
rote:
>> Hi Jean,
>>
>> Thanks for you quick reply.
>>
>> On Fri, Jan 27, 2012 at 12:06:37PM +0100, Jean Pihet wrote:
>>> Hi,
>>>
>>> On Fri, Jan 27, 2012 at 11:00 AM, Sakari Ailus <sakari.ailus@iki.fi=
> wrote:
>>> > MPU and CORE should stay awake if there is CAM domain ACTIVE. Thi=
s is
>>> > because that module doesn't have wake-up capability.
>>> >
>>> > The original patch was written by Jouni H=C3=B6gander in 2008 and=
 this is the
>>> > last part left of it which is not in upstream yet.
>>> >
>>> > I wonder if the approach taken in the patch is valid these days;
>>> > nevertheless it seems to do the job...
>>> The code in the function omap3_enter_idle_bm from
>>> arch/arm/mach-omap2/cpuidle34xx.c is doing exactly the same thing: =
it
>>> is choosing the cpuidle safe_state if the CAM power domain is activ=
e.
>>>
>>> Please note that this only works if CPU_IDLE is selected, which is
>>> needed to reach any decent low power mode.
>>
>> I didn't have CONFIG_CPU_IDLE selected --- it works if I enable it. =
But
>> still it should work even if it's disabled I guess.
> What is your call on this?

We made a concious decision a while back to move any idle decision
making out of pm34xx.c and into the CPUidle driver.

Longer term, the goal is that CPUidle should not be handling this
either.  CPUidle is for the CPU, not for the rest of the devices.
Device constrataints should be handled by the device code itself.

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
