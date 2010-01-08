From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [RFC/PATCH 1/2] usb_otg: compile fix
Date: Fri, 8 Jan 2010 07:57:19 +0200
Message-ID: <20100108055719.GA7995@gandalf>
References: <1262912592-7817-1-git-send-email-alecrim@gmail.com>
 <20100108054302.GA7683@gandalf>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100108054302.GA7683@gandalf>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: Francisco Alecrim <alecrim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Francisco Alecrim <francisco.alecrim-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jan 08, 2010 at 07:43:09AM +0200, Felipe Balbi wrote:
> On Thu, Jan 07, 2010 at 09:03:11PM -0400, Francisco Alecrim wrote:
> > From: Francisco Alecrim <francisco.alecrim-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
> > 
> > include/linux/usb.h: In function 'usb_mark_last_busy':
> > include/linux/usb.h:561: error: 'struct usb_device' has no member named
> > 'last_busy'
> > 
> > Option USB_OTG selects USB_SUSPEND but doesn't select PM(required by
> > USB_SUSPEND) causing this compile error. Putting USB_SUSPEND as
> > USB_OTG depend ensure that PM is selected.
> > 
> > Signed-off-by: Francisco Alecrim <francisco.alecrim-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
> 
> should go to linux-usb@vger

my bad, it's already in Cc.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
