From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v7] OMAP4:keypad: PM runtime
Date: Wed, 15 Dec 2010 14:28:20 +0530
Message-ID: <AANLkTinEoHySMos6X2PPAJLJJqRAGTo_dkwizRyJm-cA@mail.gmail.com>
References: <1292386198-3587-1-git-send-email-a0393217@india.ti.com>
 <20101215053146.GA1822@charu-comp> <AANLkTimaLQYGp4pasuuvj8Z7pKYHQ+L_VCJmeXu+EACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44125 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871Ab0LOI7B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 03:59:01 -0500
In-Reply-To: <AANLkTimaLQYGp4pasuuvj8Z7pKYHQ+L_VCJmeXu+EACQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Shubhrajyoti D <a0393217@india.ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Shubhro,

On Wed, Dec 15, 2010 at 13:24, Datta, Shubhrajyoti <shubhrajyoti@ti.com=
> wrote:
> On Wed, Dec 15, 2010 at 11:01 AM, Varadarajan, Charulatha <charu@ti.c=
om> wrote:
>> * Shubhrajyoti D <a0393217@india.ti.com> [2010-12-15 09:39:58 +0530]=
:
>>
>>> From: Abraham Arce <x0066660@ti.com>
>>>
>>> Enable Runtime PM functionality in OMAP4 driver based on the follow=
ing assumptions
>>>
>>> A minimal pm runtime get/put approach is implemented in probe/remov=
e calls
>>> respectively.
>>>
>>> - Keyboard controller in wakeup domain so it is always on and
>>> =A0 power impact may be minimal
>>> - In OMAP4 the device control is at module/device level and ick/fcl=
k level control is
>>> =A0 difficult so cutting of clocks will prevent interrupts.
>>>
>>> Signed-off-by: Abraham Arce <x0066660@ti.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> This patch is sent thrice (once with a different subject) but the
>> version numbers are the same. It is not clear what is the intention =
of this
>> patch without hwmod database update. Am I missing any more patch her=
e?
> Yes missed the version.
> =A0I have updated the change logs to be more descriptive and the subj=
ect line.
>
>
> Regarding the hwmod database update. That I deffered for reasons
> - The clock changes need to be there as the update would mean reset o=
f clocks.
> - Thought of completing the drivers/input before the hwmod database
> and the board changes.
> - Also currently the driver relies on the uboot settings for clock
> this might remove that dependency.

I wish to differ here. This patch would not fix the above issues becaus=
e
pm runtime APIs (for OMAP) purely rely on omap_device and the keypad
driver is not yet hwmod adapted. Atleast put a dependency on any
hwmod series if you had sent them before.

-V Charulatha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
