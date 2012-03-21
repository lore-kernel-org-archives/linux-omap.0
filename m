From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
Date: Wed, 21 Mar 2012 10:46:34 +0100
Message-ID: <4F69A37A.7020606@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org> <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50810 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab2CUJqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 05:46:38 -0400
Received: by bkcik5 with SMTP id ik5so723963bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:46:37 -0700 (PDT)
In-Reply-To: <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On 03/21/2012 10:41 AM, Shilimkar, Santosh wrote:
> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> The 'valid' field is never used in the code, let's remove it.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
> It is used during the registration. This field has been very useful f=
or
> debug when need to disable a C-state etc.
> So unless and until there is a strong reason, i would like to retain =
it.

IMO if it used for debug purpose, it should be moved to the debug code=20
and if the debug code is not upstream, then that 'valid' should not be=20
here but in the out-of-tree code.

By the way, this may be a debate for nothing because a patchset is on=20
the way to disable C-states from sysfs.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
