From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Mon, 1 Apr 2013 14:28:20 -0500
Message-ID: <CAGo_u6ofjT_HyzdFNj3ByCbsyYzGU-LncUKo9=84BU3u6FK6Hw@mail.gmail.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
	<1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
	<20130328212739.13785.44736@quantum>
	<20130328223513.GA19470@kahuna>
	<51596725.9060109@ti.com>
	<20130401181057.8177.19688@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:34503 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab3DAT2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 15:28:21 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so2031194wea.10
        for <linux-omap@vger.kernel.org>; Mon, 01 Apr 2013 12:28:20 -0700 (PDT)
In-Reply-To: <20130401181057.8177.19688@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Tero Kristo <t-kristo@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

On Mon, Apr 1, 2013 at 1:10 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Andrii,
>
> Sorry to nitpick further but this your replies look very non-standard.
> Typically a right chevron and a space is used to indent replies instead
> of a tab.  Something like this:
> https://wiki.openstack.org/wiki/MailingListEtiquette#Reply_Level_Indication
>
> Quoting Andrii Tseglytskyi (2013-04-01 03:53:25)
>> In case if VC/VP use clock notifier to scale voltage, there is no guarantee of
>> order.
>> The only option which I see is to create ABB API and call it from OMAP
>> regulator during OPP change.
>>
>
> I doubt that is the only option.  Do you mean it is the only option to
> quickly get it working right now?
>
> The VC & VP code should be converted to the regulator framework if not
> already.  After that is done there are some options for how ABB is
> handled.
>
> The VC & VP regulator driver could directly call the api's you list
> below in their .set_voltage callback.
>
> Additionally if the regulator is reentrant then ABB could be modeled as
> a regulator itself and the VC or VP .set_voltage callback could perhaps
> call regulator_set_mode(abb_reg, FBB_MODE).
>
> Creating a regulator for each ABB instance may be overkill or may not be
> overkill... that IP has been around since 3630 so several chips use it.
>
>> omap_abb_pre_scale(struct omap_abb *abb, u32 old_volt, u32 new_volt);
>> omap_abb_post_scale(struct omap_abb *abb, u32 old_volt, u32 new_volt);
>>
>> Mike, do you agree to proceed in this way? Also I need you opinion about files
>> placement. Now it is placed in
>>
>
> The above code looks like a quick solution to me.  The long-term
> upstream path for this code needs be decided first.  If everything is
> going to get converted to the regulator framework then I do not agree to
> proceed that way.
>
> Let's figure out what is happening to the VC/VP code first and then
> figure out what to do about ABB.
>
http://picpaste.com/KmqDYTn0.jpg
is an quick depiction of the thought I have in my mind.

We do have, in the upcoming SoCs, where Nominal Voltages per device,
will now be encoded into the efuse itself(so called class 0 voltage).
Future SoCs will need to be able to use ABB along with standard
regulators (without use of VC-VP) - in fact, even today, SoCs like AM
and DM series of processors have the same requirement.

We also will have to support class 2 variants of AVS (which will use
standard regulators to set voltage).

As of date, CCF does not control regulators - which means the interim
solution would be for the device control to manipulate both clock and
regulator voltage (similar to what cpufreq-cpu0 driver does today).
these drivers should not know the existance of SoC specific
intricacies - so ABB linked to voltage values make more sense if ABB
sequencing is handled in "TI regulator"

Intent of VC/VP regulator is to be replaceable, on required platforms,
with appropriate regulator which do not use VC/VP paths (e.g. on SoCs
that do not have it).

There is also need to support multiple voltage rails supplied by a
single SMPS - in which case controlling via regulator framework is
more desirable.

---
Regards,
NIshanth Menon
