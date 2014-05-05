From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V4 0/3] ARM: DTS: DRA7: Updates for adding crossbar device
Date: Mon, 5 May 2014 20:07:10 +0530
Message-ID: <5367A216.2090303@ti.com>
References: <1384431928-2328-1-git-send-email-r.sricharan@ti.com> <52C1197A.5010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52C1197A.5010701-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Monday 30 December 2013 12:28 PM, Sricharan R wrote:
> Hi Benoit,
>
> On Thursday 14 November 2013 05:55 PM, Sricharan R wrote:
>> Some socs have a large number of interrupts requests to service
>> the needs of its many peripherals and subsystems. All of the interrupt
>> requests lines from the subsystems are not needed at the same
>> time, so they have to be muxed to the controllers appropriately.
>> In such places a interrupt controllers are preceded by an
>> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
>> requests to the controller inputs.
>>
>> The driver support for the same was added here.
>> 	http://marc.info/?l=linux-omap&m=138443167321614&w=2
>>
>> The dts file update to support the crossbar device and convert
>> peripheral irq numbers to crossbar number are added here.
>> This series was originally a part of the series [1] and now split
>> to keep the DTS updates separately as per comments from
>> Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>>
>> Applied this series on top of
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>>   for_3.13/dts
>>
>> [1] http://www.kernelhub.org/?msg=356470&p=2
>>
>> Sricharan R (3):
>>   ARM: DTS: DRA: Add crossbar device binding
>>   ARM: DTS: DRA: Replace peripheral interrupt numbers with crossbar
>>     inputs
>>   ARM: DTS: DRA7: Add routable-irqs property for gic node
>>
>>  arch/arm/boot/dts/dra7.dtsi |   95 +++++++++++++++++++++++--------------------
>>  1 file changed, 52 insertions(+), 43 deletions(-)
>>
> I have pushed a branch with this series here
>
> git://github.com/Sricharanti/sricharan.git
> branch: crossbar_dts
>
> This is on top of your for_3.14/dts branch
>
> This series has a dependency with crossbar driver functional changes, which is yet
> to be pulled
>
> https://lkml.org/lkml/2013/12/30/9
>
> Regards,
>  Sricharan

I have pushed the below branch for the crossbar-dts data rebased on 3.15-rc4

git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:Sricharanti/sricharan.git
branch: crossbar_dts_3.15_rc4

These patches are dependent on the crossbar driver fixes sent below.

http://marc.info/?l=linux-omap&m=139929963420299&w=2

Regards,
 Sricharan

-

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
