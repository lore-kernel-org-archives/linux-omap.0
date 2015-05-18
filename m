From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v3 1/4] remoteproc: introduce rproc_get_by_phandle API
Date: Mon, 18 May 2015 09:33:28 -0500
Message-ID: <5559F838.4010003@ti.com>
References: <1427917039-43206-1-git-send-email-d-gerlach@ti.com> <1427917039-43206-2-git-send-email-d-gerlach@ti.com> <CAK=WgbZCqnMPEnU2992gkOp07BaCP5NJNRO-hLCAdOtUXZGRnQ@mail.gmail.com> <5550C644.4040005@ti.com> <CAK=WgbZGYa-xWE_cxPA1aq50kK2NBdQfhQHX+sPyowky6Syekg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbZGYa-xWE_cxPA1aq50kK2NBdQfhQHX+sPyowky6Syekg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Ohad,
On 05/16/2015 02:18 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Mon, May 11, 2015 at 6:09 PM, Suman Anna <s-anna@ti.com> wrote:
>> On 05/09/2015 02:39 AM, Ohad Ben-Cohen wrote:
>>> On Wed, Apr 1, 2015 at 10:37 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>>> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
>>>> remove the get_by_name/put API") for the ref counting a rproc klist
>>>> code but has rproc_get_by_name replaced with an rproc_get_by_phandle API.
>>>
>>> The general idea makes sense to me, but I'm not sure we really do need
>>> a klist here, since the usage profile of this list is expected to be
>>> super simple: very small number of accessors, looking for small number
>>> of list members a small number of times, and probably never do need to
>>> modify the list while accessing it.
>>>
>>> I suspect that the code would be simpler to maintain, debug and
>>> understand if we just use a simple list with a simple locking
>>> methodology here.
>>
>> The klist usage is something that we restored from previous remoteproc
>> core code as used by the rproc_get_by_name() API. This was removed in
>> commit 40e575b1d0b3 ("remoteproc: remove the get_by_name/put API"). We
>> chose to use the code that had been present before rather than inventing
>> something new all over again. If you feel that a regular list is the way
>> to go forward, we can make the switch.
> 
> Yes, please. Using a regular list with a simple locking methodology
> should make the code easier to understand and debug.

Ok, that makes sense, we can change this. Thanks for your input.

Regards,
Dave

> 
> Thanks,
> Ohad.
> 
