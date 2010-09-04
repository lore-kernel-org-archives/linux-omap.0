From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization
Date: Sat, 04 Sep 2010 16:24:39 -0500
Message-ID: <1fb6fc37cd0f017043d5c124bca4bb1a@secure211.sgcpanel.com>
References: <1283443098-15262-1-git-send-email-tom.leiming@gmail.com> <ee6a42fe148f72518d475ff3838fc32a@secure211.sgcpanel.com> <AANLkTimts7SjE9EKrmsSkynWsQc_VtJUVVigrFs2VtrK@mail.gmail.com> <AANLkTikiFbw6xz5jbvgPR5-X5mZxDkOjLdFuc=vG10qK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikiFbw6xz5jbvgPR5-X5mZxDkOjLdFuc=vG10qK@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, 4 Sep 2010 23:36:39 +0800, Ming Lei <tom.leiming@gmail.com> wrote:
> Considered bit PHYPWD of PHY_PWR_CTRL is zero at default,
> say, OTG phy is not put into power down after system poweron,
> so 2.6.36-rc3 will make musb device mode broken if bootloader
> doesn't touch  PHYPWD of PHY_PWR_CTRL.
> 
> Could you ack the patch if no further objections or give other
> suggestions?

I don't see why that patch should cause problems with device
mode. Fact is that transceiver is only "asleep" when PHYPWD
bit is true and without setting that flag correctly we were
leaving phy's LDOs powered on for nothing when we were
booting without a USB cable connected.

If you don't explain exactly what is the problem you see
(besides the WARN) it's to help any further, specially now
that I'm 100% without HW to test against. I'm also in a
big hurry packing a buch of stuff for moving to another
appartment, so if there isn't enough information, I can't
be of any help.

Still, I would NACK you patch because I don't think it's
approaching the correct problem. If you only see that WARN,
you could start by chaging the code so that:

if (!regulator_is_enabled(twl->usb3v1)
    regulator_enable(twl->usb3v1);

and similarly for the regulator_disable() call, then check
whether there are any other problems. If there are, we will
take it from there.

All in all, I doubt that patch would cause break anything
since it's just checking the initial state from the
transceiver itself to set a flag in the driver structure,
that's all.

-- 
balbi
