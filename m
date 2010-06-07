From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
	3630
Date: Mon, 7 Jun 2010 17:02:01 +0530
Message-ID: <AANLkTikpHFyvk28hTm-jTk4wdJ0oldqyncaGH2slq6w4@mail.gmail.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
	<871vcmq08s.fsf@deeprootsystems.com>
	<20100607100656.GE15515@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44112 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0FGLcD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 07:32:03 -0400
Received: by gye5 with SMTP id 5so2091056gye.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Jun 2010 04:32:01 -0700 (PDT)
In-Reply-To: <20100607100656.GE15515@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

On Mon, Jun 7, 2010 at 3:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [100604 18:30]:
>>
>> > + =A0 w &=3D ~0x7;
>> > + =A0 w |=3D OMAP_MUX_MODE2;
>> > + =A0 omap_ctrl_writew(w, uart->padconf);
>
> Generic NAK for tinkering with the mux registers directly.
>
> Instead, Govindraj, please add omap_mux_request_signal() into mux.c:
>
> void __iomem * __init omap_mux_request_signal(char *muxname);
>
> Which returns the address of the mux register in question based
> on the signal name. Then in the platform init code you can request
> the pins for all the UARTs in use, and provide functions to remux
> them as needed for the idle modes.
>
> This will work for omap2 also at some point once it's converted to
> use the common mux framework. And it will work in a generic way
> for all omaps under mach-omap2 eventually.
>
> You can take a look at the omap_mux_get_gpio() in mux.c for a
> similar example.

ok fine, will check out.

Thanks for the review.
---
Regards,
Govindraj.R

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
