From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 14:27:37 +0400
Message-ID: <4C909F99.9050300@mvista.com>
References: <20100914065604.GD2601@legolas.emea.dhcp.ti.com> <4C8F527E.40408@ru.mvista.com> <20100914105402.GD7554@legolas.emea.dhcp.ti.com> <4C8FB60D.1080906@ru.mvista.com> <20100915065345.GC3393@legolas.emea.dhcp.ti.com> <4C909961.10001@ru.mvista.com> <20100915100553.GJ3393@legolas.emea.dhcp.ti.com> <4C909B2E.3000909@ru.mvista.com> <AANLkTi=A+1ThrRTNjWoFbXr-G1OUnpThEwG5rCgGirzC@mail.gmail.com> <4C909D87.2090901@ru.mvista.com> <20100915102256.GK3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100915102256.GK3393-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 15.09.2010 14:22, Felipe Balbi wrote:

>> I don't see why we should fix only this problem, while it's obvious tha
>> the fix is incomplete and leaves the other problem exposed. Please recast the
>> patch.

> IMO, the ZLP fix is *another* fix and as such subject to a different
> patch.

    IMHO, this fix as it is now is quite stupid. It's clear that the check is 
misplaced and will be removed once the ZLP fix is done. So why not do it once 
and for all? Is it so hard to do? FWIW, I NAK this patch as it is now.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
