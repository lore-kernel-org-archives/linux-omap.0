From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: Show OS in the display omap3430
Date: Wed, 19 Aug 2009 21:46:58 -0700
Message-ID: <d9ca78710908192146y49d29fc0k4b107f631984484a@mail.gmail.com>
References: <d9ca78710908190221s725d35e1ib3c30255c1499e4c@mail.gmail.com>
	 <d6a0f7aa0908192055q563dd7e9l6be2df1074edc13c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:62876 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbZHTEq5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 00:46:57 -0400
Received: by gxk1 with SMTP id 1so6640821gxk.17
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2009 21:46:58 -0700 (PDT)
In-Reply-To: <d6a0f7aa0908192055q563dd7e9l6be2df1074edc13c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On 8/19/09, Govindraj <govindraj.ti@gmail.com> wrote:
> In bootargs use console=3Dtty0.
>
> ---
> Regards,
> Govindraj.R
>
>
>
> On Wed, Aug 19, 2009 at 2:51 PM, Tar Gz <bsdraisefromhell@gmail.com> =
wrote:
>
>> Hi everybody
>>
>> i'm sorry, i newbies in omap3430...i try to porting linux kernel
>> 2.6.30 to omap3430
>>
>> how to show shell / desktop to omap3430 display?
>>
>> best regards,
>> Aldyth M
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

if i'm using
#setenv bootargs console=3DttyS0 root=3D/dev/mmcblk0p2 rw rootdelay=3D2=
 mem=3D128M

it's the output :
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>msgmni has been set to 249
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing ena=
bled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
<6>console [ttyS0] enabled
<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
<6>serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
=ED=ED =EDS=EDN=B5,=A9=ED R=ED  /=A9=ED  L=B5 N=B5

any idea?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
