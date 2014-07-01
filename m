From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 0/6] regulator: palmas: cleanup and fixes
Date: Tue, 1 Jul 2014 10:44:03 +0530
Message-ID: <53B2439B.7060001@ti.com>
References: <1404143859-8160-1-git-send-email-nm@ti.com> <53B1C6EC.7070907@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53B1C6EC.7070907-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 July 2014 01:52 AM, Stephen Warren wrote:
> On 06/30/2014 09:57 AM, Nishanth Menon wrote:
>> Hi,
>> 	Original thread (v1): http://marc.info/?t=140380766500004&r=1&w=2
>> This series is based on: git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
>> branch: topic/palmas (4c0c9ca Merge remote-tracking branch 'regulator/fix/palmas' into regulator-palmas)
>>
>> This series does a few cleanups to help ensure we dont make typo mistakes and finally provides a fix as attempted by (v1).
>>
>> Basic cpufreq tests performed on OMAP5uEVM, DRA7-evm, DRA72-evm all of which are palmas variants.
>>
>> The patches are also available here: https://github.com/nmenon/linux-2.6-playground/commits/broonie-topic-palmas-fixes
> The series,
> Tested-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> (An NVIDIA Dalmore board boots and shuts down OK with these applied on
> top of next-20140630, and various peripherals such as LCD panel, audio,
> USB, and SPI flash all work)
Tested the series on DRA72 board. Checked for all the regulator
and SMPS states and voltages of TPS65917 PMIC.

Tested-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Regards,
Keerthy
