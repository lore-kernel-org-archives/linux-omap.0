From: Arun Murthy <arunrmurthy.83@gmail.com>
Subject: Re: [PATCH v3] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Mon, 27 Sep 2010 18:05:22 +0530
Message-ID: <AANLkTik0LOQN8kOPjv_VohhO5To6pZDS=M0mw=q0whPp@mail.gmail.com>
References: <1285529740-28232-1-git-send-email-notasas@gmail.com>
	<AANLkTinkxokX9BGtxysYOr19xbZR4S8oPRYUAyneutzc@mail.gmail.com>
	<AANLkTinh+JTwyE4E33QXdnZ8obYA8S0SU71i3kGi=wRT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinh+JTwyE4E33QXdnZ8obYA8S0SU71i3kGi=wRT@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Madhusudhan <madhu.cr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 27, 2010 at 4:24 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Mon, Sep 27, 2010 at 10:21 AM, Arun Murthy <arunrmurthy.83@gmail.com> wrote:
>> On Mon, Sep 27, 2010 at 1:05 AM, Grazvydas Ignotas <notasas@gmail.com>
>> wrote:
>>> ---
>> Only AC and USB monitoring is achieved by registering with power supply
>> class.
>> How is battery monitored?
>> An instance of battery is to be registered with power supply class in order
>> to monitor battery.
>
> The problem is that BCI is only active while charging, when it is not
> charging most (all?) monitoring registers freeze and no monitoring
> happens (BCI registers read frozen values from last charge). So I
> don't register battery as it has no useful data to report. I heard it
> is possible to use MADC to perform monitoring while not charging, so
> battery can be added when MADC driver is merged and corresponding code
> is written for this driver.
>
How do I check the battery voltage?
I need to check the battery voltage/current/temp and, if I am not
wrong these are obtained from MADC.
MADC driver has to be added first and then the battery.
With being able to read the basic parameter battery voltage, this
driver becomes incomplete.

How do I get notified if battery voltage is low and needs charging
from user space?

Thanks and Regards,
Arun R Murthy
---------------------
