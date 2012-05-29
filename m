From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 10/11] omap4: thermal: add basic CPU thermal zone
Date: Tue, 29 May 2012 14:54:22 +0200
Message-ID: <4FC4C6FE.6070401@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-11-git-send-email-eduardo.valentin@ti.com> <CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com> <20120528094850.GS18918@arwen.pp.htv.fi> <CAGF5oy9Dwrasv3Hr_fkGg2N5uBei4tyRbZ+ADrEZ1FR-R_Q+0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46906 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab2E2Myc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 May 2012 08:54:32 -0400
In-Reply-To: <CAGF5oy9Dwrasv3Hr_fkGg2N5uBei4tyRbZ+ADrEZ1FR-R_Q+0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Cc: balbi@ti.com, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, kishon@ti.com, kbaidarov@dev.rtsoft.ru, tony@atomide.com, paul@pwsan.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

On 5/28/2012 12:26 PM, Valentin, Eduardo wrote:
> Hello Santosh,
>
> On Mon, May 28, 2012 at 12:48 PM, Felipe Balbi<balbi@ti.com>  wrote:
>> Hi,
>>
>> On Mon, May 28, 2012 at 03:03:26PM +0530, Shilimkar, Santosh wrote:
>>> On Fri, May 25, 2012 at 1:56 PM, Eduardo Valentin
>>> <eduardo.valentin@ti.com>  wrote:
>>>> This patch exposes OMAP4 thermal sensor as a thermal zone
>>>> named "cpu". Only thermal creation is done here.
>>>>
>>>> TODO:
>>>>
>>>>   - Add cooling bindings
>>>>   - Add extrapolation rules
>>>>
>>>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>>>> ---
>>>>   drivers/thermal/Kconfig         |   12 ++++++
>>>>   drivers/thermal/Makefile        |    1 +
>>>>   drivers/thermal/omap-bandgap.c  |    1 +
>>>>   drivers/thermal/omap-bandgap.h  |   12 ++++++
>>>>   drivers/thermal/omap4-thermal.c |   72 +++++++++++++++++++++++++++++++++++++++
>>>>   5 files changed, 98 insertions(+), 0 deletions(-)
>>>>   create mode 100644 drivers/thermal/omap4-thermal.c
>>>>
>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>> index ffdd240..2e82797 100644
>>>> --- a/drivers/thermal/Kconfig
>>>> +++ b/drivers/thermal/Kconfig
>>>> @@ -39,3 +39,15 @@ config OMAP_BANDGAP
>>>>           This includes alert interrupts generation and also the TSHUT
>>>>           support.
>>>>
>>>> +config OMAP4_THERMAL
>>>> +       bool "Texas Instruments OMAP4 thermal support"
>>>> +       depends on OMAP_BANDGAP
>>>> +       depends on ARCH_OMAP4
>>>> +       help
>>>> +         If you say yes here you get thermal support for the Texas Instruments
>>>> +         OMAP4 SoC family. The current chip supported are:
>>>> +          - OMAP4460
>>>> +
>>> It's more of IP feature than OMAP specific, so something like
>>>
>>> config  HAVE_BANDGAP_THERMAL_SUPPORT
>>>
>>> and then let processor's which support enable it. That OMAP varients
>>> in AMXX etc if needed can make use of it.
>>
>> Those are just an OMAP in disguise.
>>
>>> If you agree, then rest of the driver also can be cleaned to avoid
>>> omap_* in file names and variables.
>>>
>>> Apart from this minor comment, rest of the patch looks fine to me.
>>
>> Then it will appear as a fully generic bandgap driver, which is not the
>> case. This is really a TI thing, right ?
>
> I have to agree with Felipe here. I do see your point to have a name
> which is applicable to AMxx, but having such generic naming is not
> helping either :-( as this bandgap driver is not supposed to be
> generic.
>
> I though of "ti_bandgap.*", but still seams to be misleading..

Yeah, I guess omap_bandgap is good enough. This issues is mainly due to 
the version in OMAP4 for my point of view.

Benoit
