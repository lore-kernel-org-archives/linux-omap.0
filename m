From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Thu, 19 Dec 2013 01:40:11 +0200
Message-ID: <CANOLnOOP8bh2OuajnCE7P-VpSvH_u7-wk5bHuWEfXhALHCBk4w@mail.gmail.com>
References: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
	<20131218153545.GA1593@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131218153545.GA1593-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 18, 2013 at 5:35 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Tue, Dec 17, 2013 at 05:48:33PM +0100, anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org wro=
te:
>> From: Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
>>
>> This is a hard to reproduce problem which leads to non-functional
>> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
>> e25bec160158abe86c276d7d206264afc3646281, which introduces save/rest=
ore
>> of OTG_INTERFSEL over suspend.
>> Since the resume function is also called early in driver init, it us=
es a
>> non-initialized value (which is 0 and a non-supported setting in DM3=
7xx
>> for INTERFSEL). Shortly after the correct value is set. Apparently t=
his
>> works most time, but not always.
>
> yeah, but the problem is not on the glue layer. The bug is omap_devic=
e
> and pm_runtime not agreeing on device's state. I suppose there was a =
fix
> for that recently in linux-omap@vger mailing list.

You mean this: http://marc.info/?t=3D138444882600003&r=3D1&w=3D2 ?

This looks like a different issue during suspend, this problem is at
startup. Both musb_core and omap2430.c expect hardware to be disabled
on startup, and that works as expected. The problem is on first
pm_runtime_get_sync(), which results in first runtime_resume() call,
musb_core checks for first resume and doesn't load yet-unset context
in that case, however glue does and breaks things. We have this
problem since 3.2.


Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
