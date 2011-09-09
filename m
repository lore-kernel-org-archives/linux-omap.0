From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 13/22] OMAP2+: voltage: keep track of powerdomains in each voltagedomain
Date: Fri, 09 Sep 2011 14:52:51 -0700
Message-ID: <87pqj9s7rg.fsf@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-14-git-send-email-khilman@ti.com>
	<CAORVsuU27kNiJAt-YRgfJ5i0=ZpfcDhNfY+kYK+AnKurDHDPfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:41667 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1IIVw5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 17:52:57 -0400
Received: by mail-yi0-f54.google.com with SMTP id 19so1944222yib.27
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 14:52:56 -0700 (PDT)
In-Reply-To: <CAORVsuU27kNiJAt-YRgfJ5i0=ZpfcDhNfY+kYK+AnKurDHDPfQ@mail.gmail.com>
	(Jean Pihet's message of "Wed, 7 Sep 2011 11:23:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
>> When a powerdomain is registered and it has an associated voltage do=
main,
>> add the powerdomain to the voltagedomain using voltdm_add_pwrdm().
>>
>> Also add voltagedomain iterator helper functions to iterate over all
>> registered voltagedomains and all powerdomains associated with a
>> voltagedomain.
>>
>> Modeled after a similar relationship between clockdomains and powerd=
omains.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/powerdomain.c | =C2=A0 =C2=A02 +
>> =C2=A0arch/arm/mach-omap2/powerdomain.h | =C2=A0 =C2=A02 +
>> =C2=A0arch/arm/mach-omap2/voltage.c =C2=A0 =C2=A0 | =C2=A0 80 ++++++=
+++++++++++++++++++++++++++++++
>> =C2=A0arch/arm/mach-omap2/voltage.h =C2=A0 =C2=A0 | =C2=A0 10 +++++
>> =C2=A04 files changed, 94 insertions(+), 0 deletions(-)
>>
> ...
>
>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/vol=
tage.h
>> index 966aa88..b41d9f1 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -19,6 +19,8 @@
>> =C2=A0#include "vc.h"
>> =C2=A0#include "vp.h"
>>
>> +struct powerdomain;
>> +
>> =C2=A0/* XXX document */
>> =C2=A0#define VOLTSCALE_VPFORCEUPDATE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01
>> =C2=A0#define VOLTSCALE_VCBYPASS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 2
>> @@ -55,12 +57,15 @@ struct omap_vfsm_instance_data {
>> =C2=A0* @name: Name of the voltage domain which can be used as a uni=
que identifier.
>> =C2=A0* @scalable: Whether or not this voltage domain is scalable
>> =C2=A0* @node: list_head linking all voltage domains
>> + * @pwrdm_node: list_head linking all powerdomains in this voltaged=
omain
>> =C2=A0* @vdd: to be removed
>> + * @pwrdms: powerdomains in this voltagedomain
>> =C2=A0*/
>> =C2=A0struct voltagedomain {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *name;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool scalable;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head node;
>> + =C2=A0 =C2=A0 =C2=A0 struct list_head pwrdm_list;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_vdd_info *vdd;
>> =C2=A0};
> The kerneldoc is not reflecting the code for struct voltagedomain.

hmm, looks like kerneldoc is out of sync in a few places.

Thanks for catching.  Will fixup.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
