From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH PM 1/2] OMAP McSPI: Fix context save/restore
Date: Thu, 05 Feb 2009 16:50:45 +0200
Message-ID: <87eiydhr96.fsf@trdhcp146196.ntc.nokia.com>
References: <498AC802.8040302@nokia.com>
	<1233832029-21614-1-git-send-email-Aaro.Koskinen@nokia.com>
	<56834.10.24.255.18.1233834716.squirrel@dbdmail.itg.ti.com>
	<87ocxh6jpq.fsf@deeprootsystems.com>
	<01de01c9879f$905ec6d0$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38388 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZBEOsn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 09:48:43 -0500
In-Reply-To: <01de01c9879f$905ec6d0$LocalHost@wipultra793> (ext Hemanth V.'s
	message of "Thu, 5 Feb 2009 15:39:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hemanth V <hemanthv@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Hemanth V <hemanthv@ti.com> writes:

> ----- Original Message -----
> From: "Kevin Hilman" <khilman@deeprootsystems.com>
> To: "Hemanth V" <hemanthv@ti.com>
> Cc: "Aaro Koskinen" <Aaro.Koskinen@nokia.com>; <linux-omap@vger.kerne=
l.org>
> Sent: Thursday, February 05, 2009 7:59 PM
> Subject: Re: [PATCH PM 1/2] OMAP McSPI: Fix context save/restore
>
>
>> "Hemanth V" <hemanthv@ti.com> writes:
>>
>>>> Fix context save/restore to work with chip select. Also update the
>>>> shadow
>>>> CHCONF0 register on every write and eliminate register reads.
>>>
>>> I believe the shadow CHCONF register need to have only the default
>>> configuration as initialized by omap2_mcspi_setup_transfer(), since=
 other
>>> other
>>> bits are initialized as and when required by omap2_mcspi_work().
>>>
>>> The original problem you saw might be because of not masking
>>> OMAP2_MCSPI_CHCONF_TRM_MASK and OMAP2_MCSPI_CHCONF_FORCE bits while
>>> storing to
>>> shadow register.
>>
>> Hemanth,
>>
>> Can you address this problem and post a single patch with the full
>> save/restore.
>>
>> I have reverted the original patch in the pm branch and would like
>> to see a single patch including the fixes from Jouni and Aaro.
>
> Kevin,
>
> Both fixes cannot be taken since they are conflicting, I would like
> to go with Jouni's fix.

Bad thing in that one is that it doesn't work:)

Kevin, to my understanding patches from Aaro Koskinen are working. If
they are ok to you, please push them. So the patches are:

[PATCH PM 0/2] OMAP McSPI: Fixes to save/restore
[PATCH PM 1/2] OMAP McSPI: Fix context save/restore
[PATCH PM 2/2] OMAP McSPI: spin_unlock_irq() missing

and the sender is Koskinen Aaro. Those patches are working alone.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
