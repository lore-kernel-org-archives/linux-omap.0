From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Thu, 21 Jul 2011 15:54:52 +0530
Message-ID: <CAC63_iSH-Orff6z+XCTA4EiD5PJ13H8X_OccQd5uGvrvrLccvA@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
	<CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
	<CAC63_iSqN=rX6MbzFWM6z+zf1Eybg3MOD=qQVdeNg5cyENhPjw@mail.gmail.com>
	<CAC63_iTf696D6Q_EzFeUUp5R38pYNEJBkmKviEu6-yuF0y=bNA@mail.gmail.com>
	<CACxGe6uzyxf35WDg6COnPVt3dhQv1H80L1svALxp4naySx2BcA@mail.gmail.com>
	<CAC63_iSjCrO31GnTiD9Dd8-ns5+Qer_wJSjY08g-Ft_uKfz6jw@mail.gmail.com>
	<20110719213737.GQ6848@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110719213737.GQ6848-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grant,

On Wed, Jul 20, 2011 at 3:07 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> On Tue, Jul 19, 2011 at 11:28:53AM +0530, G, Manjunath Kondaiah wrote:
>> Grant/Kevin,
>>
>> On Sun, Jul 17, 2011 at 10:43 AM, Grant Likely
>> <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> > Hi Manjunath,
>> >
>> > Comments below. =A0I left in a lot of context for the new folks that
>> > I've cc'd (Tony and Kevin).
>> >
>> > On Sat, Jul 16, 2011 at 2:07 PM, G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org=
> wrote:
>> >> On Thu, Jul 14, 2011 at 4:45 AM, Grant Likely <grant.likely@secretlab=
.ca> wrote:
>> >>>> > +static void __init omap3_init(void)
>> >>>> > +{
>> [...]
>> >> + =A0 =A0 =A0 omap_register_i2c_bus(id, speed, i2c_board_info, 1);
>> >
>> > While this does in a sense work, and creates an omap_device for the
>> > i2c bus that does get probed, it ends up encoding an awful lot of
>> > device specific details into the generic devicetree support code. =A0T=
he
>> > i2c bus driver itself must be responsible for decoding the speed and
>> > child nodes, and in fact it can easily be modified to do so (I've
>> > already demonstrated how to do so). =A0The real problem is making sure
>> > the platform_device is created in a way that attaches the correct
>> > hwmod data. For this context, the current omap_register_i2c_bus()
>> > isn't a useful method for doing so.
>> >
>> > So what is to be done? =A0omap_register_i2c_bus() does three things;
>> > 1) register an i2c board info for the bus with i2c_register_board_info=
(),
>> > 2) fill platform_data for the device, and
>> > 3) use omap_i2c_add_bus to create the platform_device with attached hw=
mod.
>> >
>> > Of these three, 1 & 2 must not be done when using the DT. Only
>> > omap_i2c_add_bus() does something useful, but that is still specific
>> > to the i2c device.
>> >
>> > omap_i2c_add_bus() splits to omap{1,2}_add_bus().
>> >
>> > omap1_i2c_add_bus() sets up pinmux and calls platform_device register.
>> > =A0pinmux setup needs to be factored out anyway for generic DT platform
>> > device registration, which just leaves platform_device creation which
>> > is already handled by of_platform_populate().
>> >
>> > omap2_i2c_add_bus() does the same thing, except it also looks up the
>> > hwmod data (*oh) and uses it to call omap_device_build().
>> > omap_device_build() or something equivalent needs to be called for
>> > every omap device in the system, which is to create platform_devices
>> > with hwmod attached. =A0Now we're starting to hit generic code. =A0:-)
>> >
>> > The way I see it, you've got two options:
>> >
>> > 1) modify the of_platform_bus_create() to call some kind of
>> > of_platform_bus_create_omap() for devices that match "ti,omap3-device"
>> > or something.
>> >
>> > 2) Leave of_platform_bus_create(), and instead us a notifier to attach
>> > hwmod data to normal platform devices. =A0omap_device_build() is
>> > actually pretty simple. =A0It allocated a device, it attaches
>> > platform_data and hwmod pointers to the device and registers it.
>> > omap_device_register() is just a wrapper around
>> > platform_device_register().
>> >
>> > My preference is definitely #2, but there is a wrinkle in this
>> > approach. =A0Unfortunately omap_devices are not simply plain
>> > platform_devices with extra data attached, an omap_device actually
>> > embeds the platform_device inside it, which cannot be attached after
>> > the fact. =A0I think I had talked with Kevin (cc'd) about eliminating
>> > the embedding, but I cannot remember clearly on this point. =A0As long
>> > as platform_device remains embedded inside struct omap_device, #2
>> > won't work.
>>
>> Can you please elaborate more on this issue?
>
> Look at the of_platform_populate() call path (in devicetree/next) and
> see how it handles amba devices. =A0Do the same thing for omap_devices.

As per the discussion so far, I am trying to take following approach:

|--->of_platform_populate(...)
   |--->of_platform_bus_create_omap()-->Here notifiers are added
      |--->platform_device_register() --->  calls registered notifiers
         |--->notifier_callback - look up hwmod entry by name
                                - call omap_device_build(need to pass
platform_device pointer)
                                - get all the details such as resource
structures, irqs,platform_data
                                  etc from hwmod database and auxdata
and assign it to platform_device
                                  pointer received from notifier
callback function.
                                          - there will be no
platform_device_register from omap_device_build
                                            since it is already called
from "of_platform_bus_create_omap"

Please note that, with the above approach, the platform_device pointer
which is embedded
inside omap_device is not used and omap_device_build api will expect
platform device pointer.

-M
