From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
Date: Wed, 30 May 2012 17:23:57 +0200
Message-ID: <4FC63B8D.3070107@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com> <1338375394-16268-3-git-send-email-kishon@ti.com> <CAMQu2gxcP8At5j4UOK3bgX+Q+OunXeTxyXEr6hAhGiwjLs-gJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMQu2gxcP8At5j4UOK3bgX+Q+OunXeTxyXEr6hAhGiwjLs-gJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 5/30/2012 4:51 PM, Shilimkar, Santosh wrote:
> On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I<kishon@ti.com>  wrote:
>> "ocp2scp_usb_phy_ick" clock node was a fake clock node created
>> to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is now added
>> (which can be used to control MODULEMODE) this clock node is removed.
>>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> ---
>>   arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
>
> Have you patched clock44xx_data.c manually or you have a patch for
> the clock_data autogen script to generate it ?

I have a series that will remove all these clock nodes. I should be able 
to post that soon.

Potentially at that time, Kishon might be able to drop that patch.

Regards,
Benoit
