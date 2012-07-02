From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH RESEND] ARM: OMAP2+: Fix Wake-up power domain power status
Date: Mon, 2 Jul 2012 11:17:51 -0500
Message-ID: <4FF1C9AF.1040802@ti.com>
References: <1341003892-14424-1-git-send-email-jon-hunter@ti.com> <CAMQu2gxS8+xXUvAqMxcb3sq5dNinEXgtSphJh0TbfAX0uEGvhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42736 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2GBQSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 12:18:30 -0400
In-Reply-To: <CAMQu2gxS8+xXUvAqMxcb3sq5dNinEXgtSphJh0TbfAX0uEGvhg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>


On 06/29/2012 11:27 PM, Shilimkar, Santosh wrote:
> + Paul, Rajendra,
> 
> On Sat, Jun 30, 2012 at 2:34 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>> Note: Re-sending with updated kernel doc.
>>
>> The wake-up power domain is an alway-on power domain and so this power domain
>> does not have a power state status (PM_PWSTST_xxx) register that indicates the
>> current state. However, during the registering of the wake-up power domain the
>> state of the domain is queried by calling pwrdm_read_pwrst(). This actually
>> tries to read a register that does not exist and returns a value of 0 that
>> indicates that the current state is OFF. The OFF state count of the wake-up
>> power domain is then set to 1 and the current state to OFF. Both of which are
>> incorrect.
>>
>> To fix this, if a power domain only supports the ON state, do not attempt to
>> read the power state status register and simply return ON as the current power
>> state.
>>
>> This is based upon Tony's current linux-omap master branch.
>>
>> Testing:
>> - Boot tested on OMAP4460 panda.
>> - Boot tested on OMAP3430 beagle and validated CORE RET still working (using
>>  Paul's 32k timer patch [1]).
>>
>> [1] http://marc.info/?l=linux-omap&m=134000053229888&w=2
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  arch/arm/mach-omap2/powerdomain.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index eefe179..69b36e1 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -526,7 +526,8 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>>  *
>>  * Return the powerdomain @pwrdm's current power state.        Returns -EINVAL
>>  * if the powerdomain pointer is null or returns the current power state
>> - * upon success.
>> + * upon success. Note that if the power domain only supports the ON state
>> + * then just return ON as the current state.
>>  */
>>  int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>>  {
>> @@ -535,6 +536,9 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>>        if (!pwrdm)
>>                return -EINVAL;
>>
>> +       if (pwrdm->pwrsts == PWRSTS_ON)
>> +               return PWRDM_POWER_ON;
>> +
> The patch as such is correct but just wondering whether we should
> have some flag rather than above check.

I was wondering that too. I opted not to add a flag because there is
only one such power domain that needs it. However, I can add a flag if
it is preferred.

Cheers
Jon
