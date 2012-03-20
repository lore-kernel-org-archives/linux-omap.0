From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Date: Wed, 21 Mar 2012 01:06:46 +0200
Message-ID: <CAP245DXwhCMOJaspW8SY7jtqsA3d5SK4Ctr+JvS+cw4yHfL-mw@mail.gmail.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
	<201203202158.08042.arnd.bergmann@linaro.org>
	<873992zy5u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60494 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759367Ab2CTXGv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 19:06:51 -0400
Received: by wgbdr13 with SMTP id dr13so290970wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 16:06:50 -0700 (PDT)
In-Reply-To: <873992zy5u.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>, Robert Lee <rob.lee@linaro.org>, len.brown@intel.com, akpm@linux-foundation.org, rjw@sisk.pl, robherring2@gmail.com, Baohua.Song@csr.com, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Mar 21, 2012 at 12:48 AM, Kevin Hilman <khilman@ti.com> wrote:
> Arnd Bergmann <arnd.bergmann@linaro.org> writes:
>
>> On Tuesday 20 March 2012, Robert Lee wrote:
>>> This patch series moves various functionality duplicated in platfor=
m
>>> cpuidle drivers to the core cpuidle driver. Also, the platform irq
>>> disabling was removed as it appears that all calls into
>>> cpuidle_call_idle will have already called local_irq_disable().
>>>
>>> These changes have been pulled into linux-next.
>>>
>>> Len, Andrew, can a request be made for Linus to pull these changes?
>>
>> FWIW, Len seems to be rather inactive on the kernel mailing list rig=
ht
>> now and generally not very interested in anything outside of x86 and
>> acpi. If he doesn't reply in the next few days and Andrew also isn't
>> interested in handling these patches, I'd suggest you just send the =
pull
>> request to Linus, with Len on Cc and explain that you tried to send
>> them through him but gave up in the end.
>
> FWIW, I have not had good luck getting response for proposed core
> CPUidle changes either:
>
> =A0 =A0 =A0 =A0http://lkml.org/lkml/2011/9/19/374
>
> Maybe it's time that drivers/cpuidle gets a maintainer. =A0With lots =
of
> discussions of scheduler changes that affect load estimation, I suspe=
ct
> we're all going to have a bit of CPUidle work to do in the
> not-so-distant future.
>

I don't mean to be piling on to Len here, but Daniel Lezcano too has a
bunch of clean ups that didn't get any maintainer review for over two
months. He has now refreshed them for 3.3 and is getting ready to send
them out again. We (Linaro) expect to be spending a lot of time on
cpuidle in the future and would be glad to help review, test and
collect patches into a tree for Linus/Andrew to pull while we wait for
Len to respond or another maintainer to emerge.

/Amit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
