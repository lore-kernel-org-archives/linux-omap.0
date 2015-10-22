From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 1/3] mailbox/omap: Add ti,mbox-send-noirq quirk to fix
 AM33xx CPU Idle
Date: Thu, 22 Oct 2015 10:12:13 +0530
Message-ID: <CAJe_Zhd4RoVQJKjGN8QKYCeDMWVsuPQhCj4gUpQwkAX_Wqnxxg@mail.gmail.com>
References: <1442967294-23837-1-git-send-email-d-gerlach@ti.com>
	<1442967294-23837-2-git-send-email-d-gerlach@ti.com>
	<CABb+yY0rCGCj=vkNXP1c9zonX+snBxdKFeQ4JCo2aKb-h6JhCw@mail.gmail.com>
	<56282833.5010105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56282833.5010105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Devicetree List <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Keerty J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 22 October 2015 at 05:35, Suman Anna <s-anna@ti.com> wrote:

>>   Anyways I am OK too, if you guys want to fix it with a platform
>> specific quirk. Let me know I'll pick this patch.
>
> I haven't gotten a chance to try #1, and I won't be able to look at it
> atleast for another month. I suggest that you go ahead and pick this
> patch up, as a quirk is needed in one form or the other for #2, and #1
> is anyways a bigger change that will affect all our IPC stacks across
> all pairs of MPU - remote processors on different SoCs.
>
Yeah that is the reason I offered to pick this patch as such.
OK I'll take this patch.
