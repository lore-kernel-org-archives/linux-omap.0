From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
Date: Thu, 26 Feb 2015 14:01:20 -0600
Message-ID: <54EF7B90.3050702@ti.com>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com> <1420228817-41310-3-git-send-email-d-gerlach@ti.com> <20150102201643.GE4920@saruman> <54AB14E4.2010607@ti.com> <20150105225134.GN4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150105225134.GN4081@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

Tony,
On 01/05/2015 04:51 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150105 14:51]:
>> Felipe,
>> On 01/02/2015 02:16 PM, Felipe Balbi wrote:
>>> On Fri, Jan 02, 2015 at 02:00:16PM -0600, Dave Gerlach wrote:
>>>> Introduce a wkup_m3_ipc driver to handle communication between the MPU
>>>> and Cortex M3 wkup_m3 present on am335x.
>>>>
>>>> This driver is responsible for actually booting the wkup_m3_rproc and
>>>> also handling all IPC which is done using the IPC registers in the control
>>>> module, a mailbox, and a separate interrupt back from the wkup_m3. A small
>>>> API is exposed for executing specific power commands, which include
>>>> configuring for low power mode, request a transition to a low power mode,
>>>> and status info on a previous transition.
>>>>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> ---
>>>>  drivers/soc/ti/Kconfig       |  11 ++
>>>>  drivers/soc/ti/Makefile      |   1 +
>>>>  drivers/soc/ti/wkup_m3_ipc.c | 451 +++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/wkup_m3_ipc.h  |  33 ++++
>>>>  4 files changed, 496 insertions(+)
>>>>  create mode 100644 drivers/soc/ti/wkup_m3_ipc.c
>>>>  create mode 100644 include/linux/wkup_m3_ipc.h
>>>>
>>>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>>>> index 7266b21..61cda85 100644
>>>> --- a/drivers/soc/ti/Kconfig
>>>> +++ b/drivers/soc/ti/Kconfig
>>>> @@ -28,4 +28,15 @@ config KEYSTONE_NAVIGATOR_DMA
>>>>  
>>>>  	  If unsure, say N.
>>>>  
>>>> +config WKUP_M3_IPC
>>>> +	bool "TI AM33XX Wkup-M3 IPC Driver"
>>>
>>> tristate ?
>>
>> If we want to allow this and the rproc driver to be built as modules than we can
>> change this.
> 
> Yes please, the PM is never needed early, and should be optional.
> And doing that will make it a lot easier for you to do further work
> on your driver ;)
> 
> And it will also make it easier to add support for other SoCs as
> it seems the same M3 is used at least on am437x.
>  

I can not build the PM code as a module at this time due to many mach-omap
function calls it uses which are not exported, so I need handles to all five
functions in this driver used in pm33xx to call from built-in PM code. Do you
have a preference on how these function handles get passed?

I currently have added a pdata-quirks implementation that passes a function to
the wkup_m3_ipc driver through it's pdata which it then calls at probe to pass a
struct containing all used function pointers to the pm code that were previously
called directly. Is that what you would prefer or something else? I had also
looked at making the struct of function pointers in the driver global and just
picking it up from the pm code with an extern declaration or even putting a bus
notifier in the PM code and watching for the wkup_m3_ipc driver to be bound.

Thought I would see what you prefer and possibly avoid an unnecessary re-spin.

Regards,
Dave

>>>
>>>> +	depends on WKUP_M3_RPROC
>>>> +	select MAILBOX
>>>> +	select OMAP2PLUS_MBOX
>>>
>>> selects are usually frowned upon.
>>
>> Followed example set by OMAP_REMOTEPROC which selects the mailbox, thought that
>> would be alright.
> 
> The select should be only done if the option selected is a silen
> Kconfig option where it's never selectable by the user. Otherwise
> you will errors sooner or later with make randconfig builds as the
> dependencies change. Using depends on is better for those cases.
> 
> Regards,
> 
> Tony 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
