From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 0/7] 34XX: PM: Workarounds to get omap3 to retention 3rd.
Date: Wed, 25 Jun 2008 17:08:19 +0530
Message-ID: <017101c8d6b7$f862e890$68bf18ac@ent.ti.com>
References: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:44517 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056AbYFYLia convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 07:38:30 -0400
In-Reply-To: <87ej6lj2ui.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Jouni Hogander' <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jouni Hogander
> Sent: Wednesday, June 25, 2008 2:42 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 0/7] 34XX: PM: Workarounds to get omap3 to=20
> retention 3rd.
>=20
> Hi,
>=20
> This patch set contains all workarounds that are needed to get omap3
> to retention. Also patch from Tero Kristo to get PM to work if using
> serial console is included in this set. Basically all patches in this
> set should be reverted one by one as correct fixes are implemented an=
d
> applied.
>=20
> This patch set superseeds earlier version sent 2008-06-17 7:28:35.
>=20
> To get Omap into retention, this patch set still depends on:
> 1. ARCH: OMAP: MUSB: Do not block sleep (Felipe Balbi)
> 2. ARM: OMAP: SmartReflex driver: enable in=20
> omap_3430sdp_defconfig (Kalle
>    Jokiniemi)
> 3. PRCM: 34XX: Fix wrong shift value used in dpll4_m4x2_ck enable bit
> 4. Patch which removes control of usbhost_sar_fck from clock=20
> tree (Paul
>    Walmsley will send this soon)

I tried these steps on the 3430SDP but could'nt hit retention.
What is the 4th patch mentioned above which Paul is yet to send and
how does not having it prevent retention?

>=20
> Test:
> 1. Apply dependency patches and workaround set on top of them
>=20
> 2. Enable disabling/enabling of gpio2-6 and uart clocks on idle:
>    $ echo 1 > /sys/power/clocks_off_while_idle
>=20
> 3. Try out static suspend:
>    $ echo mem > /sys/power/state
>    Wake up from suspend by entering character to serial console. This
>    should print out:
>    "Successfully put all powerdomains to target state"
>=20
> 4. Try out dynamic sleep:
>    $ echo 1 > /sys/power/sleep_while_idle
>    On Omap3430 SDP board VCORE_EN led can be used as an indicator. If
>    it starts to blink after a while then Omap enters retention on
>    idle. To make this work also display needs to be blanked.
>=20
> --=20
> Jouni H=C3=B6gander
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
