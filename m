From: "Kahn, Gery" <geryk@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Mon, 14 Feb 2011 17:35:36 +0200
Message-ID: <AANLkTinzjCD0UvgbwXGjzwY7JUyKESD_0FakLvm6UMJT@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
	<AANLkTinKFYHLSZBMxukb7dT6tenozmVHBm6JR4FCSbak@mail.gmail.com>
	<0a4ab0bfef880f12edb62915a3592104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53481 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753628Ab1BNPfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 10:35:43 -0500
Received: by mail-vx0-f177.google.com with SMTP id 2so2595720vxd.8
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 07:35:39 -0800 (PST)
In-Reply-To: <0a4ab0bfef880f12edb62915a3592104@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Vishwanath,

On Mon, Feb 14, 2011 at 14:49, Vishwanath Sripathy <vishwanath.bs@ti.com> wrote:
>>
>> I took those patches and applied to my .38-rc4 with help from Nishanth
>> Menon.
>>
>> There is problem appeared during compilation:
>>
>> arch/arm/plat-omap/cpu-omap.c:142: error: 'struct cpuinfo_arm' has no
>> member named 'loops_per_jiffy'
>>
>> My kernel is for Zoom3 board (OMAP3630-GP rev 2, CPU-OPP2 L3-
>> 200MHz)
>> Looking at the source, arch/arm/include/asm/cpu.h
>> loops_per_jiffy is under CONFIG_SMP and since the omap2plus_defconfig
>> builds for OMAP4 as well by default, I am guessing this bug was not
>> immediately visible...
>>
>> Is there solution for the issue?
> Yes this is an issue if CONFIG_SMP is disabled. We probably will need to
> put this code under #ifdef CONFIG_SMP till lpj is handled for SMP in
> generic cpufreq code itself .
>
I tried to go this way, but it doesn't help. It may demand additional changes.
> Vishwa
>>
>> Regards,
>> Gery
>
BTW,
i found that this patch provides CPU in 1GHz for omap36xx
is there solution for running omap36xx with 1.2GHz?

Gery
