From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP3 Feature list buggy
Date: Mon, 8 Nov 2010 13:00:58 +0200
Message-ID: <AANLkTi=CQAMWM2pK6EYo-VprOAd_gJQuOMxK5u0Lrokw@mail.gmail.com>
References: <AANLkTingmCrQGX9RQpYy0vgSbgLt+F6exgbnsMP0CuXY@mail.gmail.com>
	<20101108070223.GH1818@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54319 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0KHLA7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 06:00:59 -0500
Received: by gwj21 with SMTP id 21so3201048gwj.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 03:00:58 -0800 (PST)
In-Reply-To: <20101108070223.GH1818@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Arno Steffen <arno.steffen@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Nov 8, 2010 at 9:02 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Nov 05, 2010 at 10:08:13AM -0500, Arno Steffen wrote:
>>
>> There is a copy/paste bug in arch/arm/plat-omaop/include/control:
>>
>> Please replace:
>>
>> #define OMAP3_IVA_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << OMAP=
3_SGX_SHIFT)
>>
>> by:
>>
>> #define OMAP3_IVA_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << OMAP=
3_IVA_SHIFT)
>
> care to send a patch ?

already sent by Nismath it seems:
http://marc.info/?l=3Dlinux-omap&m=3D128897315505284&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
