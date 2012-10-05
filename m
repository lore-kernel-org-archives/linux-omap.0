From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Fri, 5 Oct 2012 12:01:46 +0200
Message-ID: <CAAwP0s2HTZNYP2qNkqnus9veh1qXH-V3gDU_qBBxRR6o2W+=OA@mail.gmail.com>
References: <20120504155255.140b4e3f@skate> <87397fewso.fsf@ti.com>
 <20120504175124.GI5613@atomide.com> <878vh78q7b.fsf@ti.com>
 <20121004180747.3b342904@skate> <87vcequpf7.fsf@deeprootsystems.com>
 <20121004221118.4316181d@skate> <CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
 <20121004225704.0c08c862@skate> <87wqz5u97g.fsf@deeprootsystems.com>
 <CAAwP0s1+_GT=TtVKg8ARtfqDYm_AZ-D34KG_j3SLWz0yzZKJtQ@mail.gmail.com> <20121005101009.7ed1fe85@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43476 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227Ab2JEKCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 06:02:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1519612oag.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 03:02:06 -0700 (PDT)
In-Reply-To: <20121005101009.7ed1fe85@skate>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>

On Fri, Oct 5, 2012 at 10:10 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
>
> On Fri, 5 Oct 2012 09:32:07 +0200, Javier Martinez Canillas wrote:
>
>> As Enric said, u-boot has SPL and NAND support for IGEP since
>> v2012.10-rc1. I just tried kernel a 3.6 with u-boot v2012.10-rc2 and
>> it works for me.
>
> Ok, I'll try this out.
>
>> But I agree that the kernel shouldn't do any assumptions about the
>> bootloader setting correctly the omap mux. Could you please share your
>> bootloader that makes the kernel to fail (or your IGEP NAND patches on
>> top of u-boot U-boot 2011.12) so I can reproduce the issue and try to
>> fix it?
>
> Ok, I'm using the X-Loader from git://git.igep.es/pub/scm/x-loader.git,
> tag v1.4.4-3, on top of which I apply
> http://git.free-electrons.com/training-materials/plain/lab-data/sysdev/u-boot/x-loader-1.4.4-3-igep-nand-support.patch
> to add support for the NAND-based IGEPv2 rev6.
>
> In terms of U-Boot, I use U-Boot 2011.12, on top of which I apply
> http://git.free-electrons.com/training-materials/plain/lab-data/sysdev/u-boot/u-boot-2011.12-igep-nand-support.patch
> to add support for the NAND-based IGEPv2 rev6.
>
> To make things easier if you don't need to rebuild those, I've put
> online pre-built binaries of X-Loader and U-Boot I'm using:
> http://free-electrons.com/~thomas/pub/igep-serial-problem/.
>
> Thanks,
>
> Thomas

Perfect, I'll try it and let you know if I find a fix for the issue.

Thanks a lot!
Javier
