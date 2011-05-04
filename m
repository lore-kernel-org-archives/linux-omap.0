From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v2 07/12] OMAP: Serial: Allow UART parameters to be
 configured from board file
Date: Wed, 4 May 2011 16:09:41 +0530
Message-ID: <BANLkTinZLmHQL6Xx=n-s1D79cfT9a97eEA@mail.gmail.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-8-git-send-email-govindraj.raja@ti.com> <20110504095546.GY2092@atomide.com>
 <BANLkTimb-AsuXYRm+NV8CD3m=xHwteV7pw@mail.gmail.com> <20110504102543.GB2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20110504102543.GB2092@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Deepak K <deepak.k@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Jon Hunter <jon-hunter@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 4, 2011 at 3:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj <govindraj.ti@gmail.com> [110504 03:03]:
>> On Wed, May 4, 2011 at 3:25 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>> >> @@ -250,7 +251,7 @@ static void __init omap_2430sdp_init(void)
>> >> =A0 =A0 =A0 omap2430_i2c_init();
>> >>
>> >> =A0 =A0 =A0 platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2=
430_devices));
>> >> - =A0 =A0 omap_serial_init();
>> >> + =A0 =A0 omap_serial_init(NULL);
>> >> =A0 =A0 =A0 omap2_hsmmc_init(mmc);
>> >> =A0 =A0 =A0 omap2_usbfs_init(&sdp2430_usb_config);
>> > ...
>> >
>> >> =A0static inline void board_serial_init(void)
>> >> =A0{
>> >> - =A0 =A0 omap_serial_init();
>> >> + =A0 =A0 omap_serial_init(NULL);
>> >> =A0}
>> >
>> > This change seems like "crazy churn" and probably not needed
>> > if it's always null. Boards using platform_data can use
>> > omap_serial_init_port instead, right?
>>
>> We can intiliaze only one uart port with omap_serial_init_port.
>>
>> omap_serial_init initializes all uart port.
>>
>> During any client device integration using dma mode
>> (for example Bluetooth) we can pass the dma config
>> params based on the board & client device.
>
> But you're changing all omap_serial_init() calls to
> omap_serial_init(NULL) so there are no users for that.
>
> It should be a separate patch if it's needed.
>

Agree.

Will add seperate func. in serial.c file for board that need to pass th=
ese
params and retain the old func. omap_serial_init() syntax to avoid all =
the
additions in board-*.c files.

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
