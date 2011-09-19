From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/5 v9] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Mon, 19 Sep 2011 19:22:08 +0200
Message-ID: <4E777A40.20508@ti.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com> <20110919135653.GR32263@sortiz-mobl> <CAP05o4+AYs07JLio7NgSUOuzSTqiZA45WPDPqAB55u=02vHYWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP05o4+AYs07JLio7NgSUOuzSTqiZA45WPDPqAB55u=02vHYWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "parthab@india.ti.com" <parthab@india.ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Keshava,

On 9/19/2011 4:01 PM, Munegowda, Keshava wrote:
> On Mon, Sep 19, 2011 at 7:26 PM, Samuel Ortiz<sameo@linux.intel.com>  wrote:
>> Hi Keshava,
>>
>> On Thu, Sep 15, 2011 at 06:52:45PM +0530, Keshava Munegowda wrote:
>>> From: Keshava Munegowda<Keshava_mgowda@ti.com>
>>>
>>> The Hwmod structures and Runtime PM features are implemented
>>> For EHCI and OHCI drivers of OMAP3 and OMAP4.
>>> The global suspend/resume of EHCI and OHCI
>>> is validated on OMAP3430 sdp board with these patches.
>>>
>>> these patches are rebased to kevin's pm branch and
>>> usbhs latest mainline kernel patches
>>
>> I'm ready to apply this one to my MFD for-next branch. Or do you want it to go
>> through Kevin's tree ?
>>
>> Cheers,
>> Samuel
>
>
> Thanks samuel;
> But, patch 1 and 2 requires benoit causson's ack by;
> so , I am waiting for benoit response on this.

I made a couple of comments in the v8, and you did address only half of 
them. It will be nice to at least answer the remaining points.

Moreover, Paul is the maintainer of the OMAP3 hwmod data file.

Regards,
Benoit
