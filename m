From: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mfd: Fix usbhs_enable error handling
Date: Tue, 26 Apr 2011 08:09:17 -0700
Message-ID: <BANLkTi=NB5as-Kz8bSCvh3=KPQR1wwXUOQ@mail.gmail.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
	<20110426085846.GI13227@legolas.emea.dhcp.ti.com>
	<3a59290ed8ab560ac9b85fd1f4d5acd4@mail.gmail.com>
	<20110426090418.GJ13227@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110426090418.GJ13227-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2011 at 2:04 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Tue, Apr 26, 2011 at 02:32:04PM +0530, Keshava Munegowda wrote:
>> > -----Original Message-----
>> > From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
>> > Sent: Tuesday, April 26, 2011 2:29 PM
>> > To: Keshava Munegowda
>> > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org;
>> gadiyar-l0cyMroinI0@public.gmane.org; p-
>> > basak2-l0cyMroinI0@public.gmane.org; axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org;
>> mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
>> > Subject: Re: [PATCH] mfd: Fix usbhs_enable error handling
>> >
>> > Hi,
>> >
>> > On Thu, Apr 21, 2011 at 07:52:41PM +0530, Keshava Munegowda wrote:
>> > > From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > >
>> > > In the case of missing platform_data we do not hold a spin_lock,
>> > > thus we should not call spin_unlock_irqrestore in the error path.
>> > >
>> > > Also simplify the error handling by separating the successful path
>> > > from error path. I think this change improves readability.
>> > >
>> > > Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >
>> > Can someone give me a Tested-by so I can take these patches.
>> >
>> > --
>> > Balbi
>>
>> Hi Balbi
>>
>> I have validated this patch and it works :)
>>
>> Tested-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>
> what about the others ?
>
> --
> balbi

Hi Felipe,

I responded on another thread. I tested this on a beagleboardxm on
version 2.6.39-rc4

> Hi Keshava,
>
> I rebuilt my system to boot from flash and now I see what happened. I
> even remember it being discussed on this list. Someone renamed my usb
> ethernet device from usb0 to eth0 !!! The boot log shows it on this
line:
>
> > [    4.596130] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at
> > usb-ehci-omap.0d
>
>
> So this broke my init scripts and uboot script... OK, so I can live with
> this (I hope the name doesn't change too often though).
>
> So I can manually configure my system to use eth0 and use the network. I
> am sure I will get nfs working shortly.
>
> I am using the 2.6.39-rc4 with your 3 patches. So from the Beagleboard
> XM perspective it works and you can include my
>
> Tested-by: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
