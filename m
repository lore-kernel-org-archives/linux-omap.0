From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Mon, 2 Feb 2015 15:07:42 -0600
Message-ID: <54CFE71E.20905@ti.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>	<1421269101-51105-2-git-send-email-s-anna@ti.com>	<20150115135201.GG16217@leverpostej>	<20150115135556.GH16217@leverpostej>	<CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>	<CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>	<20150116101746.GA21809@leverpostej>	<CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>	<CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>	<CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com> <CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/01/2015 11:55 AM, Bjorn Andersson wrote:
> On Fri, Jan 30, 2015 at 9:41 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
>> On Sat, Jan 31, 2015 at 1:29 AM, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org> wrote:
>>> In a system where you have two hwlock blocks lckA and lckB, each
>>> consisting of 8 locks and you have dspB that can only access lckB
>>
>> This is a good example - thanks. To be able to cope with such cases we
>> will have to pass a hwlock block reference and its relative lock id.
>>
> 
> Correct, so the #hwlock-cells and hwlock part from the proposal are
> the important one. Having an optional hwlock-names will make things
> easier to read as well, but is not necessary.

Right, if anything, it would be useful only for the clients, but the
hwspinlock core itself would not need it. So, I would forgo adding the
hwlock-names for now.

> 
>> The DT binding should definitely be prepared for such cases (just kill
>> the base-id field?), but let's see what it means about the Linux
>> implementation.
>>
> 
> From the dt binding PoV, we should be able to skip num-locks as well.
> It seems most hwlock blocks have a fixed amount of locks provided and
> the drivers are reporting this to the core when registering.

I added this originally based on the initial MSM HW Mutex block bindings.

> 
> So I think we can reduce the binding to:
> 
> Providers:
> #hwlock-cells
> 
> Consumers:
> hwlocks
> hwlock-names
> 
> For the hardware where number of locks is actually variable (e.g.
> different variants of same block) there can be driver specific entries
> for this.

Right, we should be able to drop this and use the driver match data. As
it is, the field is used during registration of the block with the
hwspinlock core.

regards
Suman
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
