From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: android-omap-2.6.29 for gumstix overo
Date: Tue, 21 Jul 2009 18:28:31 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F56F1D5F@dbde02.ent.ti.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
 <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BE1@dbde02.ent.ti.com>
 <44A80450-2A36-402C-9E41-940C0F400C89@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BEA@dbde02.ent.ti.com>
 <53FB694B-B432-4E7B-A2B1-42367D3741B3@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F56F1524@dbde02.ent.ti.com>
 <6E1CBACD-F7A7-45AB-9803-71A410B2D291@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F56F1558@dbde02.ent.ti.com>
 <150502595516242563683790801567495303551-Webmail@me.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F56F1D4E@dbde02.ent.ti.com>
 <166987577357449983217693385162670973990-Webmail@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbZGUM6p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 08:58:45 -0400
In-Reply-To: <166987577357449983217693385162670973990-Webmail@me.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux OMAP Users <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Elvis Dowson [mailto:elvis.dowson@mac.com]
>Sent: Tuesday, July 21, 2009 7:54 AM
>To: Pandita, Vikram
>Cc: Kevin Hilman; Linux OMAP Users
>Subject: RE: android-omap-2.6.29 for gumstix overo
>
>Hi Vikram,
>                  Thanks, this is good news since you appear to have atleast one working version of
>omap-pm on omap-2.6.29 up and running.
>
>Could you email me those patches so I can try it out?

The pm defconfig just disables most of the drivers. 
So the base pm features are there, but the drivers are not compliant.

You can check review.android.source.com and omap project to check our submissions.
MMC drivers PM patches have been submitted.

MMC CLK: https://review.source.android.com/#change,10665
MMC off mode: https://review.source.android.com/#change,10666

>
>Best regards,
>
>Elvis
>
>
>On Tuesday, 21 July, 2009, at 05:26AM, "Pandita, Vikram" <vikram.pandita@ti.com> wrote:
>>Elvis
>>
>>>-----Original Message-----
>>>From: Elvis Dowson [mailto:elvis.dowson@mac.com]
>>>Sent: Tuesday, July 21, 2009 12:34 AM
>>>To: Pandita, Vikram; Kevin Hilman
>>>Cc: Linux OMAP Users
>>>Subject: RE: android-omap-2.6.29 for gumstix overo
>>>
>>>Hi Vikram,
>>>                  I am now looking at the android-omap-2.6.29 branch, and after having looked at
>the
>>>zoom2_defconfig file, I notice that power management is not enabled in the zoom2_defconfg file. Do
>>>you know if anyone managed to get a working PM implementation for android-2.6.29 for TI OMAP
>>>3503/3430?
>>>
>>>I adapted the zoom2 settings for my overo android-2.6.29 build, and find that the system doesn't go
>>>to suspend mode at all. :-)
>>
>>Yes you are right. PM is not enabled by default on zoom2_defconfig and Mike will be sending a patch
>for the same to Android mainline.
>>
>>While we submit the patch, you can use the attached defconfig.
>>
>>>
>>>So, while DSS2 and OMAP-PM have been integrated into the android-omap-2.6.29 branch, am I correct
>in
>>>concluding that power management suspend has not yet been implemented for android on TI OMAP
>>>3503/3430?
>>>
>>>For example, here is a snippet from the zoom2_defconfig that shows pm suspend not being enabled.
>>>Because of this android cannot suspend and blank the screen after a period of inactivity:
>>>
>>>#
>>># OMAP Feature Selections
>>>#
>>># CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
>>># CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
>>># CONFIG_OMAP_SMARTREFLEX is not set
>>># CONFIG_OMAP_RESET_CLOCKS is not set
>>># CONFIG_OMAP_PM_NONE is not set
>>>CONFIG_OMAP_PM_NOOP=y
>>># CONFIG_OMAP_PM_SRF is not set
>>>
>>>Even CPU power management is disabled:
>>>
>>>#
>>># CPU Power Management
>>>#
>>># CONFIG_CPU_FREQ is not set
>>># CONFIG_CPU_IDLE is not set
>>>
>>>As you can see suspend is disabled.
>>>
>>>#
>>># Power management options
>>>#
>>>CONFIG_PM=y
>>># CONFIG_PM_DEBUG is not set
>>># CONFIG_SUSPEND is not set
>>>CONFIG_HAS_WAKELOCK=y
>>>CONFIG_HAS_EARLYSUSPEND=y
>>>CONFIG_WAKELOCK=y
>>>CONFIG_WAKELOCK_STAT=y
>>>CONFIG_USER_WAKELOCK=y
>>>CONFIG_EARLYSUSPEND=y
>>># CONFIG_NO_USER_SPACE_SCREEN_ACCESS_CONTROL is not set
>>># CONFIG_CONSOLE_EARLYSUSPEND is not set
>>>CONFIG_FB_EARLYSUSPEND=y
>>># CONFIG_APM_EMULATION is not set
>>>CONFIG_ARCH_SUSPEND_POSSIBLE=y
>>>CONFIG_NET=y
>>>
>>>Best regards,
>>>
>>>Elvis
>>>
>>
>>
>>

