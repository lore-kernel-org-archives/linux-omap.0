From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Sun, 30 May 2010 16:28:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC3@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
	<4BFE9D7E.8020602@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
	<068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
	<4BFFC622.90904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
	<4BFFCB6B.50005@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>
	<1275065163.10319.5.camel@Nokia-N900-51-1>,<876327ewnz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33346 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab0E3K6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 May 2010 06:58:45 -0400
In-Reply-To: <876327ewnz.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Nishanth menon <menon.nishanth@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>

_______________________________________
From: Kevin Hilman [khilman@deeprootsystems.com]
Sent: Friday, May 28, 2010 11:27 PM
To: Nishanth menon
Cc: Premi, Sanjeev; Menon, Nishanth; Koen Kooi; linux-omap@vger.kernel.org; eduardo.valentin@nokia.com
Subject: Re: omap3 pm: dependency between opp layer and cpufreq

Nishanth menon <menon.nishanth@gmail.com> writes:

[...]

>> 'mpurate' is usually used when cpufreq is not required. It
>> means - set me up for the specified freq and forget it. There
>> is no further change needed/ possible.
>
> That opens up the question - why not use cpufreq with userspace
> governor instead?  Esp if u dont want a change in freq, ok i get the
> part where u'd like a single freq for the system to function at, but
> u also mention, mpurate is for systems that dont care abt any other
> dependencies. So, bit of a contradiction if it depends on scaling
> voltage to the right level aka u are selecting an freq from opp
> table.
>
> This in my mind means u shud modify mpurate to use opp layer aka
> another user beyond cpufreq.

>>
>> You could always argue that it can be done in u-boot; but this
>> bootarg helps people choose target freq keeping the u-boot same.
>
> Errr..... Makes me feel that u shud really be using cpufreq instead! Either way
> i am not completely convinced u shud be doing voltage scaling when using
> mpurate given ur description- if u are trying to write a new cpufreq layer, why
> not fix why cpufreq doesn't work for u and help the rest of us as well ;)

Personally, I'm not opposed to supporting mpurate= (with CPUfreq
disabled) as this would also have the benefit of allowing a smaller
kernel if you really don't want DVFS.

After getting he right voltage from the OPP layer, what interface are
you planning to use to actually scale the voltage?  SR?  new voltage
layer directly?

[sp] I plan to use the existing infra only. SR is again a config option. In the
current internal implementation SR is being used. But this leads to an "ugly"
hack where actual setting of mpurate is delayed until SR is initialized.

In other mail (in response to Nishanth) I suggested that dependency between
OPP layer and PMIC needs to be broken. If done sooner, i would try to avoid
using SR (as preference).

I haven't yet looked at new SR layer good enough to make clear yes/no
response. 

~sanjeev

Kevin
