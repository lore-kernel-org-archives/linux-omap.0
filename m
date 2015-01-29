From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Wed, 28 Jan 2015 21:58:42 -0600
Message-ID: <54C9AFF2.6000108@ti.com>
References: <1421269101-51105-2-git-send-email-s-anna@ti.com> <20150115135201.GG16217@leverpostej> <20150115135556.GH16217@leverpostej> <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com> <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com> <20150116101746.GA21809@leverpostej> <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com> <20150120180548.GK7718@atomide.com> <CAK=WgbZGGtwmQwzWumjpYOsYHTt8vPQpTraABwJBsv5VXOmJ_Q@mail.gmail.com> <54BFE855.3090200@ti.com> <20150122185622.GE12911@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122185622.GE12911@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/22/2015 12:56 PM, Mark Rutland wrote:
> On Wed, Jan 21, 2015 at 05:56:37PM +0000, Suman Anna wrote:
>> On 01/21/2015 06:41 AM, Ohad Ben-Cohen wrote:
>>> On Tue, Jan 20, 2015 at 8:05 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> How about default to Linux id space and allow overriding that with
>>>> a module param option if needed?
>>>
>>> I'm not sure I'm following.
>>>
>>> If the main point of contention is the base_id field, I'm also fine
>>> with removing it entirely, as I'm not aware of any actual user for it
>>> (Suman please confirm?).
>>
>> Yeah, well the current implementations that I am aware of only have a
>> single bank, so all of them would be using a value of 0. I am yet to see
>> a platform with multiple instances where the property really makes a
>> difference. v7 has the property mandatory, so all the implementations
>> would need to define this value even if it is 0.
>>
>> regards
>> Suman
>>
>>>
>>> Mark? Rob? Will you accept Suman's patches if the base_id field is removed?
> 
> My concern is that the mapping of hwspinlock IDs doesn't seem to be
> explicit in the DT on a per-context basis, which is what I'd expect.
> 
> e.g.
> 
> lck: hwspinlock-device@f00 {
> 	...
> 	#hwlock-cells = <1>;
> };
> 
> some-other-os-interface {
> 	...
> 	hwlocks = <&lck 0>, <&lck 1>, <&lck 2>, <&lck 3>;
> 	hwlock-names = "glbl", "pool0", "pool1", "pool2";
> };
> 
> a-different-os-interface {
> 	...
> 	hwlocks = <&lck 18>, <&lck 21>, <&lck 4>, <&lck 5>;
> 	hwlock-names = "init", "teardown", "pool0", "pool1";
> };
> 
> That's the only way I would expect this to possibly remain a stable
> over time, and it's the entire reason for #hwlock-cells, no?
> 
> How do you expect the other components sharing the hwspinlocks to be
> described?

Yes indeed, this is what any of the clients will use on Linux. But this is not necessarily the semantics for exchanging hwlocks with the other processor(s) which is where the global id space comes into picture.

regards
Suman

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
