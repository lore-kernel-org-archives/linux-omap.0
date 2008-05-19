From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 0/2] MUSB: 2 patches to fix some bug found on Blackfin
Date: Mon, 19 May 2008 02:49:54 -0500
Message-ID: <71636ee466dd53c366eb11d8fc981e8b@felipebalbi.com>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org> <200805170737.37806.david-b@pacbell.net> <386072610805182339n2e141b83q4b8f9804194088e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <386072610805182339n2e141b83q4b8f9804194088e4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Mon, 19 May 2008 14:39:10 +0800, "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, May 17, 2008 at 10:37 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> wrote:
>> On Saturday 17 May 2008, Bryan Wu wrote:
>>>
>>> We discussed these 4 bugs before. Now we fixed them.
>>> Please review following 2 patches.
>>
>> They looked plausible to me ... though the urb->status
>> one is a bit of a band-aid, and when that field finally
>> vanishes a better fix will be needed.
>>
> 
> OK, so is there any plan for merge the MUSB to mainline and finally to
> remove the urb->status?

I was planing to do this by the end of this year or as soon as I make all
usb if tests pass again. I'm out of tools for that right now :-s

But of course we can check this with more caution since we have this bug
to solve before sending it to mainline.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
