From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] omap:usb: fixing ehci phy gpio values for omap3
Date: Wed, 27 Apr 2011 13:56:26 +0530
Message-ID: <BANLkTinSOsc-La_RaND+QjvBTpxCc0KsNg@mail.gmail.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
	<1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
	<BANLkTi=fQCRAST1DvJEAnznNnySCv55Yag@mail.gmail.com>
	<BANLkTi=apB0cZpgzFjHKuArrxkQX5W7deQ@mail.gmail.com>
	<20110427075843.GS13227@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110427075843.GS13227-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 27, 2011 at 1:28 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Wed, Apr 27, 2011 at 11:22:03AM +0530, Munegowda, Keshava wrote:
>> > Dumb q2: is'nt it better to introduce polarity e.g.
>> > pdata->ehci_data->reset_gpio_polarity etc? this will allow board files
>> > to describe polarity of pin information to driver which can then be
>> > Phy and any board specific mods(e.g. inverter on the line) independent
>> > completely..
>>
>> yes, I am thinking of doing it; since it requires modification of all
>> board files;
>> I will send this an another separate patch.
>
> Sure, for next merge window.
>
> --
> balbi

yes balbi,
I will do this patch after the rebaseing and validating the runtime pm
patches to latest mainline kernel

keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
