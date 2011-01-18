From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Tue, 18 Jan 2011 14:15:13 -0500
Message-ID: <87fwsqm3b2.fsf@gmail.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291623211-959-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon,  6 Dec 2010 13:43:31 +0530, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
> As the control.h have been moved to new location and it's
> uses are not allowed to drivers directly so moving the phy
> control, interrupt clear and reset functionality to board
> files.
> 
What happened to the board changes for board-am3517evm? This patch
_really_ needs to include the necessary changes to a board. So far this
change has already been handled very sloppily (i.e. 2.6.37 was released
with am35x support that doesn't even build, much less function). If we
continue with this patch as proposed, not only will board maintainers
have absolutely no idea why USB isn't working in 2.6.38, but once they
are lucky enough to stumble upon the reason they will have no idea how
to fix the problem, having no template to work from.

As I understand it, this patch has already been merged into mmotm. Can
we please get a new version of this patch or even just a patch on top of
this modifying one of the boards to accomodate this change so that the
rest of us have some idea how to proceed?

Thanks,

- Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
