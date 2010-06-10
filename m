From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
	3630
Date: Thu, 10 Jun 2010 14:24:52 +0530
Message-ID: <AANLkTimSZaqZbP84C35dKh5XVZxezo-54ihxkpNx_Dni@mail.gmail.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
	<871vcmq08s.fsf@deeprootsystems.com>
	<20100607100656.GE15515@atomide.com>
	<AANLkTikpHFyvk28hTm-jTk4wdJ0oldqyncaGH2slq6w4@mail.gmail.com>
	<AANLkTikS_f5UWDr8WYrHga_W8kIeTwUienx6K37LWF80@mail.gmail.com>
	<20100609142801.GK32208@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59401 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0FJIyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 04:54:53 -0400
Received: by vws17 with SMTP id 17so3556876vws.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Jun 2010 01:54:53 -0700 (PDT)
In-Reply-To: <20100609142801.GK32208@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

On Wed, Jun 9, 2010 at 7:58 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj <govindraj.ti@gmail.com> [100607 17:50]:
>> On Mon, Jun 7, 2010 at 5:02 PM, Govindraj <govindraj.ti@gmail.com> w=
rote:
>> > On Mon, Jun 7, 2010 at 3:36 PM, Tony Lindgren <tony@atomide.com> w=
rote:
>> >> * Kevin Hilman <khilman@deeprootsystems.com> [100604 18:30]:
>> >>>
>> >>> > + =A0 w &=3D ~0x7;
>> >>> > + =A0 w |=3D OMAP_MUX_MODE2;
>> >>> > + =A0 omap_ctrl_writew(w, uart->padconf);
>> >>
>> >> Generic NAK for tinkering with the mux registers directly.
>> >>
>> >> Instead, Govindraj, please add omap_mux_request_signal() into mux=
=2Ec:
>> >>
>> >> void __iomem * __init omap_mux_request_signal(char *muxname);
>>
>> Looking into mach-omap2/mux.c
>>
>> Wouldn't retrieving offset will be enough as i have to depend on
>> again *_mux_* function call for remux which can have the offset and =
val
>> as parameter.
>
> You call omap_mux_request_signal with the signal name, and get
> the register address. Then you can just set it with readw/writew.
>
>> So I need to use =A0""K15_24XX_UART3_TX" as name to retrieve
>> UART3 offset if I am correct and traverse through the list doing an =
strcmp
>> on name to retrieve offset.
>>
>> In that case I dont find uart1/2/4 in list,
>> Should that be added into the list?
>
> No, that's the old mux code. You want to do something like
>
> void __iomem *uart1_rx;
>
> uart1_rx =3D omap_mux_request_signal("uart1_rx");
> if (!uart1_rx)
> =A0 =A0 =A0 =A0return -ENODEV;

Thanks got it,

-> Shouldn't we just retrieve the offset and then use
    omap_ctrl_writew\ omap_ctrl_readw calls?

-> I hope muxmode configuration can be done in the
    existing code itself by manually populating the mode
   and use offset retrieved from omap_mux_request_signal
   and use omap_ctrl_writew.
   Any comment?

--
Regards,
Govindraj.R

> ...
>
> See the signal names in mux34xx.c and the TRM. Then omap2 and omap4
> will work automatically once the mux code is ready for those.
>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
