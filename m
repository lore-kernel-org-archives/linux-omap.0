From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH] drivers: phy: add generic PHY framework
Date: Mon, 17 Sep 2012 11:19:53 +0530
Message-ID: <CAAe_U6KvnXf7v47tVv4LYFUXjKQip7V_1FU6ujqcpoxu8QfMgw@mail.gmail.com>
References: <1347623899-14485-1-git-send-email-kishon@ti.com>
	<F281D0F91ED19E4D8E63A7504E8A649803C82462@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C82462-RL0Hj/+nBVC81RJBUSuqCa4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhao Richard-B20223 <B20223-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Sep 17, 2012 at 6:50 AM, Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>
>>
>> The PHY framework provides a set of API's for the PHY drivers to
>> create/remove a PHY and the PHY users to obtain a reference to the PHY
>> using or without using phandle. If the PHY users has to obtain a
>> reference to
>> the PHY without using phandle, the platform specfic intialization code
>> (say
>> from board file) should have already called phy_bind with the binding
>> information. The binding information consists of phy's device name, phy
>> user device name and an index. The index is used when the same phy user
>> binds to mulitple phys.
>>
>
> What's an example of "the same phy user binds to multiple phys"?

Single controller using multiple phys..
> I only remembered that Felipe said there are two phy users for one single phy at
> omap5 that is both usb3 and sata uses the same phy.

*index* is used when a single controller uses multiple phys. For
example it could be used for dwc3 (usb3 controller) where it uses usb2
phy and usb3 phy.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
