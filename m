From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v7 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Thu, 5 Feb 2015 15:01:06 -0800
Message-ID: <CAJAp7OiHfaMrVqaZ1r6ZN0aMMpE4OUnvLhODHQJeb6EJMa+o8A@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
	<1421269101-51105-2-git-send-email-s-anna@ti.com>
	<20150115135201.GG16217@leverpostej>
	<20150115135556.GH16217@leverpostej>
	<CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
	<CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
	<20150116101746.GA21809@leverpostej>
	<CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
	<CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
	<CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
	<CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA@mail.gmail.com>
	<54CFE71E.20905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54CFE71E.20905@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robherring2@gmail.com>, Kumar Gala <galak@codeaurora.org>, Josh Cartwright <joshc@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 2, 2015 at 1:07 PM, Suman Anna <s-anna@ti.com> wrote:
> On 02/01/2015 11:55 AM, Bjorn Andersson wrote:
>> On Fri, Jan 30, 2015 at 9:41 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> On Sat, Jan 31, 2015 at 1:29 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
>>>> In a system where you have two hwlock blocks lckA and lckB, each
>>>> consisting of 8 locks and you have dspB that can only access lckB
>>>
>>> This is a good example - thanks. To be able to cope with such cases we
>>> will have to pass a hwlock block reference and its relative lock id.
>>>
>>
>> Correct, so the #hwlock-cells and hwlock part from the proposal are
>> the important one. Having an optional hwlock-names will make things
>> easier to read as well, but is not necessary.
>
> Right, if anything, it would be useful only for the clients, but the
> hwspinlock core itself would not need it. So, I would forgo adding the
> hwlock-names for now.
>
>>
>>> The DT binding should definitely be prepared for such cases (just kill
>>> the base-id field?), but let's see what it means about the Linux
>>> implementation.
>>>
>>
>> From the dt binding PoV, we should be able to skip num-locks as well.
>> It seems most hwlock blocks have a fixed amount of locks provided and
>> the drivers are reporting this to the core when registering.
>
> I added this originally based on the initial MSM HW Mutex block bindings.
>

It's not entirely correct to have this in DT for the MSM HW, as the
hardware has a fixed number of mutexes. As soon as we have the binding
sorted out I will follow up with a new revision of the tcsr/sfpb-mutex
driver.

>>
>> So I think we can reduce the binding to:
>>
>> Providers:
>> #hwlock-cells
>>
>> Consumers:
>> hwlocks
>> hwlock-names
>>
>> For the hardware where number of locks is actually variable (e.g.
>> different variants of same block) there can be driver specific entries
>> for this.
>
> Right, we should be able to drop this and use the driver match data. As
> it is, the field is used during registration of the block with the
> hwspinlock core.
>

If we have certain systems where it actually is a property to be
configured then they can have individual properties, extending the
standard set. Either way, it's not a dynamic property shared by all
hwlock drivers, so it should not be in the common binding.

Will you send out a new revision of the binding? I would love to get
this integrated so I can move on with the dependents.

Regards,
Bjorn
