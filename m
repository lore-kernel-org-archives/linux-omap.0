From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Thu, 27 Jan 2011 07:31:23 -0500
Message-ID: <877hdq8r50.fsf@gmail.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com> <87fwsqm3b2.fsf@gmail.com> <87k4hu8fvx.fsf@gmail.com> <20110127044810.GJ2429@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110127044810.GJ2429-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 27 Jan 2011 06:48:10 +0200, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> sorry, quite busy at the moment, but here's one answer. Check this
> commit:
> 
> commit a9c037832e9624e240c5019d0e01e9352e8f638d
> ...

Thanks for the reply! So I take it that omap's usb_musb_init takes care
of all of the new *_board_data fields now and therefore no board changes
are necessary?

Thanks,

- Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
