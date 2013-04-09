From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL 2/5] omap pm clean-up for v3.10 merge window
Date: Tue, 09 Apr 2013 23:03:55 +0200
Message-ID: <5164823B.8070301@linaro.org>
References: <0MarPy-1U9XGk2D8s-00Ks1o@mx.kundenserver.de> <201304091652.28385.arnd@arndb.de> <87vc7virqz.fsf@linaro.org> <20130409165633.GN10155@atomide.com> <874nffip2d.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:52117 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936020Ab3DIVEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 17:04:00 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so7486737wgh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 14:03:59 -0700 (PDT)
In-Reply-To: <874nffip2d.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-arm-kernel@lists.infradead.org

On 04/09/2013 07:36 PM, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
>=20
>> * Kevin Hilman <khilman@linaro.org> [130409 09:43]:
>>> Arnd Bergmann <arnd@arndb.de> writes:
>>>
>>>> On Tuesday 09 April 2013, Tony Lindgren wrote:
>>>>> The following changes since commit 07961ac7c0ee8b546658717034fe69=
2fd12eefa9:
>>>>>
>>>>>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap=
 tags/omap-for-v3.10/cleanup-pm-signed
>>>>>
>>>>> for you to fetch changes up to ca8cdff548da76da01f3783548ceb91713=
9a5ddc:
>>>>>
>>>>>   Merge tag 'omap-pm-v3.10/cleanup/cpuidle' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-=
pm
>>>>> into omap-for-v3.10/cleanup-pm (2013-04-08 09:51:00 -0700)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>>
>>>>> PM cleanup to prepare for omap5 PM via Kevin Hilman <khilman@lina=
ro.org>:
>>>>>
>>>>> OMAP3/4 CPUidle cleanups for v3.10
>>>>
>>>> Adding Daniel and Rafael to Cc.

Kevin,

I just want to point you this patch:

https://git.linaro.org/gitweb?p=3Dpeople/dlezcano/cpuidle-next.git;a=3D=
commit;h=3De03a37fdf942a25154ccb5539524afd336f130bb

I did not yet send it to Rafael.


>>>> Is this series coordinated with the other cpuidle changes? Please =
tell me if this
>>>> is good to go into arm-soc.
>>>
>>> Hmm, looks like it's not ready.  There are some minor conflicts wit=
h
>>> what Rafael has queued up from Daniel.
>>>
>>> I will work this out with Daniel to figure out how we should procee=
d.
>>
>> OK it seems that this branch can also be queued by Rafael after
>> updating it if there's a dependency. So far it's not conflicting
>> with anything else we have queued up for arm soc tree.
>=20
> Right, I just did a test rebase onto the relevant commit in Rafael
> linux-next branch, and fixed up all the conflicts[1].
>=20
> If Rafael agrees, it's fine with me if it goes via him.
>=20
> Rafael, the signed tag for the updated branch is below[1], based on t=
he
> commit in your linux-next branch where you merged the rest of the
> CPUidle changes.  Let me know if you want a different base commit, or=
 an
> official pull request.
>=20
> Kevin
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-=
pm.git tags/omap-pm-v3.10/cleanup/cpuidle-v2



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
