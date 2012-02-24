From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 4/8] misc: emif: add basic infrastructure for EMIF
 driver
Date: Fri, 24 Feb 2012 12:16:01 +0100
Message-ID: <4F477171.8010605@ti.com>
References: <1328357771-31644-1-git-send-email-aneesh@ti.com> <1328357771-31644-5-git-send-email-aneesh@ti.com> <4F3D2F2F.8050406@ti.com> <4F47701C.2090305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F47701C.2090305@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On 2/24/2012 12:10 PM, Aneesh V wrote:
> On Thursday 16 February 2012 10:00 PM, Cousson, Benoit wrote:
>> Hi Aneesh,
>>
>
> [...]
>
>>> +struct emif_data {
>>> + u8 duplicate;
>>> + u8 temperature_level;
>>> + u32 irq;
>>> + spinlock_t lock; /* lock to prevent races */
>>
>> Nit: That comment is useless, since you already have the kerneldoc
>> comment before.
>
> Now I remember why I did that. Without that comment checkpatch gives
> this "check".
>
> CHECK: spinlock_t definition without comment
> #124: FILE: drivers/misc/emif.c:54:
> + spinlock_t lock;

That's a pretty interesting comment :-)
I guess checkpatch should be able to check for a potential kerneldoc as 
well. You might want to report that to the checkpatch maintainer.

Thanks,
Benoit
