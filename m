From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Pending October patches
Date: Fri, 03 Nov 2006 21:18:35 +0100
Message-ID: <454BA41B.9080801@gmail.com>
References: <4548C32E.8010800@gmail.com> <20061101212850.GD6833@atomide.com>
	<200611031152.16397.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200611031152.16397.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> On Wednesday 01 November 2006 1:28 pm, tony@atomide.com wrote:
>>>27. [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm 
>>>fields missing
>>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008234.html
>>
>>Sounds like this is getting fixed in the mainline tree.
> 
> No, the root cause of the problem is a borked h2 defconfig; but I'm
> not clear how it got past the build step that's supposed to make sure
> the current config matches all the Kconfig constraints.
> 
> (That is, USB_SUSPEND depends on PM, but only one of them was set in
> the defconfig yet the build was proceeding ...)

Just tried it, it really fails and isn't resolved by Kconfig 
processing.

Looking at h2 defconfig we have

# CONFIG_PM is not set
CONFIG_USB_SUSPEND=y
CONFIG_USB_OTG=y

Looking at drivers/usb/core/Kconfig we have

config USB_SUSPEND
	bool "USB selective suspend/resume and wakeup (EXPERIMENTAL)"
	depends on USB && PM && EXPERIMENTAL

config USB_OTG
	bool
	depends on USB && EXPERIMENTAL
	select USB_SUSPEND
	default n

So USB_SUSPEND isn't activated (processed?) because PM isn't 
set. But USB_OTG selects USB_SUSPEND without selecting PM as 
well.

Maybe anything like

--- linux-osk.orig/drivers/usb/core/Kconfig
+++ linux-osk/drivers/usb/core/Kconfig
@@ -77,6 +77,7 @@ config USB_OTG
         bool
         depends on USB && EXPERIMENTAL
         select USB_SUSPEND
+       select PM
         default n

can help here?

Cheers

Dirk
