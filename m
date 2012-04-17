From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Tue, 17 Apr 2012 18:17:19 +0530
Message-ID: <CAMrsUd+v-qhVPLbJp1ecE2+e5ayJAQrAzALr1sviH9RDJv3aMg@mail.gmail.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-3-git-send-email-govindraj.raja@ti.com> <20120410161136.GF6487@atomide.com>
 <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com> <20120417014103.GA21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35178 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756072Ab2DQMrm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 08:47:42 -0400
Received: by obbwc20 with SMTP id wc20so5421626obb.25
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 05:47:41 -0700 (PDT)
In-Reply-To: <20120417014103.GA21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>

On Tue, Apr 17, 2012 at 7:11 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> Few more comments below.
>
> * Raja, Govindraj <govindraj.raja@ti.com> [120411 04:53]:
> ...
>
>> +static int =A0__init omap_serial_fill_default_pads(struct omap_boar=
d_data *bdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct omap_uart_state *uart)
>> +{
>> + =A0 =A0 struct omap_mux_partition *tx_partition =3D NULL, *rx_part=
ition =3D NULL;
>> + =A0 =A0 struct omap_mux *rx_mux =3D NULL, *tx_mux =3D NULL;
>> + =A0 =A0 char *rx_fmt, *tx_fmt;
>> + =A0 =A0 int uart_nr =3D bdata->id + 1;
>> +
>> + =A0 =A0 if (bdata->id !=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_fmt =3D "uart%d_rx.uart%d_rx";
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_fmt =3D "uart%d_tx.uart%d_tx";
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 rx_fmt =3D "uart%d_rx_irrx.uart%d_rx_irrx"=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_fmt =3D "uart%d_tx_irtx.uart%d_tx_irtx"=
;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, rx_f=
mt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_nr, uart_nr);
>> + =A0 =A0 snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, tx_f=
mt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_nr, uart_nr);
>
> This naming won't work for the fourth port on 3630 as there are no "u=
art4_rx"
> or "uart4_tx" mux entries, they are "gpmc_wait2.uart4_tx" and
> "gpmc_wait3.uart4_tx".

But uart4 is unused on 3630 boards and boards trying to use them
should configure them from board file.
(I thought we agreed on this approach where only if uarts are
available in mux mode0 those ports will be dynamically muxed for wakeup
others should use omap_serial_init_port)

>
>> @@ -289,8 +354,8 @@ void __init omap_serial_board_init(struct
>> omap_uart_port_info *info)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads =3D NULL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata.pads_cnt =3D 0;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap34xx()=
)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_fill_default_p=
ads(&bdata);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (omap_serial_fill_default_pads(&bdata, =
uart))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!info)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_init_port(&b=
data, NULL);
>
> Can't the omap_serial_board_init() now be just be omap_serial_init(vo=
id)
> as it's not used anywhere else?

Yes sure we can remove that.

>
> Anyways, this is getting too complex for the -rc series as at least 2=
430sdp
> is using alternative pins for the first uart. Let's patch to remove j=
ust
> the uart4 entry for 3630 for the -rc and then we can properly fix thi=
s
> for the next merge window.

Okay. in that case the earlier patch [1] should be fine to solve the
gpmc issue observed
and ehci issue on beagle-xm.

--
Thanks,
Govindraj.R

[1]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/090961=
=2Ehtml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
