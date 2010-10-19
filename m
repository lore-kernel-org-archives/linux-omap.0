From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 10:05:33 -0500
Message-ID: <6ea089ac75d4d15d88698468eacb7fe3@secure211.sgcpanel.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com> <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com> <20101019103234.GI31170@legolas.emea.dhcp.ti.com> <AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE@mail.gmail.com> <20101019111613.GJ31170@legolas.emea.dhcp.ti.com> <AANLkTikkMphKa2DGGtWxy-3LpFX0kn92UEYPj==Euzok@mail.gmail.com> <20101019115236.GL31170@legolas.emea.dhcp.ti.com> <AANLkTim3NsgjC3Nh8VCCrx4cV1Y+kn38=30=en0KCft6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTim3NsgjC3Nh8VCCrx4cV1Y+kn38=30=en0KCft6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

(already at home so using personal email)

On Tue, 19 Oct 2010 17:32:07 +0300, Felipe Contreras
<felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> There are two parts, one part is to fix the Kconfigs, and another was
> to come up with a way to replace the horrible defconfigs. Part two is
> mostly fixed thanks to 'make savedefconfig', since the defconfigs are
> not so horrible any more, but part one is a continued effort.
> 
> For part two Linus had the idea to use Kconfigs instead of defconfigs,
> but they would mostly look very similar to the current ones generated
> by 'make savedefconfig'.
> 
> I don't know what makes you think Linus didn't want part one to be
> done. He wanted the Kconfig.rx51 to be human readable, and you are
> proposing that TWL4030_USB should be manually added there... I don't
> think TWL4030_USB says anything to human beings.

I don't read anywhere Linus saying we should clutter drivers/*/Kconfig
with defaults. I think you're inverting things, it's much better
to select TWL4030_USB when you enable MACH_OMAP_RX51 then default y
if MACH_OMAP_RX51.

> Yes, but how do you get rid of the defconfig while also having a
> working USB_G_NOKIA? Somehow a transceiver should be automatically
> selected.

and you do that selection when the board is enabled otherwise the
drivers Kconfig will be cluttered with default Y if blabla.

But like I said before, it's Greg's ball. Personally, I think
you're taking the wrong approach.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
