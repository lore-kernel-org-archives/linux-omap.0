From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 7/8] OMAP3: update cpuidle latency and threshold figures
Date: Wed, 12 Oct 2011 09:29:26 +0200
Message-ID: <CAORVsuXY637FCX9TuH4F3eLn4VOMBjP_n-kmMpAQs1Po_pFUMA@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316621649-3622-8-git-send-email-j-pihet@ti.com>
	<CACVXFVOj+S73Mk8C=Ct3tQTip-dbSHCd4M1Y8hJPCE8k=UqECA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56787 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab1JLH31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Oct 2011 03:29:27 -0400
Received: by vcbgb30 with SMTP id gb30so306593vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Oct 2011 00:29:26 -0700 (PDT)
In-Reply-To: <CACVXFVOj+S73Mk8C=Ct3tQTip-dbSHCd4M1Y8hJPCE8k=UqECA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Ming,

On Wed, Oct 12, 2011 at 4:48 AM, Ming Lei <tom.leiming@gmail.com> wrote=
:
> Hi,
>
> On Thu, Sep 22, 2011 at 12:14 AM, Jean Pihet <jean.pihet@newoldbits.c=
om> wrote:
>> Update the data from the measurements performed at HW and SW levels.
>>
>> Cf. http://www.omappedia.org/wiki/Power_Management_Device_Latencies_=
Measurement
>> for a detailed explanation on where are the numbers magically coming=
 from.
>>
>> ToDo:
>> - Measure the wake-up latencies for all power domains for OMAP3
>> - Correct some numbers when sys_clkreq and sys_offmode are supported
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 28 ++++++++++++++--------=
------
>> =A01 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index 1b8e0da..4b3e994 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -44,20 +44,20 @@
>> =A0* pass these details from the board file.
>> =A0*/
>> =A0static struct cpuidle_params cpuidle_params_table[] =3D {
>> - =A0 =A0 =A0 /* C1 */
>> - =A0 =A0 =A0 {2 + 2, 5, 1},
>> - =A0 =A0 =A0 /* C2 */
>> - =A0 =A0 =A0 {10 + 10, 30, 1},
>> - =A0 =A0 =A0 /* C3 */
>> - =A0 =A0 =A0 {50 + 50, 300, 1},
>> - =A0 =A0 =A0 /* C4 */
>> - =A0 =A0 =A0 {1500 + 1800, 4000, 1},
>> - =A0 =A0 =A0 /* C5 */
>> - =A0 =A0 =A0 {2500 + 7500, 12000, 1},
>> - =A0 =A0 =A0 /* C6 */
>> - =A0 =A0 =A0 {3000 + 8500, 15000, 1},
>> - =A0 =A0 =A0 /* C7 */
>> - =A0 =A0 =A0 {10000 + 30000, 300000, 1},
>> + =A0 =A0 =A0 /* C1 . MPU WFI + Core active */
>> + =A0 =A0 =A0 {73 + 78, 152, 1},
>> + =A0 =A0 =A0 /* C2 . MPU WFI + Core inactive */
>> + =A0 =A0 =A0 {165 + 88, 345, 1},
>> + =A0 =A0 =A0 /* C3 . MPU CSWR + Core inactive */
>> + =A0 =A0 =A0 {163 + 182, 345, 1},
>> + =A0 =A0 =A0 /* C4 . MPU OFF + Core inactive */
>> + =A0 =A0 =A0 {2852 + 605, 150000, 1},
>> + =A0 =A0 =A0 /* C5 . MPU RET + Core RET */
>> + =A0 =A0 =A0 {800 + 366, 2120, 1},
>
> C4 exit_latency is longer than C5's, not sure if it is correct?
Since MPU is OFF in C4 the impact is bigger in latency. In MPU OFF
mode the caches and MPU context are saved and later restored, which is
costly.

Thanks for the review!

Regards,
Jean

>
>> + =A0 =A0 =A0 /* C6 . MPU OFF + Core RET */
>> + =A0 =A0 =A0 {4080 + 801, 215000, 1},
>> + =A0 =A0 =A0 /* C7 . MPU OFF + Core OFF */
>> + =A0 =A0 =A0 {4300 + 13000, 215000, 1},
>> =A0};
>> =A0#define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
>>
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> thanks,
> --
> Ming Lei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
