From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 06/10] OMAP: PM debug: Add PRCM register dump support
Date: Thu, 13 Aug 2009 15:28:45 -0700
Message-ID: <87iqgrcpr6.fsf@deeprootsystems.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
	<1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
	<1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
	<1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
	<1250182359-18830-5-git-send-email-khilman@deeprootsystems.com>
	<1250182359-18830-6-git-send-email-khilman@deeprootsystems.com>
	<1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
	<A24693684029E5489D1D202277BE89444A78397F@dlee02.ent.ti.com>
	<87eirfe6uo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87eirfe6uo.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> (Kevin Hilman's message of "Thu\, 13 Aug 2009 14\:34\:07 -0700")
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, "linux-arm@vger.kernel.org" <linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> writes:

> "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org> writes:
>
>> Kevin,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
>>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Kevin Hilman
>>> Sent: Thursday, August 13, 2009 11:53 AM
>>> To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org; linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tero Kristo
>>> Subject: [PATCH 06/10] OMAP: PM debug: Add PRCM register dump support
>>> 
>>> From: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>> 
>>> Allows dumping out current register contents from the debug filesystem,
>>> and
>>> also allows user to add arbitrary register save points into code. Current
>>> register contents are available under debugfs at:
>>> 
>>> [debugfs]/pm_debug/registers/current
>>> 
>>> To add a save point, do following:
>>> 
>>> From module init (or somewhere before the save call, called only once):
>>>   pm_dbg_init_regset(n); // n=1..4, allocates memory for dump area #n
>>> 
>>> From arbitrary code location:
>>>   pm_dbg_regset_save(n); // n=1..4, saves registers to dump area #n
>>> 
>>> After this, the register dump can be seen under
>>> [debugfs]/pm_debug/registers/n
>>> 
>>> Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>> ---
>>>  arch/arm/mach-omap2/pm-debug.c |  208
>>> ++++++++++++++++++++++++++++++++++++++++
>>>  arch/arm/mach-omap2/pm.h       |    4 +
>>>  2 files changed, 212 insertions(+), 0 deletions(-)
>>>  mode change 100644 => 100755 arch/arm/mach-omap2/pm-debug.c
>>>  mode change 100644 => 100755 arch/arm/mach-omap2/pm.h
>>
>> I guess these 755 mode changes weren't intentional... :)
>
> Indeed, they were not.  Thanks.
>

OK, fixed these locally but not worth a repost.  These will be updated in
the version pushed for pull request when reviewed/accepted.

Kevin



--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
