From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] ARM: OMAP: USB: fix the pointer type mismatch compilation warning
Date: Mon, 5 Mar 2012 17:06:41 +0530
Message-ID: <CAP05o4JVXwMLJ_q-XRdv7ijzgUpFrJZVVFy+WY=eoeWrq1cV9A@mail.gmail.com>
References: <1330946376-17672-1-git-send-email-keshava_mgowda@ti.com>
	<CAAL8m4x8mg5TDkEQAe-xK1XNUys8bN-AMKKgH=SmeFH3hEtsXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:33623 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756893Ab2CELgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 06:36:42 -0500
Received: by mail-tul01m020-f170.google.com with SMTP id wd1so10347395obb.1
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 03:36:41 -0800 (PST)
In-Reply-To: <CAAL8m4x8mg5TDkEQAe-xK1XNUys8bN-AMKKgH=SmeFH3hEtsXg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

On Mon, Mar 5, 2012 at 4:53 PM, Govindraj <govindraj.ti@gmail.com> wrot=
e:
> On Mon, Mar 5, 2012 at 4:49 PM, Keshava Munegowda <keshava_mgowda@ti.=
com> wrote:
>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>
>> The compilation of usb-host.c file was resulting compilation warning
>> due to pointer type mismatch in assignment of return pointer type
>> of the function omap_device_build_ss to local pointer type.
>> This warning is fixed.
>
> Its fixed already.
>
> https://lkml.org/lkml/2012/2/14/73

Thanks ;  it by Felipe :)

regards
keshava


>
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/usb-host.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/us=
b-host.c
>> index 771dc78..88d4a19 100644
>> --- a/arch/arm/mach-omap2/usb-host.c
>> +++ b/arch/arm/mach-omap2/usb-host.c
>> @@ -486,7 +486,7 @@ static void setup_4430ohci_io_mux(const enum usb=
hs_omap_port_mode *port_mode)
>> =A0void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
>> =A0{
>> =A0 =A0 =A0 =A0struct omap_hwmod =A0 =A0 =A0 *oh[2];
>> - =A0 =A0 =A0 struct omap_device =A0 =A0 =A0*od;
>> + =A0 =A0 =A0 struct platform_device =A0*od;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_id =3D=
 -1;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i;
>>
>> --
>> 1.6.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
