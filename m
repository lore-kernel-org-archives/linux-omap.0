From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization
Date: Sun, 05 Sep 2010 04:51:19 -0500
Message-ID: <7c720d238d9d5ba6f483cdd7303315e4@secure211.sgcpanel.com>
References: <1283443098-15262-1-git-send-email-tom.leiming@gmail.com> <ee6a42fe148f72518d475ff3838fc32a@secure211.sgcpanel.com> <AANLkTimts7SjE9EKrmsSkynWsQc_VtJUVVigrFs2VtrK@mail.gmail.com> <AANLkTikiFbw6xz5jbvgPR5-X5mZxDkOjLdFuc=vG10qK@mail.gmail.com> <1fb6fc37cd0f017043d5c124bca4bb1a@secure211.sgcpanel.com> <AANLkTi=4J5u4SEh5jSPxObceWdAom51R+H_j8oApG5PG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=4J5u4SEh5jSPxObceWdAom51R+H_j8oApG5PG-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, 5 Sep 2010 14:42:51 +0800, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> issue #1:(musb device not work with cable connected with PC)
>         -twl->asleep is set as zero in .probe since bootloader has not
> powerdown phy
>         -EVENT_VBUS returned from twl4030_usb_linkstat since usb cable
> is connected with PC
>         -twl4030_phy_resume is called but does nothing since
> twl->asleep is zero
>         -the following are not called to initialize otg phy:
>                  twl4030_phy_power / twl4030_i2c_access /
>                  twl4030_usb_set_mode
>         -so musb device mode does not work

ok, I see. So what you could do is enable regulators on probe
based on PHYPWR bit.

> Sorry for disturbing you, hope you have a happy moving, :-)

np, tks :-)

> No, .asleep flag is set according to the current link state,
> instead of the initial state of transceiver. I don't think the patch
> will cause break anything. If you think it will, please describe the
> break in detail.

if we revert that patch, you'll see that usb3v1 ldos are left on
if we never plug/unplug usb cable. AFAIR, the reset state of those
LDOs is ON, so that's why we need that patch.

I'll try to work on it monday judging I'll have laptop and HW
available by then.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
