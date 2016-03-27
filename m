From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
Date: Mon, 28 Mar 2016 00:44:27 +0300
Message-ID: <CAB=otbTsAwBohbYmwBERpdG-ZdAUk_vJwoZoO8dUf_H-W4jREg@mail.gmail.com>
References: <CAB=otbRd+hZaO6ihL3c88Ys_q-R4grmup4cfP70PT+N2JEQ3WQ@mail.gmail.com>
	<CAB=otbQ=jJNk=CtB4hu51HXxOLxhWEDaeWf3V0Uc7Uh3veXsfg@mail.gmail.com>
	<CAB=otbQ1J7FZm9vWLwor93+uD3Fv38ykduWMXG3qByNh4mV9=g@mail.gmail.com>
	<20160327202657.GA31059@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160327202657.GA31059@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Peter Chen <peter.chen@freescale.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Mar 27, 2016 at 11:26 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> I managed to boot N900 with working USB gadget (builtin g_ether)
>> >> in boardfile mode, can ping it from PC and transfer data. I don't
>> >> see any issue (except of musb name issue in twl phy driver, I've
>> >> already sent a fix for that: https://lkml.org/lkml/2016/3/24/670 )
>> >>
>> >> Pavel, I still don't see how you've got your issue, please share
>> >> more detials
>> >
>> > Ok, let me try. I undid all the changes in drivers/phy drivers/usb and
>> > include/linux/usb . I have all the gadget stuff built-in, so that I
>> > could use nfsroot, but this is boot from mmcblk.
>>
>> So do you mean you use original rootfs that was shipeed with N900?
>
> No. I'm using Debian ARM root. It includes useful X and even phone
> functions. https://gitlab.com/tui/tui .
>
>> > gzipped config is attached.
>>
>> Thanks, I'll try that
>
> Thanks.
>
>> > Dmesg from the n900 is attached as /tmp/delme.gz. I did _not_ apply
>> > the patch from https://lkml.org/lkml/2016/3/24/670 , yet, as I'm using
>> > devicetree boot.
>>
>> Hmm.. don't see anything strange in the boot log related to USB,
>> I'll try your config
>
> Let me know how it went.

I tried your config (with slight modifications) with vanilla kernel v4.5
(modifications: cmdline changed to default; used INITRAMFS_SOURCE
for prebuilt cpio archive with rootfs) and Device Tree booting.
Works fine for me except I need to unplug-plug usb cable or issue
# echo connect > /sys/devices/platform/68000000.ocp/480ab000
.usb_otg_hs/musb-hdrc.0.auto/udc/musb-hdrc.0.auto/soft_connect
to make connection.
The gadget driver successfully binds to the gadget, but I don't know
why the musb core doesn't issue pullup on USB lines during boot.

Best regards,
Ruslan
