From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL 2/5] omap pm clean-up for v3.10 merge window
Date: Tue, 09 Apr 2013 23:52:29 +0200
Message-ID: <51648D9D.5000204@linaro.org>
References: <0MarPy-1U9XGk2D8s-00Ks1o@mx.kundenserver.de> <201304091652.28385.arnd@arndb.de> <87vc7virqz.fsf@linaro.org> <20130409165633.GN10155@atomide.com> <874nffip2d.fsf@linaro.org> <5164823B.8070301@linaro.org> <87mwt71imz.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:45054 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936652Ab3DIVwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 17:52:34 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so7688198wgg.24
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 14:52:32 -0700 (PDT)
In-Reply-To: <87mwt71imz.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-arm-kernel@lists.infradead.org

On 04/09/2013 11:47 PM, Kevin Hilman wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>=20
> [...]
>=20
>>>>>>>
>>>>>>> PM cleanup to prepare for omap5 PM via Kevin Hilman <khilman@li=
naro.org>:
>>>>>>>
>>>>>>> OMAP3/4 CPUidle cleanups for v3.10
>>>>>>
>>>>>> Adding Daniel and Rafael to Cc.
>>
>> Kevin,
>>
>> I just want to point you this patch:
>>
>> https://git.linaro.org/gitweb?p=3Dpeople/dlezcano/cpuidle-next.git;a=
=3Dcommit;h=3De03a37fdf942a25154ccb5539524afd336f130bb
>>
>> I did not yet send it to Rafael.
>=20
> I haven't seen that one posted anywhere so it's not in my queue, and
> probably too late for v3.10.
>=20
> Once it's posted, I'll queue it up, and we can maybe get it in for
> v3.10-rc.

Yes, I just did the fix very recently. It was just a head up. I will
send it to Rafael as soon as the 'bleeding edge' branch is merged with
'linux-next'.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
