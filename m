From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization
Date: Mon, 6 Sep 2010 00:00:12 +0800
Message-ID: <AANLkTimf2af9QBw2s93n6Ja5cgHODudfwmMqKc02GmbC@mail.gmail.com>
References: <1283443098-15262-1-git-send-email-tom.leiming@gmail.com>
	<ee6a42fe148f72518d475ff3838fc32a@secure211.sgcpanel.com>
	<AANLkTimts7SjE9EKrmsSkynWsQc_VtJUVVigrFs2VtrK@mail.gmail.com>
	<AANLkTikiFbw6xz5jbvgPR5-X5mZxDkOjLdFuc=vG10qK@mail.gmail.com>
	<1fb6fc37cd0f017043d5c124bca4bb1a@secure211.sgcpanel.com>
	<AANLkTi=4J5u4SEh5jSPxObceWdAom51R+H_j8oApG5PG@mail.gmail.com>
	<7c720d238d9d5ba6f483cdd7303315e4@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c720d238d9d5ba6f483cdd7303315e4@secure211.sgcpanel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-omap@vger.kernel.org

2010/9/5 Felipe Balbi <me@felipebalbi.com>:
> Hi,
>
> On Sun, 5 Sep 2010 14:42:51 +0800, Ming Lei <tom.leiming@gmail.com> w=
rote:
>> issue #1:(musb device not work with cable connected with PC)
>> =A0 =A0 =A0 =A0 -twl->asleep is set as zero in .probe since bootload=
er has not
>> powerdown phy
>> =A0 =A0 =A0 =A0 -EVENT_VBUS returned from twl4030_usb_linkstat since=
 usb cable
>> is connected with PC
>> =A0 =A0 =A0 =A0 -twl4030_phy_resume is called but does nothing since
>> twl->asleep is zero
>> =A0 =A0 =A0 =A0 -the following are not called to initialize otg phy:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_phy_power / twl4030_i2c_a=
ccess /
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_usb_set_mode
>> =A0 =A0 =A0 =A0 -so musb device mode does not work
>
> ok, I see. So what you could do is enable regulators on probe
> based on PHYPWR bit.

This patch will enable regulators on probe based on current link state
returned from twl4030_usb_linkstat instead of PHYPWR bit. If vbus or
ID event detected, call __twl4030_phy_resume to enable regulators/
phy power/set mode to make phy into work state, or else call
__twl4030_phy_power(0) to power down otg phy.

See twl4030_usb_phy_init introduced in the patch.

>> No, .asleep flag is set according to the current link state,
>> instead of the initial state of transceiver. I don't think the patch
>> will cause break anything. If you think it will, please describe the
>> break in detail.
>
> if we revert that patch, you'll see that usb3v1 ldos are left on

You commit before does fix one problem, which may keep phy in
power on even no cable connected, so I do not request a simple
revert, :-).

> if we never plug/unplug usb cable. AFAIR, the reset state of those
> LDOs is ON, so that's why we need that patch.

=46rom Table 5-373 of TPS65950 manual[1], usb3v1 ldo is in sleep state
after reset. But it is put into active state in twl4030_usb_ldo_init no=
w,
seems activating it too early.  I have verified it OK on beagle board t=
o
remove the early activating of usb3v1 in twl4030_usb_ldo_init. I'll mer=
ge
it into the v2 of the patch and post it for your review.

>
> I'll try to work on it monday judging I'll have laptop and HW
> available by then.

Very good, thanks your work!

[1], TPS65950 Technical Reference Manual, http://www.ti.com/litv/pdf/sw=
cu050e


thanks,
--=20
Lei Ming
