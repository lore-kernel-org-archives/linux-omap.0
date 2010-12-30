From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 02:44:40 -0500
Message-ID: <877heriu1j.fsf@gmail.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com> <87hbe41kbd.fsf@gmail.com> <20101227092038.GB2301@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101227092038.GB2301-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Dec 2010 11:20:38 +0200, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Thu, Dec 23, 2010 at 12:16:22PM -0500, Ben Gamari wrote:
> >Is this change slated to go into 2.6.37? As it stands it looks like
> >2.6.37 will be released with completely broken musb support on many boards
> >(including the BeagleBoard).
> 
> yes, it is.
> 
Are you sure? We are currently at -rc8 and yet this patch has yet to
make it into my tree.

- Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
