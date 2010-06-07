From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
	3630
Date: Mon, 7 Jun 2010 14:17:31 +0530
Message-ID: <AANLkTilKWd9O3D4T-utnN2ookG5eP30JOxACxdJWKgXN@mail.gmail.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
	<871vcmq08s.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39888 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab0FGIrc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 04:47:32 -0400
Received: by vws5 with SMTP id 5so3170420vws.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Jun 2010 01:47:32 -0700 (PDT)
In-Reply-To: <871vcmq08s.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

On Fri, Jun 4, 2010 at 9:05 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch makes the following:
>> =A0- Adds missing wakeup padding register handling.
>> =A0- Fixes a hardcode to use PER module ONLY on UART3.
>> =A0- Muxmode usage needed for uart4 for 3630 for padconf
>> =A0 =A0wakeup on rx line.
>

> The need for this muxmode needs to be better described.
>
> The usage of the new set muxmode function is not terribly clear.
> You're calling it in both _enable_wakeup() and _disable_wakeup() and
> in _resume_idle(), but it's not terribly clear (to me, or the casual
> changelog reader) why this is being done.

Intention was to ensure being in the right mux mode before accessing th=
e
padconf reg. Since we have padconf usage in these function I have
mux mode configuration before accessing padconf reg.
Will update changelog accordingly.

>>
>> +static inline void omap_uart_setmux_mode(struct omap_uart_state *ua=
rt)
>
> How about _set_muxmode()

ok fine, will change to omap_uart_set_muxmode(

>
>> +{
>> + =A0 =A0 u16 w =3D omap_ctrl_readw(uart->padconf);
>
> insert blank line

Sure will do.

> =A0 =A0 =A0 } else if (cpu_is_omap24xx()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 wk_mask =3D 0;
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

---
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
