From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Fri, 11 May 2012 14:45:44 +0530
Message-ID: <CAMrsUdL8117xSFah8+qxE_8pZozuXhWv587p4UK6hacMjxYO6w@mail.gmail.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com> <CA+Bv8XbDVW_XbUbKyTziyw5LjxbymYKNWhFySBhaMeT22b-Bxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:32913 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755328Ab2EKJQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 05:16:06 -0400
Received: by obhx4 with SMTP id x4so3959961obh.34
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 02:16:04 -0700 (PDT)
In-Reply-To: <CA+Bv8XbDVW_XbUbKyTziyw5LjxbymYKNWhFySBhaMeT22b-Bxw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

On Fri, May 11, 2012 at 2:04 PM, Russ Dill <russ.dill@gmail.com> wrote:
> On Thu, May 10, 2012 at 6:05 AM, Govindraj.R <govindraj.raja@ti.com> =
wrote:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The commit (bce492c0 =A0ARM: OMAP2+: UART: Fix incorrect population =
of
>> default uart pads) removed default uart pads that where getting popu=
lated
>> and which was making rx pin wakeup capable. If uart pads was used in
>> different mode by any other module then it would fail since the defa=
ult
>> pads took over all the uart pins forcefully. With removal of default=
 pads
>> the rx_pad wakeup for console uart while waking up from off mode is =
broken.

[...]


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if uart is used in default =
tx/rx mode i.e. in mux mode0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if yes then configure rx pin for =
wake up capability
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(rx_mode & 0x07) && !(tx_mode & 0=
x07))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_serial_fill_uart_=
tx_rx_pads(bdata, uart);
>
> I realize the comment makes it clear, but it'd probably be better to
> just make the code clear. I noticed mux.h has a OMAP_MODE_GPIO(x)
> macro for testing if a mux is in mode4. Perhaps its time to start
> expanding on that, at least with a macro like:
>
> #define OMAP_MUX_MODE(x) ((x) & OMAP_MUX_MODE7)
>
> So you can do a OMAP_MUX_MODE(rx_mode) =3D=3D OMAP_MUX_MODE0
>

Yes sure, will add the macro and use the same.
(will post v3 addressing the comments received so far)

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
