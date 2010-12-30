From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 18:04:21 +0200
Message-ID: <20101230160421.GA2236@legolas.emea.dhcp.ti.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
 <87hbe41kbd.fsf@gmail.com>
 <20101227092038.GB2301@legolas.emea.dhcp.ti.com>
 <877heriu1j.fsf@gmail.com>
 <20101230122738.GB3714@legolas.emea.dhcp.ti.com>
 <874o9vnw4h.fsf@gmail.com>
 <AANLkTinE9Dgz9nCFv-1d=DdF22OEXSYn16s7krxo3CGp@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinE9Dgz9nCFv-1d=DdF22OEXSYn16s7krxo3CGp-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anca Emanuel <anca.emanuel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 30, 2010 at 05:24:05PM +0200, Anca Emanuel wrote:
>On Thu, Dec 30, 2010 at 5:00 PM, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Thu, 30 Dec 2010 14:27:38 +0200, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>>> Yes. The patch is waiting for the merge window, check linux-next or
>>> Greg's usb-next branch.
>>>
>> So I guess no working USB in 2.6.37 in that case?
>
>You can ask Greg to make an pull request, or mail Linus directly.
>It is an driver, and Linus will accept patches that makes drivers work.

Don't do that. I'll back port the changes to 2.6.37-stable. If you do
any such thing you'll break the changes which are on Greg's queue. Sorry

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
