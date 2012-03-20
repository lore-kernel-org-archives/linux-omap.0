From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 16:21:18 +0530
Message-ID: <CAP05o4+tjD__yr-vgq29QpUUCAxgqSJiGW0ibVn2CFQU_3y+bw@mail.gmail.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
	<20120319100603.GB20279@arwen.pp.htv.fi>
	<CAP05o4LkWpANqibBXsY-FbCTOsioUq4qPdA8k=Ct4HHGYfL4Ng@mail.gmail.com>
	<20120320095914.GE9157@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120320095914.GE9157-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 20, 2012 at 3:29 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Tue, Mar 20, 2012 at 03:00:50PM +0530, Munegowda, Keshava wrote:
>> >> +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>");
>> >> +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
>> >> +MODULE_LICENSE("GPL v2");
>> >> +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI con=
trollers");
>> >> +
>> >> +static int __init omap_usbtll_drvinit(void)
>> >> +{
>> >> + =A0 =A0 return platform_driver_probe(&usbtll_omap_driver, usbtl=
l_omap_probe);
>> >
>> > please don't. Make sure you use platform_driver_register, instead.
>>
>>
>> Here , omap_usbtll_drvinit is registered through fs_initcall call;
>> this is required because, the TLL driver is required to initialized
>> before the UHH ( usb host core) driver.
>
> no issues with fs_initcall. The issue is with platform_driver_probe()
> only.
>
> --
> balbi

Thanks , I got it.
I will take the same comment make the same change in usbhs driver too;

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
