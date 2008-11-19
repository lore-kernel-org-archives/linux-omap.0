From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states list
Date: Wed, 19 Nov 2008 14:08:29 -0800
Message-ID: <873ahnfjxe.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
	<20081106033327.GQ21736@atomide.com>
	<alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
	<87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.2.00.0811100741420.23090@utopia.booyaka.com>
	<87r65i66j5.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.2.00.0811121157530.28853@utopia.booyaka.com>
	<5e088bd90811191354g7d570338n40abe9523ee1a8cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:42932 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbYKSWIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 17:08:34 -0500
Received: by qyk4 with SMTP id 4so145772qyk.13
        for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 14:08:33 -0800 (PST)
In-Reply-To: <5e088bd90811191354g7d570338n40abe9523ee1a8cc@mail.gmail.com> (Steve Sakoman's message of "Wed\, 19 Nov 2008 13\:54\:09 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor (Nokia-D/Helsinki)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

"Steve Sakoman" <sakoman@gmail.com> writes:

> On Wed, Nov 12, 2008 at 11:07 AM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> Hi Jouni, Kevin,
>>
>> On Tue, 11 Nov 2008, H=F6gander Jouni wrote:
>>
>>> I wouldn't add any flags for this. The goal is finally to set all
>>> next_states as OFF until someone has set some constraint which
>>> prevents OFF usage. For now we need to use RET as default, because
>>> drivers are not supporting OFF mode. Do you agree this?
>>
>> Yes.
>>
>>> Easiest way here would be to add own hook for SGX in pwrdms_setup? =
One
>>> more strcmp("*_pwrdm, pwrdm->name) :)
>>>
>>> What do you think?
>>
>> That is okay with me.  This seems to be an unusual case - I guess it=
's due
>> to an SGX firmware bug.
>>
>> So Kevin, if you have a strong opposition to that strcmp, maybe we s=
hould
>> use a powerdomain flag for the SGX pwrdm.  Otherwise, let's go with =
a
>> strcmp as Jouni suggested.  Thoughts?
>
> Has there been a final resolution on this?
>
> I am unable to boot reliably on Overo with 2.6.28-rc5 -- almost every
> boot attempt gives me:
>
> Power Management for TI OMAP3.
> Unable to set state of powerdomain: sgx_pwrdm
> Failed to setup powerdomains
> omap2|3_pm_init failed: -22
>

Hi Steve,

Tony just pushed the final version[1] of the fix for this issue.
Please let me know if your problem still persists.

Kevin


[1] see commit 7a54b0f6f39ea1e5dbff6bb47314bea228bf6e44
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
