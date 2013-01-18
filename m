From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] USB: Add multiple PHYs of same type
Date: Fri, 18 Jan 2013 17:24:59 +0530
Message-ID: <50F93813.4010107@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <20130118114859.GC4379@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130118114859.GC4379-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 18 January 2013 05:18 PM, Felipe Balbi wrote:
> On Wed, Jan 16, 2013 at 08:30:56PM +0530, Kishon Vijay Abraham I wrote:
>> New platforms are being added which has multiple PHY's (of same type) and
>> which has multiple USB controllers. The binding information has to be
>> present in the PHY library (otg.c) in order for it to return the
>> appropriate PHY whenever the USB controller request for the PHY. So
>> added a new API to pass the binding information. This API should be
>> called by platform specific initialization code.
>>
>> So the binding should be done something like
>> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying the USB
>> controller device name, index, and the PHY device name.
>> I have done this binding for OMAP platforms, but it should be done for
>> all the platforms.
>>
>> After this design, the phy can be got by passing the USB controller device
>> pointer and the index.
>>
>> Developed this patch series on
>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
>> after applying "usb: musb: add driver for control module" patch series.
>>
>> Did basic enumeration testing in omap4 panda, omap4 sdp and omap3 beagle.
>
> please resend without RFC so I can apply.

I'll resend after addressing Roger's comments in a while.

Thanks
Kishon
