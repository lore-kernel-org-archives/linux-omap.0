From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 5/5] mmc: omap_hsmmc: Change wake-up interrupt to use
 generic wakeirq
Date: Thu, 28 May 2015 00:42:59 +0200
Message-ID: <55664873.2080604@intel.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>	<1431560196-5722-6-git-send-email-tony@atomide.com> <CAPDyKFqsfVL1SG2uuQRx3g=8DeJ4W_RhZwEEeQwFedhwOnBjXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqsfVL1SG2uuQRx3g=8DeJ4W_RhZwEEeQwFedhwOnBjXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 5/25/2015 10:38 AM, Ulf Hansson wrote:
> On 14 May 2015 at 01:36, Tony Lindgren <tony@atomide.com> wrote:
>> We can now use generic wakeirq handling and remove the custom handling
>> for the wake-up interrupts.
>>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Rafael, if you are fine with it, please take this one through your
> linux-pm tree.
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

I thought that Tony would resubmit this one.  Tony?
