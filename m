From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Wed, 30 May 2012 21:15:26 +0200
Message-ID: <4FC671CE.6040807@linaro.org>
References: <1336644177-13834-1-git-send-email-daniel.lezcano@linaro.org> <4FB08D24.7070101@ti.com> <4FC59CDD.1030100@linaro.org> <87pq9l8ruv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54962 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab2E3TPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 May 2012 15:15:31 -0400
Received: by dady13 with SMTP id y13so193226dad.19
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 12:15:30 -0700 (PDT)
In-Reply-To: <87pq9l8ruv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On 05/30/2012 08:07 PM, Kevin Hilman wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>=20
>> On 05/14/2012 06:42 AM, Rajendra Nayak wrote:
>>> On Thursday 10 May 2012 03:32 PM, Daniel Lezcano wrote:
>>>> The current Makefile compiles the cpuidle34xx.c and cpuidle44xx.c =
files
>>>> even if the cpuidle option is not set in the kernel.
>>>>
>>>> This patch fixes this by creating a section in the Makefile where =
these
>>>> files are compiled only if the CONFIG_CPU_IDLE option is set.
>>>>
>>>> This modification breaks an implicit dependency between CPU_IDLE a=
nd
>>>> PM as
>>>> they belong to the same block in the Makefile. This is fixed in th=
e
>>>> Kconfig
>>>> by selecting explicitely PM is CPU_IDLE is set.
>>>>
>>>> The linux coding style recommend to use no-op functions in the hea=
ders
>>>> when the subsystem is disabled instead of adding big section in C =
files.
>>>
>>> Looks good to me.
>>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
>>
>> Hi Kevin,
>>
>> I think I addressed all the points. Is it possible to consider this
>> patch for inclusion ?
>>
>=20
> Yes.  I'll queue up as a cleanup for v3.6 with the reviewed-by from
> Rajendra.

Cool !

Thanks
  -- Daniel

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
