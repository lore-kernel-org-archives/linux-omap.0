From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5] Add phy support for AM335X platform using Generic
 PHy framework
Date: Wed, 10 Jul 2013 10:26:25 +0530
Message-ID: <51DCE979.8010108@ti.com>
References: <1373280201-31785-1-git-send-email-george.cherian@ti.com> <51DB16A1.6010006@linutronix.de> <51DBA23A.8000505@ti.com> <51DBF59F.1030109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51DBF59F.1030109-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 7/9/2013 5:05 PM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Tuesday 09 July 2013 11:10 AM, George Cherian wrote:
>> On 7/9/2013 1:14 AM, Sebastian Andrzej Siewior wrote:
>>> On 07/08/2013 12:43 PM, George Cherian wrote:
>>>> This patch series adds phy support for AM335X platform.
>>>> This patch series is based on Generic PHY framework [1].
>>>>
>>>>
>>>> This series has
>>>>      - adds dual musb instances support for am335x platform (just for testing)
>>>>      - adds phy-amxxxx-usb driver used in AMxxxx platforms
>>>>      - adds dt  bindings for the phys
>>>>      - removes usb-phy and replaced with generic phy apis in glue layer
>>> No, I don't like this all. You did the one thing I tried to avoid while
>>> posting my quick-and-dirty phy driver recently: You duplicated a lot of
>>> code which can be served by the nop driver and added only power
>>> on/power off callbacks.
>> I wanted to add phy wakeup control also, but currently phy_ops  dont have an op
>> for wkup_ctrl
>> Kishon, Can we add one?
> Since this should be a capability of the PHY, can't we have wkup_ctrl always
> enabled if the PHY has such a capability?

No, we cant have wakeup always enabled. Normally we enable it only when 
we go to low power states and
if the user needs USB a wakeup source.

So how about enable/disable  phy wakeup from phy suspend/resume?
> or if it needs more user control,
> should we implement a sysfs entry to enable wakeup?

Nope, I dont want to create another sysfs entry.
>
> Thanks
> Kishon


-- 
-George

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
