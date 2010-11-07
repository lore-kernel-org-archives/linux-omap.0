From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
Date: Sun, 7 Nov 2010 10:18:47 -0600
Message-ID: <AANLkTim=5bgGo1cnkWJCPF4HmMnQrBhP_sPCK3rRKUPS@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-4-git-send-email-omar.ramirez@ti.com>
	<4CD5BEFF.40301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:56121 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753368Ab0KGQSs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 11:18:48 -0500
Received: by iwn5 with SMTP id 5so5052166iwn.1
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 08:18:48 -0800 (PST)
In-Reply-To: <4CD5BEFF.40301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 3:47 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> Add mmu hwmod data for ducati and tesla.
>
> s/ducati/ipu/
> s/tesla/dsp/
>
> Please do not use internal codename.

Tried to avoid confusion with what was originally in the driver, agree
with the change.

> Here again, you completely changed the omap4 existing data for (almos=
t)
> nothing.
>
> I agree, the original code was not considering the mmu as a hwmod but=
 only
> the core of the subsystem: mmu + cache.
>
> But as far as I can see, you just added a new mmu class, a dev_attr, =
and the
> hwmod remain almost the same.
> Otherwise, you replaced the proper names by the bad one, and you remo=
ved
> important data (hw reset for ex).
>
> Please start from the original code and fix what is missing or wrong =
but do
> not re-write everything.

I wrote this one from scratch, I didn't see that there were pieces to
handle some stuff since the code is buried in a private tree.

I cared to dug up the mailbox one, but completely missed this one.

>> +/* mmu */
>> +
>> +static struct omap_hwmod_class omap44xx_mmu_hwmod_class =3D {
>> + =A0 =A0 =A0 .name =3D "mmu",
>> +};
>
> That change is OK. The remaining part seems to be completely broken.
>
>> +
>> +/* ducati mmu */
>> +
>> +static struct omap_hwmod omap44xx_ducati_mmu_hwmod;
>> +
>> +static struct omap_hwmod_addr_space omap44xx_ducati_mmu_addrs[] =3D=
 {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D OMAP4_MMU1_B=
ASE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D OMAP4_MMU1=
_BASE + SZ_4K - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D ADDR_TYP=
E_RT,
>> + =A0 =A0 =A0 },
>> +};
>> +
>> +/* l3_main_1 -> =A0ducati mmu */
>> +static struct omap_hwmod_ocp_if omap44xx_l3_main_1__ducati_mmu =3D =
{
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap44xx_l3_main_1_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap44xx_ducati_mmu_hwmo=
d,
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_ducati_mmu_addr=
s,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "dpll_mpu_m2_ck",
>
> Are you sure of that?

No, this was supposed to be the hwmod main_clk... the ocp_if clk
should be l3_div.

I will add these changes and the ones you mention as "mmu + cache",
and see how it goes from there.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
