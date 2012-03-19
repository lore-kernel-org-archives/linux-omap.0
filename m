From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] ARM: OMAP: TLL driver implementation for USB host driver
Date: Mon, 19 Mar 2012 11:49:28 +0530
Message-ID: <CAP05o4JThGfbmyOorZwuViiSTz_kKqW3_qJagFTi3q+VjXq15Q@mail.gmail.com>
References: <1330957865-30543-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4LKEHtXFzZ0ysV+gNVu-_dh9BrAZb+M5UgaVy6dssMNbA@mail.gmail.com>
	<20120316164300.GC20524@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120316164300.GC20524@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 16, 2012 at 10:13 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> =
wrote:
> Hi Keshava,
>
> On Mon, Mar 05, 2012 at 08:13:45PM +0530, Munegowda, Keshava wrote:
>> On Mon, Mar 5, 2012 at 8:01 PM, Keshava Munegowda <keshava_mgowda@ti=
=2Ecom> wrote:
>> > From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >
>> > The TLL configuration is removed from the UHH driver and implement=
ed as
>> > a seperate platform driver. Now, the UHH driver configures the TLL
>> > through API's exported by the TLL platform driver. The TLL is an
>> > has independent hardware mod structure for in OMAP3 and later chip=
s,
>> > hence an dedicated platform driver is created.
>> >
>> > Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>> >
>> > Keshava Munegowda (5):
>> > =A0ARM: OMAP: USB: HOST TLL platform driver
>> > =A0ARM: OMAP: USB: Build the USB HOST TLL omap device
>> > =A0ARM: OMAP: USB: Remove TLL specific code
>> > =A0ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
>> > =A0ARM: OMAP: change the USB TLL clocks device name
>> >
>> > =A0arch/arm/mach-omap2/clock3xxx_data.c =A0| =A0 =A08 +-
>> > =A0arch/arm/mach-omap2/clock44xx_data.c =A0| =A0 =A04 +-
>> > =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0| =A0 28 ++-
>> > =A0arch/arm/plat-omap/include/plat/usb.h | =A0 =A09 +
>> > =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
>> > =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
>> > =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 | =A0232 +-----=
-----------
>> > =A0drivers/mfd/omap-usb-tll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0463 ++++=
+++++++++++++++++++++++++++++
>> > =A08 files changed, 513 insertions(+), 235 deletions(-)
>> > =A0create mode 100644 drivers/mfd/omap-usb-tll.c
>> >
>>
>> Hi Samuel
>> =A0 =A0 =A0 =A0 just to get your attention; I have added your mail i=
d in the
>> "to" list.
>> please let me know =A0your comments on this patch series;
> Here as well, I don't think I was cc'ed on the original submission. W=
ithout
> getting the actual patch, I'll have hard time reviewing it.
>
> Cheers,
> Samuel.

Sorry,  I resend the series CCing  you

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
