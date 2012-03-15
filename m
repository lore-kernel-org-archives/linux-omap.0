From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] cpufreq: OMAP updates for v3.4
Date: Thu, 15 Mar 2012 07:25:43 -0700
Message-ID: <87obryc55k.fsf@ti.com>
References: <87y5rci2na.fsf@ti.com>
	<CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
	<87wr6ngkrl.fsf@ti.com>
	<CANOLnON+hHtnjo9samAqvXp_nVJMjQ7CnxMCe7ggO4UwYaz4rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CANOLnON+hHtnjo9samAqvXp_nVJMjQ7CnxMCe7ggO4UwYaz4rw@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 14 Mar 2012 19:38:38 +0200")
Sender: cpufreq-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Wed, Mar 14, 2012 at 7:22 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>
>> [...]
>>
>>>> Russell King (1):
>>>> =C2=A0 =C2=A0 =C2=A0cpufreq: OMAP driver depends CPUfreq tables
>>>
>>> It seems this one got messed up, it says "default ARCH_OMAP2PLUS"
>>> instead of depends.
>>
>> That was intentional. =C2=A0What do you think is messed up about it?
>>
>> It's the same as saying:
>>
>> =C2=A0 =C2=A0 depends on ARCH_OMAP2PLUS
>> =C2=A0 =C2=A0 default y
>
> Hm, somehow I've never encountered this syntax, but it more looks lik=
e
> it means "default y if ARCH_OMAP2PLUS" instead of that.
>
> Checked this with menuconfig now:
>   default ARCH_OMAP2PLUS
> resolves to:
>   ARCH_HAS_CPUFREQ [=3Dy] && CPU_FREQ [=3Dy] && ARM [=3Dy]
>
> ..which might cause build break when OMAP is not selected, and
>
>   depends on ARCH_OMAP2PLUS
>   default y
> resolves to:
>   ARCH_HAS_CPUFREQ [=3Dy] && CPU_FREQ [=3Dy] && ARM [=3Dy] && ARCH_OM=
AP2PLUS [=3Dy]
>
> ..which should be randconfig friendly.

Yeah, you're right.  Feel free to send a patch using your comments abov=
e
to describe that the current form is not randconfig friendly.

Kevin
