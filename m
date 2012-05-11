From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Fri, 11 May 2012 14:43:50 +0530
Message-ID: <CAMrsUdJn6G1p29QZQbo6J_-aadj=tMrfCEM5GMJSUwTdRqg05g@mail.gmail.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com> <20120510191152.GN21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47099 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758493Ab2EKJOM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 05:14:12 -0400
Received: by obbwd18 with SMTP id wd18so3768037obb.0
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 02:14:11 -0700 (PDT)
In-Reply-To: <20120510191152.GN21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

On Fri, May 11, 2012 at 12:41 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Govindraj.R <govindraj.raja@ti.com> [120510 06:09]:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The commit (bce492c0 =A0ARM: OMAP2+: UART: Fix incorrect population =
of
>> default uart pads) removed default uart pads that where getting popu=
lated
>> and which was making rx pin wakeup capable. If uart pads was used in
>
> Nitpick.. this should say "were used" here =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ^^^

will change this.

>
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -295,8 +353,7 @@ void __init omap_serial_board_init(struct omap_u=
art_port_info *info)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads_cnt =3D 0;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap34xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_fill_default_p=
ads(&bdata);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_check_wakeup(&bdata, uart);
>
> Should this section become:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_check_wake=
up(&bdata, uart);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_init_port(=
&bdata, NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_serial_init_port(=
&bdata, &info[uart->num]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> As if you have bdata, then there should not be anything to mux,
> right?

populating bdata should not depend on port_info,
omap_serial_board_init takes only port info parameter and tries to popu=
late
wakeup parameter since it has not received the same from board file.
And board file may or may not pass port info.

So populating bdata -> for uart wakeup pin should not be coupled with
availability of port info.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
