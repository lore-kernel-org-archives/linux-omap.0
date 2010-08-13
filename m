From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 7/8] : Hwmod api changes
Date: Fri, 13 Aug 2010 19:21:19 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270AE93EC@dbde02.ent.ti.com>
References: <1281115688-1429-1-git-send-email-hemahk@ti.com>
 <4C5FF0A6.7080003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934340Ab0HMNva convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 09:51:30 -0400
In-Reply-To: <4C5FF0A6.7080003@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,
 
>-----Original Message-----
>From: Cousson, Benoit 
>Sent: Monday, August 09, 2010 5:42 PM
>To: Kalliguddi, Hema
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; 
>Basak, Partha; Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH 7/8] : Hwmod api changes
>
>On 8/6/2010 7:28 PM, Kalliguddi, Hema wrote:
>> From: Hema HK<hemahk@ti.com>
>>
>> Omap USBOTG modules has a requirement to set the auto idle 
>bit only after
>> setting smart idle bit.
>
>Is it a requirement or an errata? Could you provide more information 
>(i.e. TRM page or errata number / description)?
>

This is a requirement as per the TRM section 24.1.5.4.4
http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf 

There is note on this.

>> Modified the _sys_enable api to set the smart idle
>> first and then the autoidle bit. Setting this will not have 
>any impact on the
>> other modules.
>>
>> Added 2 wrapper APIs in the omap device layer for wakeup 
>enable/disable
>> and sidle/mstandby settings.
>>
>> Signed-off-by: Hema HK<hemahk@ti.com>
>> Signed-off-by: Basak, Partha<p-basak2@ti.com>
>>
>> Cc: Felipe Balbi<felipe.balbi@nokia.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c              |   18 +++++++----
>>   arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>>   arch/arm/plat-omap/omap_device.c              |   42 
>++++++++++++++++++++++++++
>>   3 files changed, 56 insertions(+), 6 deletions(-)
>>
>> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c	
>2010-08-06 08:59:03.641863815 -0400
>> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c	
>2010-08-06 09:02:00.021864999 -0400
>> @@ -653,12 +653,6 @@
>>   		_set_master_standbymode(oh, idlemode,&v);
>>   	}
>>
>> -	if (sf&  SYSC_HAS_AUTOIDLE) {
>> -		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
>> -			0 : 1;
>> -		_set_module_autoidle(oh, idlemode,&v);
>> -	}
>> -
>>   	/* XXX OCP ENAWAKEUP bit? */
>>
>>   	/*
>> @@ -671,6 +665,18 @@
>>   		_set_clockactivity(oh, oh->class->sysc->clockact,&v);
>>
>>   	_write_sysconfig(v, oh);
>> +
>> +	/* Set the auto idle bit only after setting the smartidle bit
>> +	 * as this is requirement for some modules like USBOTG
>> +	 * setting this will not have any impact on the other modues.
>> +	 */
>
>Except that you are adding an extra access to a quite slow L4 slave 
>interface. I'm not sure if write posted will help in that case.
>
I agree that it will add an extra access on L4 but this required for USBOTG.
I did not quite understood your Next Comment can elaborate please?

>> +
>> +	if (sf&  SYSC_HAS_AUTOIDLE) {
>> +		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
>> +			0 : 1;
>> +		_set_module_autoidle(oh, idlemode,&v);
>> +	}
>> +	_write_sysconfig(v, oh);
>>   }
>>
>>   /**
>> Index: linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h
>> ===================================================================
>> --- 
>linux-omap-pm.orig/arch/arm/plat-omap/include/plat/omap_d
>evice.h	2010-08-06 08:59:03.661863725 -0400
>> +++ 
>linux-omap-pm/arch/arm/plat-omap/include/plat/omap_device.h	
>2010-08-06 09:02:00.021864999 -0400
>> @@ -116,6 +116,8 @@
>>   int omap_device_disable_clocks(struct omap_device *od);
>>   int omap_device_enable_clocks(struct omap_device *od);
>>
>> +int omap_device_enable_wakeup(struct omap_device *od);
>> +int omap_device_disable_wakeup(struct omap_device *od);
>>
>>   /*
>>    * Entries should be kept in latency order ascending
>> Index: linux-omap-pm/arch/arm/plat-omap/omap_device.c
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/plat-omap/omap_device.c	
>2010-08-06 08:59:03.661863725 -0400
>> +++ linux-omap-pm/arch/arm/plat-omap/omap_device.c	
>2010-08-06 09:02:00.021864999 -0400
>> @@ -757,3 +757,45 @@
>>   	/* XXX pass along return value here? */
>>   	return 0;
>>   }
>> +
>> +/**
>> + * omap_device_enable_wakeup - Enable the wakeup bit
>> + * @od: struct omap_device *od
>> + *
>> + * Enable the wakup bit for omap_hwmods associated
>> + * with the omap_device.  Returns 0.
>> + */
>> +
>> +int omap_device_enable_wakeup(struct omap_device *od)
>
>Why do you need that? Could you elaborate?
>
This required o set the wakeup enable bit in the sysconfig register for swakeup generation
To enable the OCP clock When module is in smart-idle-mode and there is a 
asyncronous events like resume signalling.

>Benoit
>
>