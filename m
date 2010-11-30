From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 6/7] [RFC] OMAP: hwmod: SYSCONFIG register modification
 for MCBSP
Date: Tue, 30 Nov 2010 17:03:16 +0100
Message-ID: <4CF52044.6040904@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>	<1286296662-7639-6-git-send-email-kishon@ti.com>	<4CAECB70.4030705@ti.com>	<4CB2AC44.6000804@ti.com>	<AANLkTi=a80MLvj5YuC==evfGqY6xUToHcBU3TyWEBHAo@mail.gmail.com> <AANLkTimExJBgLTfO2Q7zgohHquShvm9kP64=DLjQv21u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0K3QD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 11:03:26 -0500
In-Reply-To: <AANLkTimExJBgLTfO2Q7zgohHquShvm9kP64=DLjQv21u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>

Hi Kishon,

Sorry, for the delay.

On 11/22/2010 4:59 PM, ABRAHAM, KISHON VIJAY wrote:
> Resending the mail in plain text format..
>
> On Mon, Nov 22, 2010 at 9:20 PM, ABRAHAM, KISHON VIJAY<kishon@ti.com>  wrote:
>>
>> On Mon, Oct 11, 2010 at 11:48 AM, ABRAHAM, KISHON VIJAY<kishon@ti.com>  wrote:
>>>
>>> On Friday 08 October 2010 01:12 PM, Cousson, Benoit wrote:
>>>> Hi Kishon,
>>>>
>>>> On 10/5/2010 6:37 PM, ABRAHAM, KISHON VIJAY wrote:
>>>>> MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
>>>>> autoidle to be disabled before starting the sidetone. Also SYSCONFIG
>>>>> register has to be set with smart idle or no idle depending on the
>>>>> dma op mode (threshold or element sync). For doing these operations
>>>>> dynamically at runtime, hwmod API'S are used to modify SYSCONFIG
>>> register
>>>>> directly.
>>>>
>>>> OK, it looks like we don't have the choice... But for the
>>>> implementation, please discussed with Manju on that, He is doing the
>>>> similar thing for the smartstandby issue on SDMA.
>>>
>>>    OK.
>>
>>
>>        Looks like we have a problem when we write an API similar to the one written
>>        by Manju (omap_hwmod_set_master_standbymode()) [1]. In the case of McBSP,
>>        I have to modify omap_hwmod_set_slave_idlemode() (which is already existing),
>>        to include something like
>>
>>                          +    if (sf&  SYSC_HAS_SIDLEMODE) {
>>                          +        if (idlemode)
>>                          +            idlemode = HWMOD_IDLEMODE_NO;
>>                          +        else
>>                          +            idlemode = (oh->flags&  HWMOD_SWSUP_SIDLE) ?
>>                          +                HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>>                          +    }

How to you enable HWMOD_IDLEMODE_FORCE mode in that case?

>>        Then an API like omap_device_require_no_idle() and omap_device_release_no_idle()
>>        would be written similar to omap_device_require_no_mstandby and
>>        omap_device_release_no_mstandby() (see [1]) that calls
>>        omap_hwmod_set_slave_idlemode() with true/false. Passing true to
>>        omap_hwmod_set_slave_idlemode() will write SIDLE bits with
>>        HWMOD_IDLEMODE_NO and false to it will write
>>        HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART depending on
>>        HWMOD_SWSUP_SIDLE to SIDLE bits.
>>
>>        This works fine for McBSP since only two modes come to play here
>>        (HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART).
>>
>>        But omap_hwmod_set_slave_idlemode() API is used by UART
>>        (serial.c Please refer [2]) which writes SIDLE bits to
>>        HWMOD_IDLEMODE_NO/HWMOD_IDLEMODE_SMART/ and
>>        HWMOD_IDLEMODE_FORCE.

That code should not be there. It was a temporary hacks that should be 
replaced eventually with a clean omap_device API like the one you are 
currently implementing.
There are a bunch of direct access to omap_hwmod struct that need to be 
removed as well.

>>        Modifying omap_hwmod_set_slave_idlemode() will require
>>            1) serial.c to be modified to call functions like 'omap_device_require_no_idle(),
>>                omap_device_release_no_idle()' and 'omap_device_require_force_idle() and
>>                omap_device_release_force_idle()' instead of
>>                omap_hwmod_set_slave_idlemode() which is currently present.

Yep, you're right.

>>
>>        There are 2 problems associated with it
>>        1) The first problem is having a single API like omap_hwmod_set_slave_idlemode() to
>>            set two different values like HWMOD_IDLEMODE_NO or
>>            HWMOD_IDLEMODE_FORCE (intended to be called by omap_device_require_no_idle()
>>            and omap_device_require_force_idle() respectively). According to the new design
>>            omap_hwmod_set_slave_idlemode() is intended to take only true/false as
>>            arguments.
>>
>>        2) The second problem is having the release API's (omap_device_release_no_idle() and
>>             omap_device_release_force_idle()) to restore the SYSCONFIG to the previous state.
>>             Remember, this was not problem for McBSP since only two modes were needed.

And what about 3 APIs?

omap_device_force_idle
omap_device_no_idle
omap_device_smart_idle

It is probably much more appropriate than a require / release in that case?

Regards,
Benoit
