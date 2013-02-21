From: Tom Rini <trini@ti.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 14:18:31 -0500
Message-ID: <51267307.90903@ti.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <5125A1FE.5000604@wwwdotorg.org> <CAD=GYpZM7uOHqhwhxzokV161WFZ2azh1VpSBn498PmPZm+bYbQ@mail.gmail.com> <51266E6B.8040509@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <51266E6B.8040509@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On 02/21/2013 01:58 PM, Stephen Warren wrote:
> On 02/21/2013 12:15 AM, Joel A Fernandes wrote:
>> On Wed, Feb 20, 2013 at 10:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 02/20/2013 06:37 PM, Joel A Fernandes wrote:
>>>> Hello,
>>>> I've been spinning some work-in-progress patches for FIT build support
>>>> in the kernel.
>>>> With the move to multiplatform support on OMAP, I feel it is a good
>>>> time to add  FIT support, also looking at the proliferating number of
>>>> dtbs, as it is a nice way
>>>
>>> To my mind, FIT is pointless. And forcing the kernel build process to
>>
>> I don't think so, there are many usecases for FIT and cleanly
>> embedding DTBs is a common usecase, (along with stronger checksums,
>> compression). That is also the basis of my ELC talk tomorrow morning
>> ;-)
>> You could peruse the slides at, http://wwwelinux.org/Fit-boot to get a
>> better understanding of what FIT solves. With the move to
>> multiplatform kernels, it is quite a logical next step to add this
>> support to the kernel build.
>>
>>> create bootloader-specific files doesn't seem like a good idea. Doing so
>>> would require pulling in even more outside tools into the kernel build flow.
>>
>> As for pulling additional tools, dtc is already a part of the kernel
>> so the idea is to use existing tools.
> 
> Well, dtc won't be part of the kernel build process for ARM at least
> once the device tree files are move outside the kernel.

And at that point it would also make sense to move any other "help folks
get things going" tooling happens to exist out of the kernel.

-- 
Tom
