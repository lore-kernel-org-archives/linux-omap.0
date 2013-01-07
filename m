From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: multi phy support
Date: Mon, 7 Jan 2013 18:02:06 +0530
Message-ID: <50EAC046.2020405@ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93EA7FDA7@DBDE01.ent.ti.com> <20130107120040.GD11232@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130107120040.GD11232-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 07 January 2013 05:30 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Jan 07, 2013 at 12:57:15PM +0100, Mohammed, Afzal wrote:
>> AM335x SoC's used in boards like beagle bone has two instances of USB
>> modules (2.0) at the hardware level, each having a dedicated phy.
>> Currently in mainline, only one instance of USB is supported
>> (including a fix in your latest pull request). To support multi
>> instance, the biggest obstacle is lack of multi phy support for
>> usb phy's of same type.
>>
>> Earlier Kishon was working on usb phy device tree support, later it was
>> seen that generic phy layer was preferred. And Kishon posted a couple of
>> versions on generic phy framework, latest being on 26th September 2012,
>> but I could not see follow up's on that series.
>>
>> It seems Kishon is not now working on generic phy support. Let me know
>> your opinion/suggestions on supporting usb phy's of same type. We are
>> trying to get multi USB instance support in mainline for AM335x.
>
> Kishon is still working on generic PHY layer indeed. Right Kishon ?

Yes. I'll try and send it ASAP.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
