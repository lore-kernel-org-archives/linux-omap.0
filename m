From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Tue, 19 Jul 2011 11:28:53 +0530
Message-ID: <CAC63_iSjCrO31GnTiD9Dd8-ns5+Qer_wJSjY08g-Ft_uKfz6jw@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37768 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092Ab1GSF6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 01:58:55 -0400
Received: by yib18 with SMTP id 18so1843893yib.20
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 22:58:53 -0700 (PDT)
In-Reply-To: <CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

Grant/Kevin,

On Sun, Jul 17, 2011 at 10:43 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Hi Manjunath,
>
> Comments below. =A0I left in a lot of context for the new folks that
> I've cc'd (Tony and Kevin).
>
> On Sat, Jul 16, 2011 at 2:07 PM, G, Manjunath Kondaiah <manjugk@ti.co=
m> wrote:
>> On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretla=
b.ca> wrote:
>>>> > +static void __init omap3_init(void)
>>>> > +{
[...]
>> + =A0 =A0 =A0 omap_register_i2c_bus(id, speed, i2c_board_info, 1);
>
> While this does in a sense work, and creates an omap_device for the
> i2c bus that does get probed, it ends up encoding an awful lot of
> device specific details into the generic devicetree support code. =A0=
The
> i2c bus driver itself must be responsible for decoding the speed and
> child nodes, and in fact it can easily be modified to do so (I've
> already demonstrated how to do so). =A0The real problem is making sur=
e
> the platform_device is created in a way that attaches the correct
> hwmod data. For this context, the current omap_register_i2c_bus()
> isn't a useful method for doing so.
>
> So what is to be done? =A0omap_register_i2c_bus() does three things;
> 1) register an i2c board info for the bus with i2c_register_board_inf=
o(),
> 2) fill platform_data for the device, and
> 3) use omap_i2c_add_bus to create the platform_device with attached h=
wmod.
>
> Of these three, 1 & 2 must not be done when using the DT. Only
> omap_i2c_add_bus() does something useful, but that is still specific
> to the i2c device.
>
> omap_i2c_add_bus() splits to omap{1,2}_add_bus().
>
> omap1_i2c_add_bus() sets up pinmux and calls platform_device register=
=2E
> =A0pinmux setup needs to be factored out anyway for generic DT platfo=
rm
> device registration, which just leaves platform_device creation which
> is already handled by of_platform_populate().
>
> omap2_i2c_add_bus() does the same thing, except it also looks up the
> hwmod data (*oh) and uses it to call omap_device_build().
> omap_device_build() or something equivalent needs to be called for
> every omap device in the system, which is to create platform_devices
> with hwmod attached. =A0Now we're starting to hit generic code. =A0:-=
)
>
> The way I see it, you've got two options:
>
> 1) modify the of_platform_bus_create() to call some kind of
> of_platform_bus_create_omap() for devices that match "ti,omap3-device=
"
> or something.
>
> 2) Leave of_platform_bus_create(), and instead us a notifier to attac=
h
> hwmod data to normal platform devices. =A0omap_device_build() is
> actually pretty simple. =A0It allocated a device, it attaches
> platform_data and hwmod pointers to the device and registers it.
> omap_device_register() is just a wrapper around
> platform_device_register().
>
> My preference is definitely #2, but there is a wrinkle in this
> approach. =A0Unfortunately omap_devices are not simply plain
> platform_devices with extra data attached, an omap_device actually
> embeds the platform_device inside it, which cannot be attached after
> the fact. =A0I think I had talked with Kevin (cc'd) about eliminating
> the embedding, but I cannot remember clearly on this point. =A0As lon=
g
> as platform_device remains embedded inside struct omap_device, #2
> won't work.

Can you please elaborate more on this issue?

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
