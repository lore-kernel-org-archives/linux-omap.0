From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: [PATCH 10/11] omap: musb: get rid of dyn_fifo
Date: Tue, 23 Feb 2010 16:09:20 +0100
Message-ID: <f3642e6b1002230709r4dcd09bv9c495875bbd873c7@mail.gmail.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
	 <20100219233036.10559.29778.stgit@baageli.muru.com>
	 <4B83EC7C.6020406@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:45167 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0BWPJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 10:09:22 -0500
In-Reply-To: <4B83EC7C.6020406@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, Feb 23, 2010 at 3:55 PM, Thomas Weber <weber@corscience.de> wro=
te:
> Tony Lindgren wrote:
>> From: Felipe Balbi <felipe.balbi@nokia.com>
>>
>> that's deprecated as we can check dyn_fifo from
>> CONFIGDATA register.
>>
>> Cc: linux-usb@vger.kernel.org
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/usb-musb.c | =C2=A0 =C2=A01 -
>> =C2=A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/us=
b-musb.c
>> index 2221a6c..85feb60 100644
>> --- a/arch/arm/mach-omap2/usb-musb.c
>> +++ b/arch/arm/mach-omap2/usb-musb.c
>> @@ -49,7 +49,6 @@ static struct resource musb_resources[] =3D {
>>
>> =C2=A0static struct musb_hdrc_config musb_config =3D {
>> =C2=A0 =C2=A0 =C2=A0 .multipoint =C2=A0 =C2=A0 =3D 1,
>> - =C2=A0 =C2=A0 .dyn_fifo =C2=A0 =C2=A0 =C2=A0 =3D 1,
>> =C2=A0 =C2=A0 =C2=A0 .num_eps =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 16,
>> =C2=A0 =C2=A0 =C2=A0 .ram_bits =C2=A0 =C2=A0 =C2=A0 =3D 12,
>> =C2=A0};
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>>
>>
> Hi,
>
> I think this patch breaks musb_hdrc.
>
> In musb_core_init is musb->config->dyn_fifo checked but is never set.
>
> So I get the following dmesg output:
>
> musb_hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combine, bulk s=
plit,
> HB-ISO Rx, HB-ISO Tx, SoftConn)
> musb_hdrc: MHDRC RTL version 1.400
> musb_core_init 1405: reconfigure software for Dynamic FIFOs
> musb_hdrc musb_hdrc: musb_init_controller failed with status -19
>
> Thomas

I think I have the same problem.
There are other problems right now (I'm trying several different
branch/defconfig
combinations) so I can't be 100% sure.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
