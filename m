From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 3/5 v12] arm: omap: usb: register hwmods of usbhs
Date: Fri, 30 Sep 2011 14:45:32 +0530
Message-ID: <CAP05o4L1iR++BhYmYYEc-uV6pGfjBeSPPcFqhRizdBeV7Ko26g@mail.gmail.com>
References: <1317361318-28295-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109300113200.32653@utopia.booyaka.com>
	<20110930073449.GA13825@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110930073449.GA13825@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 30, 2011 at 1:04 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Sep 30, 2011 at 01:15:55AM -0600, Paul Walmsley wrote:
>> > The hwmod structure of usb_host_hs =A0and usb_tll are
>> > retrieved and registered with omap device
>> >
>> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> > Reviewed-by: Partha Basak <parthab@india.ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/usb-host.c | =A0100 ++++++++++++++---------=
-----------------
>> > =A01 files changed, 34 insertions(+), 66 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/=
usb-host.c
>> > index 89ae298..771dc78 100644
>> > --- a/arch/arm/mach-omap2/usb-host.c
>> > +++ b/arch/arm/mach-omap2/usb-host.c
>> > @@ -28,51 +28,28 @@
>>
>> > + =A0 oh[0] =3D omap_hwmod_lookup(USBHS_UHH_HWMODNAME);
>> > + =A0 if (!oh[0]) {
>> > + =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up %s\n", USBHS_UHH_H=
WMODNAME);
>> > + =A0 =A0 =A0 =A0 =A0 return;
>> > =A0 =A0 }
>> >
>> > - =A0 if (platform_device_register(&usbhs_device) < 0)
>> > - =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "USBHS platform_device_regis=
ter failed\n");
>> > + =A0 oh[1] =3D omap_hwmod_lookup(USBHS_TLL_HWMODNAME);
>> > + =A0 if (!oh[1]) {
>> > + =A0 =A0 =A0 =A0 =A0 pr_err("Could not look up %s\n", USBHS_TLL_H=
WMODNAME);
>> > + =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 }
>> >
>> > -init_end:
>> > - =A0 return;
>> > + =A0 od =3D omap_device_build_ss(OMAP_USBHS_DEVICE, bus_id, oh, 2=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)&usb=
hs_data, sizeof(usbhs_data),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_uhhtll_=
latency,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(o=
map_uhhtll_latency), false);
>>
>> Usually there's something wrong with omap_devices that contain
>> multiple hwmods. =A0Is there some reason why there isn't a separate =
driver
>> for the TLL? =A0Judging by a brief look at drivers/mfd/omap_usb_host=
=2Ec, the
>> TLL handling looks logically distinct?
>
> Yes, I have the same feeling. To my understanding, USB Host Subsystem=
 on
> OMAP is composed of the Transceiver-less link (TLL) and USB Host (UHH=
).
> Aparently, they could be handled by separate drivers.
>
> --
> balbi

yes, it can be as two separate drivers for uhh and tll;  But i don't
think driver can be used effectively.
Now ehci and ohci gets the clocks , config reg and port settings
through usb host which is sufficient.
If you make them as two different drivers; then ehci and ohci has to
interact with both the drivers separately.
which will be an unnecessary complications. I feel not divided this
driver into two

regards
keshava
