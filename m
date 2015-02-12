From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 2/2] remoteproc: add support to handle internal memories
Date: Thu, 12 Feb 2015 14:54:55 -0600
Message-ID: <54DD131F.8040704@ti.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com> <1420838519-15669-3-git-send-email-s-anna@ti.com> <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com> <20150211205757.GI2531@atomide.com> <CAK=WgbbFxNfn5tUeJn-8NehFXAD+=7UW-WtBf3ZFm1xyomFAfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbbFxNfn5tUeJn-8NehFXAD+=7UW-WtBf3ZFm1xyomFAfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Robert Tivy <rtivy@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 02/12/2015 03:09 AM, Ohad Ben-Cohen wrote:
> On Wed, Feb 11, 2015 at 10:57 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>> +static int rproc_handle_intmem(struct rproc *rproc, struct fw_rsc_intmem *rsc,
>>>> +                              int offset, int avail)
>>>> +{
>>> ...
>>>> +       va = (__force void *)ioremap_nocache(rsc->pa, rsc->len);
>>>
>>> Back in the days when we developed remoteproc there was a tremendous
>>> effort to move away from ioremap when not strictly needed.
>>
>> The use of ioremap in general is just fine for drivers as long
>> as they access a dedicated area to the specific device. Accessing
>> random registers and memory in the SoC is what I'm worried about.
> 
> Yes, the proposed interface essentially allows exactly this random
> access, since the parameters to ioremap would be provided from the
> user space (specifically from the resource table contained within the
> firmware of the remote processor).

My original motivation was that it would only need to be added on
firmwares requiring support for loading into internal memories,
otherwise, these are something left to be managed by the software
running on the remote processor completely, and MPU will not even touch
them.

So, let me know if this is a NAK. If so, we have two options - one to go
the sram node model where each of them have to be defined separately,
and have a specific property in the rproc nodes to be able to get the
gen_pool handles. The other one is simply to define these as <reg> and
use devm_ioremap_resource() (so use DT for defining the regions instead
of a resource table entry).

regards
Suman
