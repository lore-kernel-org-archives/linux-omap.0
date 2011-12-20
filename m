From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: musb: fix pm_runtime mismatches
Date: Tue, 20 Dec 2011 21:43:45 +0200
Message-ID: <CAMP44s1m9oXpiw506kE6JJn5xO+oCRL8B0UixUf4X=Ew00=wHA@mail.gmail.com>
References: <1323990310-11905-1-git-send-email-felipe.contreras@gmail.com>
	<1323990310-11905-2-git-send-email-felipe.contreras@gmail.com>
	<20111219081137.GF3146@legolas.emea.dhcp.ti.com>
	<CAMP44s2pbLRHB2ko9t-zQEpTFw=TaCS9b_qRmvAobgxeJ9WrCw@mail.gmail.com>
	<20111220111935.GE31842@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111220111935.GE31842-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 20, 2011 at 1:19 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Mon, Dec 19, 2011 at 10:20:09PM +0200, Felipe Contreras wrote:
>> On Mon, Dec 19, 2011 at 10:11 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> > On Fri, Dec 16, 2011 at 01:05:08AM +0200, Felipe Contreras wrote:
>> >> Properly call pm_runtime_put() afer pm_runttime_get() on errors.
>> >>
>> >> Untested.
>> >
>> > sorry, but I'm not applying untested patches. I need someone to give a
>> > Tested-by.
>>
>> I'm pretty sure most people don't test the exit paths, but fine, don't
>> apply them. Who needs power management anyway.
>
> if it wasn't tested you can't claim $SUBJECT makes PM magically work.

It's clear from the code, no need to test to see that pm_runtime_get()
is called but not pm_runtime_put(), thus the device remains active,
thus PM would not work after that.

-- 
Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
