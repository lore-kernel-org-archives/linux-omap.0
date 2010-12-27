From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Mon, 27 Dec 2010 11:20:38 +0200
Message-ID: <20101227092038.GB2301@legolas.emea.dhcp.ti.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
 <87hbe41kbd.fsf@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87hbe41kbd.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 23, 2010 at 12:16:22PM -0500, Ben Gamari wrote:
>On Fri,  3 Dec 2010 23:42:45 +0530, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> wrote:
>> As the control.h have been moved to new location and it's
>> uses are not allowed to drivers directly so moving the phy
>> control, interrupt clear and reset functionality to board
>> files.
>>
>Is this change slated to go into 2.6.37? As it stands it looks like
>2.6.37 will be released with completely broken musb support on many boards
>(including the BeagleBoard).

yes, it is.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
