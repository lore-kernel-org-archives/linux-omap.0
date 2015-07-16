From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 2/6] ARM: AM43xx: Add the PRM IRQ register offsets
Date: Thu, 16 Jul 2015 10:46:43 +0530
Message-ID: <55A73E3B.1010705@ti.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com> <1436334148-9309-3-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.02.1507160208400.32764@utopia.booyaka.com> <alpine.DEB.2.02.1507160237280.32764@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1507160237280.32764@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com
List-Id: linux-omap@vger.kernel.org



On Thursday 16 July 2015 08:08 AM, Paul Walmsley wrote:
> On Thu, 16 Jul 2015, Paul Walmsley wrote:
>
>> On Wed, 8 Jul 2015, Keerthy wrote:
>>
>>> Add the PRM IRQ register offsets.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>
>> Please add more detail to your commit messages so they conform to
>> Documentation/SubmittingPatches:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n109
>>
>> For example, this commit message should read something like:
>>
>> ---
>>
>> ARM: AM43xx: Add the PRM IRQ register offsets
>>
>> Add the PRM IRQ register offsets.  This is needed to support PRM I/O
>> wakeup on AM43xx.
>>
>> --
>>
>> Basically, your patches need to provide context as to _why_ the change is
>> needed.
>>
>> I've fixed the message for this patch, and queued it for v4.3, but
>> please take care with this issue in the future.
>
> Also I've moved the AM43XX_PRM_IO_PMCTRL_OFFSET macro out of the AM43XX CM
> section, since it doesn't belong there.

Thanks Paul!

>
>
> - Paul
>
