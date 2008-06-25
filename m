From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 0/7] 34XX: PM: Workarounds to get omap3 to retention 3rd.
Date: Wed, 25 Jun 2008 14:43:15 +0300
Message-ID: <87r6alhh9o.fsf@trdhcp146196.ntc.nokia.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
	<017101c8d6b7$f862e890$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22557 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbYFYLnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 07:43:47 -0400
In-Reply-To: <017101c8d6b7$f862e890$68bf18ac@ent.ti.com> (ext Rajendra Nayak's
	message of "Wed, 25 Jun 2008 17:08:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jouni Hogande=
r
>> Sent: Wednesday, June 25, 2008 2:42 PM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH 0/7] 34XX: PM: Workarounds to get omap3 to=20
>> retention 3rd.
>>=20
>> Hi,
>>=20
>> This patch set contains all workarounds that are needed to get omap3
>> to retention. Also patch from Tero Kristo to get PM to work if using
>> serial console is included in this set. Basically all patches in thi=
s
>> set should be reverted one by one as correct fixes are implemented a=
nd
>> applied.
>>=20
>> This patch set superseeds earlier version sent 2008-06-17 7:28:35.
>>=20
>> To get Omap into retention, this patch set still depends on:
>> 1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)
>> 2. ARM: OMAP: SmartReflex driver: enable in=20
>> omap_3430sdp_defconfig (Kalle
>>    Jokiniemi)
>> 3. PRCM: 34XX: Fix wrong shift value used in dpll4_m4x2_ck enable bi=
t
>> 4. Patch which removes control of usbhost_sar_fck from clock=20
>> tree (Paul
>>    Walmsley will send this soon)
>
> I tried these steps on the 3430SDP but could'nt hit retention.
> What is the 4th patch mentioned above which Paul is yet to send and
> how does not having it prevent retention?

You can do something like this while waiting for patches from Paul:

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index b4dceea..8370f8a 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2237,7 +2237,7 @@ static struct clk usbhost_sar_fck =3D {
        .init           =3D &omap2_init_clk_clkdm,
        .enable_reg     =3D OMAP34XX_PRM_REGADDR(OMAP3430ES2_USBHOST_MO=
D, PM_PWSTCTRL),
        .enable_bit     =3D OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-       .flags          =3D CLOCK_IN_OMAP3430ES2,
+       .flags          =3D CLOCK_IN_OMAP3430ES2 | ALWAYS_ENABLED,
        .clkdm_name     =3D "usbhost_clkdm",
        .recalc         =3D &followparent_recalc,
 };

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
