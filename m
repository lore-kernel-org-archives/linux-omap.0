From: Kevin Hilman <khilman@linaro.org>
Subject: Re: next boot: 36 pass, 3 fail (next-20140210)
Date: Mon, 10 Feb 2014 08:44:03 -0800
Message-ID: <7hwqh2apf0.fsf@paris.lan>
References: <52f8f712.626d440a.6fab.5ae1@mx.google.com>
	<CAGa+x84du+1Xcs=is+ehjvM3CGp9yT6jmBrgaeYx=-B0dXT3bA@mail.gmail.com>
	<52F8FF98.1090408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39979 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbaBJQoG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Feb 2014 11:44:06 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so6308770pde.14
        for <linux-omap@vger.kernel.org>; Mon, 10 Feb 2014 08:44:05 -0800 (PST)
In-Reply-To: <52F8FF98.1090408@ti.com> (Nishanth Menon's message of "Mon, 10
	Feb 2014 10:34:32 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> On 02/10/2014 10:33 AM, Kevin Hilman wrote:
>> +linux-omap list
>> 
>> On Mon, Feb 10, 2014 at 7:58 AM, Kevin's boot bot <khilman@linaro.org> wrote:
>>> Automated DT boot report for various ARM defconfigs.
>>>
>>>
>>> Tree/Branch: next
>>> Git describe: next-20140210
>>> Failed boot tests (console logs at the end)
>>> ===========================================
>>>              omap3-beagle-xm:     FAIL:    multi_v7_defconfig
>>>                   omap3-tobi:     FAIL:    multi_v7_defconfig
>>>               omap4-panda-es:     FAIL:    multi_v7_defconfig
>> 
>> These are all new OMAP failures, and appear to be an EHCI panic during
>> boot.  Note that omap2plus_defconfig boots fine on all these boards,
>> this failure is only for multi_v7_defconfig.
>> 
>> Not sure if anyone else has seen this yet.
>
> yep - reported and being looked here:
> http://marc.info/?t=139204803900004&r=1&w=2

Great, thanks.

Kevin
