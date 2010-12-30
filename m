From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 14:27:38 +0200
Message-ID: <20101230122738.GB3714@legolas.emea.dhcp.ti.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
 <87hbe41kbd.fsf@gmail.com>
 <20101227092038.GB2301@legolas.emea.dhcp.ti.com>
 <877heriu1j.fsf@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877heriu1j.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 30, 2010 at 02:44:40AM -0500, Ben Gamari wrote:
>On Mon, 27 Dec 2010 11:20:38 +0200, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> On Thu, Dec 23, 2010 at 12:16:22PM -0500, Ben Gamari wrote:
>> >Is this change slated to go into 2.6.37? As it stands it looks like
>> >2.6.37 will be released with completely broken musb support on many boards
>> >(including the BeagleBoard).
>>
>> yes, it is.
>>
>Are you sure? We are currently at -rc8 and yet this patch has yet to
>make it into my tree.

Yes. The patch is waiting for the merge window, check linux-next or
Greg's usb-next branch.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
