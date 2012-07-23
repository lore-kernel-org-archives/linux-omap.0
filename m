From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Mon, 23 Jul 2012 16:57:41 +0530
Message-ID: <CAP05o4+EpEtP52Bf96qEiH2r+g6yf6hhaO+BENdPdkwJmqUK9A@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<87vcij1loh.fsf@ti.com>
	<CAP05o4+6LxwdwCUQF_0b6dCQ9JQarNeUBzO=qgdUgnreMtDeMg@mail.gmail.com>
	<500D0C42.8030508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <500D0C42.8030508-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 23, 2012 at 2:03 PM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On 06/22/2012 05:43 PM, Munegowda, Keshava wrote:
>> On Fri, Jun 22, 2012 at 7:41 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>>> "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>>>
>>> [...]
>>>
>
>>>
>>> You are not reading what I write.
>>>
>>> To repeat: your patch fixes the oops during boot, and the suspend hang
>>> and now I see CORE hit retention in *suspend*.
>>
>> thanks !
>>
>>>
>>> However,  CORE does still not hit retention during *idle*.
>>
>> here is the problem.
>>
>> usb host retention in idle is not supported till now.
>> in current code, usb host cuts clock only in driver suspend not in bus
>> suspend ( auto suspend).
>> usb host driver need to use the  io daisy chain framework through io wakeup.
>> I will post the patches once ehci remote wakeup features stabilized in
>> omap3, omap4 and omap5 too.
>>
>
> We are talking about CORE retention support during idle. How is IO daisy
> chaining related to that? Doesn't IO daisy chain only apply when device
> hits OFF?

when we see the usb bus suspend, then we disable the clocks of usb host to
enable to enable the retention in cpu idle; since we have disabled the clock of
usb host , we will not see the device connection at the controller
level, instead
the irq chain handler can detect it and corresponding irq can set the clocks.
this  same use case holds good for device OFF too.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
