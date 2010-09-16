From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Discussion] USB: musb-gadget: how to fix ZLP issue in musb_g_tx
Date: Thu, 16 Sep 2010 15:03:44 +0400
Message-ID: <4C91F990.5040901@ru.mvista.com>
References: <AANLkTinPVUBNJoOR496KgSy2TT0f6i1f5xEKVhKod2R=@mail.gmail.com> <20100915105641.GO3393@legolas.emea.dhcp.ti.com> <AANLkTi=gYSsxSHqAur+isj_UinVLC-YWkdmi5j_vkSUV@mail.gmail.com> <20100915110745.GP3393@legolas.emea.dhcp.ti.com> <4C90C5B7.7050103@ru.mvista.com> <20100916060520.GA3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100916060520.GA3393-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 16-09-2010 10:05, Felipe Balbi wrote:

>> I don't see what to rework. The last short packet should still satisfy
>> (request->actual == request->length) condition, no?

> of course not, it's short not zero. so the last short packet can be
> anything from 1 to 511 bytes.

    Sigh. Where have I said anything different? What I meant is that the last 
short packet is already counted in request->actual, otherwise the condition 
(request->actual & (musb_ep->packet_sz - 1)) wouldn't work.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
