From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/6] Touchscreen performance related fixes
Date: Mon, 1 Dec 2014 15:59:19 +0530
Message-ID: <547C42FF.5010700@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com> <20141124115116.GA14997@linutronix.de> <547C3A95.30605@ti.com> <547C3C19.5090501@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547C3C19.5090501@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, richardcochran@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Brad Griffis <bgriffis@ti.com>, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jan Kardell <jan.kardell@telliq.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orglinux
List-Id: linux-omap@vger.kernel.org


Hi,

On Monday 01 December 2014 03:29 PM, Sebastian Andrzej Siewior wrote:
> On 12/01/2014 10:53 AM, Vignesh R wrote:
>> Hi Sebastian,
> 
> Hi Vignesh,
> 
>> I fixed the issue that was triggering the WARN_ON(). I think it would be
>> better if you tested these patches, before I posted them on the
>> mainline. I don't want to clutter the list with too main versions. Here
>> is the link to the tree with latest changes:
> 
> awesome, thank you.
> 
>>
>> git clone -b tsc-devel git://git.ti.com/kernel/tsc-adc.git
>> (tsc-devel branch)
> 
> I will and let you know.
> 
>> Please test the above tree and let me know the results.
>> I will post new version(v5) if there are no issues wrt IIO and TSC
>> working at the same time.
> 
> Cool. Were you able to get in touch with someone who has a 5-wire touch?

I have asked Jeff Lance to verify 5-wire touch.

Regards
Vignesh
