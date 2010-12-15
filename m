From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: [PATCH v7] OMAP4:keypad: PM runtime
Date: Wed, 15 Dec 2010 19:33:21 +0530
Message-ID: <AANLkTimnq5Wa52vOvK0+WD_e=OFoQYXpzYf1H8BuJyER@mail.gmail.com>
References: <1292386198-3587-1-git-send-email-a0393217@india.ti.com>
	<20101215053146.GA1822@charu-comp>
	<AANLkTimaLQYGp4pasuuvj8Z7pKYHQ+L_VCJmeXu+EACQ@mail.gmail.com>
	<AANLkTinEoHySMos6X2PPAJLJJqRAGTo_dkwizRyJm-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <AANLkTinEoHySMos6X2PPAJLJJqRAGTo_dkwizRyJm-cA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Shubhrajyoti D <a0393217@india.ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 15, 2010 at 2:28 PM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
> Shubhro,
>
> On Wed, Dec 15, 2010 at 13:24, Datta, Shubhrajyoti <shubhrajyoti@ti.c=
om> wrote:
>> On Wed, Dec 15, 2010 at 11:01 AM, Varadarajan, Charulatha <charu@ti.=
com> wrote:
>>> * Shubhrajyoti D <a0393217@india.ti.com> [2010-12-15 09:39:58 +0530=
]:
>>>
>>>> From: Abraham Arce <x0066660@ti.com>
>>>>
>>>> Enable Runtime PM functionality in OMAP4 driver based on the follo=
wing assumptions
>>>>
>>>> A minimal pm runtime get/put approach is implemented in probe/remo=
ve calls
>>>> respectively.
>>>>
>>>> - Keyboard controller in wakeup domain so it is always on and
>>>> =A0 power impact may be minimal
>>>> - In OMAP4 the device control is at module/device level and ick/fc=
lk level control is
>>>> =A0 difficult so cutting of clocks will prevent interrupts.
>>>>
>>>> Signed-off-by: Abraham Arce <x0066660@ti.com>
>>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>
>>> This patch is sent thrice (once with a different subject) but the
>>> version numbers are the same. It is not clear what is the intention=
 of this
>>> patch without hwmod database update. Am I missing any more patch he=
re?
>> Yes missed the version.
>> =A0I have updated the change logs to be more descriptive and the sub=
ject line.
>>
>>
>> Regarding the hwmod database update. That I deffered for reasons
>> - The clock changes need to be there as the update would mean reset =
of clocks.
>> - Thought of completing the drivers/input before the hwmod database
>> and the board changes.
>> - Also currently the driver relies on the uboot settings for clock
>> this might remove that dependency.
>
> I wish to differ here. This patch would not fix the above issues beca=
use
> pm runtime APIs (for OMAP) purely rely on omap_device and the keypad
> driver is not yet hwmod adapted. Atleast put a dependency on any
> hwmod series if you had sent them before.
OK  will send a series with both patches mentioning the dependency.
>
> -V Charulatha
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
