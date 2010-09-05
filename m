From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization
Date: Sun, 5 Sep 2010 14:42:51 +0800
Message-ID: <AANLkTi=4J5u4SEh5jSPxObceWdAom51R+H_j8oApG5PG@mail.gmail.com>
References: <1283443098-15262-1-git-send-email-tom.leiming@gmail.com>
	<ee6a42fe148f72518d475ff3838fc32a@secure211.sgcpanel.com>
	<AANLkTimts7SjE9EKrmsSkynWsQc_VtJUVVigrFs2VtrK@mail.gmail.com>
	<AANLkTikiFbw6xz5jbvgPR5-X5mZxDkOjLdFuc=vG10qK@mail.gmail.com>
	<1fb6fc37cd0f017043d5c124bca4bb1a@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1fb6fc37cd0f017043d5c124bca4bb1a-WEDJutINlwSqfKURHDCIgFDQ4js95KgL@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/9/5 Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>:
> Hi,
>
> On Sat, 4 Sep 2010 23:36:39 +0800, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>> Considered bit PHYPWD of PHY_PWR_CTRL is zero at default,
>> say, OTG phy is not put into power down after system poweron,
>> so 2.6.36-rc3 will make musb device mode broken if bootloader
>> doesn't touch =A0PHYPWD of PHY_PWR_CTRL.
>>
>> Could you ack the patch if no further objections or give other
>> suggestions?
>
> I don't see why that patch should cause problems with device
> mode. Fact is that transceiver is only "asleep" when PHYPWD
> bit is true and without setting that flag correctly we were
> leaving phy's LDOs powered on for nothing when we were
> booting without a USB cable connected.
>
> If you don't explain exactly what is the problem you see
> (besides the WARN) it's to help any further, specially now

Oh, I already explain the cause in detail in this thread.

          http://marc.info/?l=3Dlinux-kernel&m=3D128347462130590&w=3D2

No problem, do it again, if you have any questions about the explanatio=
n
please feel free to let me know.

issue #1:(musb device not work with cable connected with PC)
        -twl->asleep is set as zero in .probe since bootloader has not
powerdown phy
        -EVENT_VBUS returned from twl4030_usb_linkstat since usb cable
is connected with PC
        -twl4030_phy_resume is called but does nothing since
twl->asleep is zero
        -the following are not called to initialize otg phy:
                 twl4030_phy_power / twl4030_i2c_access / twl4030_usb_s=
et_mode
        -so musb device mode does not work

issue #2:(regulator 'unbalanced disables' warnings )
        -twl->asleep is set as zero in .probe since bootloader has
not powerdown phy
        -EVENT_NONE returned from twl4030_usb_linkstat since no usb cab=
le is
connected with board
        -twl4030_phy_suspend is called
        -twl4030_phy_power is called since twl->asleep is zero
        -regulator_disable is called for power down case
        -so cause the kernel warning since no regulator_enable is calle=
d before

> that I'm 100% without HW to test against. I'm also in a
> big hurry packing a buch of stuff for moving to another
> appartment, so if there isn't enough information, I can't
> be of any help.

Sorry for disturbing you, hope you have a happy moving, :-)

>
> Still, I would NACK you patch because I don't think it's
> approaching the correct problem. If you only see that WARN,
> you could start by chaging the code so that:
>
> if (!regulator_is_enabled(twl->usb3v1)
> =A0 =A0regulator_enable(twl->usb3v1);

Yes, it is another fix for the issue #2, just different way for
the same problem, right?

>
> and similarly for the regulator_disable() call, then check
> whether there are any other problems. If there are, we will
> take it from there.
>
> All in all, I doubt that patch would cause break anything
> since it's just checking the initial state from the
> transceiver itself to set a flag in the driver structure,
> that's all.

No, .asleep flag is set according to the current link state,
instead of the initial state of transceiver. I don't think the patch
will cause break anything. If you think it will, please describe the
break in detail.

thanks,

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
