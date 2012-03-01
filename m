From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] cpufreq: OMAP: specify range for voltage scaling
Date: Thu, 01 Mar 2012 14:07:51 -0800
Message-ID: <87d38wf008.fsf@ti.com>
References: <1330004964-22831-1-git-send-email-afzal@ti.com>
	<87fwdshyhk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:45162 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754706Ab2CAWHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 17:07:54 -0500
Received: by mail-pw0-f45.google.com with SMTP id uo5so231025pbc.18
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 14:07:52 -0800 (PST)
In-Reply-To: <87fwdshyhk.fsf@ti.com> (Kevin Hilman's message of "Thu, 01 Mar
	2012 12:12:23 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

+Tero

Kevin Hilman <khilman@ti.com> writes:

> Afzal Mohammed <afzal@ti.com> writes:
>
>> Specify voltage in ranges for regulator. Range
>> used is tolerance specified for OPP.
>>
>> This helps to achieve DVFS with a wider range of
>> regulators.
>>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>
> Thanks, will queue this with the CPUfreq changes for MPU DVFS.

Actually, not quite yet...

After some testing with the SMPS regulators, this won't quite work with
the current SMPS regulators.  Does this actually work with the
regulators you're using?

For OMAPs using VC/VP for voltage scaling, the TWL regulator passes on
the voltage requested directly to the voltage layer.  When using voltage
- tolerance, this results in voltages that the voltage layer doesn't
know about because they do not match any of the voltages from the known
OPPs.

The problem that we have is that while the regulators can support a
broad range of voltages (from min to max with a some step), the on-chip
voltage domains cannot, which is why we have defined the OPPs which are
known to work.

Tero, for the SMPS regulators, would it be possible to configure the
regulators so that only a discrete set voltages are availble to pick
from?  These should be initialied from the OPP layer.

Somehow we need to support something like $SUBJECT patch in order to
support a broad range of regulators.   The OMAP voltagedomain
limitations need to configured in platform specific way such that the
CPUfreq driver can remain generic.

Kevin

