From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: AM4372: Add the wkup_m3_ipc node
Date: Mon, 18 Jan 2016 14:17:47 -0600
Message-ID: <569D486B.6080000@ti.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
 <1437167284-25659-5-git-send-email-d-gerlach@ti.com>
 <20150805103155.GB16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150805103155.GB16878@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,
On 08/05/2015 05:31 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150717 14:10]:
>> From: Suman Anna <s-anna@ti.com>
>>
>> Add the Wakeup M3 IPC device node for the wkup_m3_ipc driver on
>> AM4372 SoC. This node uses the IPC registers, part of the Control
>> Module, and is therefore added as a child of the scm node.
>
> Applying the last two patches in this series into omap-for-v4.3/dt
> thanks.
>
> Probably the send-no-irq quirk you can do in the driver based
> on the compatible flag like I suggested in the related mailbox
> thread so not applying those until that's been discussed.

Now that this compatible flag for the mbox driver has been accepted 
here: 8e3c5952144f ("mailbox/omap: Add ti,mbox-send-noirq quirk to fix 
AM33xx CPU Idle") can the first two patches in this series get picked 
up. I tested applying to v4.4 and they still apply cleanly.

Regards,
Dave

>
> Regards,
>
> Tony
>
