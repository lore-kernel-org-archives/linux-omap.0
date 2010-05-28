From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: omap3 pm: dependency between opp layer and cpufreq
Date: Fri, 28 May 2010 10:57:52 -0700
Message-ID: <876327ewnz.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
	<4BFE9D7E.8020602@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
	<068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
	<4BFFC622.90904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
	<4BFFCB6B.50005@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>
	<1275065163.10319.5.camel@Nokia-N900-51-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:36203 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab0E1R56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 13:57:58 -0400
Received: by pzk42 with SMTP id 42so706345pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 28 May 2010 10:57:57 -0700 (PDT)
In-Reply-To: <1275065163.10319.5.camel@Nokia-N900-51-1> (Nishanth menon's message of "Fri\, 28 May 2010 18\:46\:03 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth menon <menon.nishanth@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, linux-omap@vger.kernel.org, eduardo.valentin@nokia.com

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

Kevin
