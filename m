From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Fri, 19 Sep 2008 08:21:33 +0300
Message-ID: <8763os3e3m.fsf@trdhcp146196.ntc.nokia.com>
References: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com>
	<20080918124501.GF28615@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56217 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYISFUM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 01:20:12 -0400
In-Reply-To: <20080918124501.GF28615@gandalf.research.nokia.com> (ext Felipe
	Balbi's message of "Thu, 18 Sep 2008 15:45:01 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, ext Paul Walmsley <paul@pwsan.com>

"ext Felipe Balbi" <felipe.balbi@nokia.com> writes:

> On Thu, Sep 18, 2008 at 03:22:32PM +0300, ext Kevin Hilman wrote:
>> This ensures that an unused HSMMC block will not interfere with slee=
p.
>>=20
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> It was observed that bootrom code initializes mmc in such a way that
> prevents system from idling.

This was just my guess, back then when I was debugging it.

The case here is that after bootup mmc parent clock (96 Mhz fck) is
not automatically cut off by hw, even if all it's child clocks are
gated. This prevents core to enter sleep state. I found out that it is
mmc who is guilty for this and resetting it helps. Funny part here is
that this doesn't happen with all SDP boards. Again I have guess for
this also:) This is sysboot pins. Boot sequence can be selected in SDP
board using dip switches. If mmc is selected as a one bootdevice then
this problem happens (or vice versa).

Anyway the plan is to have some generic code which resets all omap
modules on boot. Maybe even configure them in a way that they do
not break PM (or anything else). This would make sure that omap
modules that do not have drivers, would still be in a known
state. This is planned to be implemented in tiocp code. Paul, am I in
line with you in this?

If it is true what I wrote above about tiocp, then this fix is
temporary and will be removed as tiocp code gets in.
=20
>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
>> ---
>>  arch/arm/mach-omap2/hsmmc.c |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index 7334d86..03fe820 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -280,8 +280,16 @@ static struct omap_mmc_platform_data hsmmc_data=
 =3D {
>>  	},
>>  };
>> =20
>> +static void __init hsmmc_reset(void)
>> +{
>> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS1_SYSCONFIG);
>> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS2_SYSCONFIG);
>> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS3_SYSCONFIG);
>> +}
>> +
>>  void __init hsmmc_init(void)
>>  {
>> +	hsmmc_reset();
>>  	omap2_init_mmc(&hsmmc_data);
>>  }
>> =20
>> --=20
>> 1.5.4.3
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --=20
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
