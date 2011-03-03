From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be configured
 from board file
Date: Thu, 3 Mar 2011 17:44:38 +0530
Message-ID: <AANLkTim2+2cEEZrkF4eD2oNtv-ESLhTNVNO96TXHUm+-@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-7-git-send-email-govindraj.raja@ti.com> <056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
 <AANLkTimD9rOC=4P6Vy2jzvcXZ-gZmF42Te4CBjS8AJLT@mail.gmail.com>
 <8ab9882cd92792e9bf2b836c0ec9c7fe@mail.gmail.com> <AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
 <20110302182402.GC20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20110302182402.GC20560@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Deepak Kattungal <deepak.k@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 2, 2011 at 11:54 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Govindraj <govindraj.ti@gmail.com> [110302 02:05]:
>>
>> >>>>+static struct omap_device_pad default_serial1_pads[] __initdata=
 =3D {
>> >>>>+ =A0 =A0 =A0{
>> >>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "uart2_rx.uart2_rx",
>> >>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D OMAP_DEVICE_PAD_REMUX=
 |
>> > OMAP_DEVICE_PAD_WAKEUP,
>> >>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =3D OMAP_MUX_MODE0,
>> >>>>+ =A0 =A0 =A0},
> ...
>
> AFAIK you should only need the OMAP_DEVICE_PAD_REMUX option for
> omap24xx. And if you use that option, you also need the .idle
> value.
>

Yes correct. I should avoid enabling rx-pad wakeup for omap24xx and
populate rx pad wakeup only for 3xxx onwards as done prior to this patc=
h.

Will correct this in next version.

--
Thanks,
Govindraj.R



> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
