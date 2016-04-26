From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 0/4] OMAP Mailbox legacy platform device support removal
Date: Tue, 26 Apr 2016 12:06:42 -0500
Message-ID: <571FA022.9010207@ti.com>
References: <1459964260-43054-1-git-send-email-s-anna@ti.com>
 <CABb+yY3bsVu9DNwhdCNyan1RH-REjmCWqXP2jvMqpYd-kQaa=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABb+yY3bsVu9DNwhdCNyan1RH-REjmCWqXP2jvMqpYd-kQaa=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/25/2016 11:55 PM, Jassi Brar wrote:
> On Wed, Apr 6, 2016 at 6:37 PM, Suman Anna <s-anna@ti.com> wrote:
>> Hi Jassi,
>>
>> This series cleans up the OMAP Mailbox driver dropping the
>> support for legacy non-DT platform devices. The infrastructure
>> for creating any such devices has all been cleaned up from the
>> mach-omap2 layers.
>>
>> The removal from the driver is accomplished in patch 1, while the
>> remaining patches do some minor checkpatch fixes.
>>
>> Patches baselined on 4.6-rc2.
>>
> Applied this and the next patchset, with a trivial cleanup
> 
> - #define MBOX_INTR_CFG_TYPE1            (0)
> - #define MBOX_INTR_CFG_TYPE2            (1)
> + #define MBOX_INTR_CFG_TYPE1            0
> + #define MBOX_INTR_CFG_TYPE2            1
> 
> Thanks.

Thanks Jassi.

regards
Suman
