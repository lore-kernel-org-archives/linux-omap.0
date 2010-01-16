From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v3 0/7] misc patches (for ioctl and ssi)
Date: Fri, 15 Jan 2010 20:04:00 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE506FC@dlee03.ent.ti.com>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
 <1263560780.2092.5.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46521 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758595Ab0APCEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 21:04:08 -0500
In-Reply-To: <1263560780.2092.5.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Contreras Felipe <felipe.contreras@nokia.com>

Hi Ameya,

>Hi Omar,
>
>On Tue, 2010-01-12 at 02:00 +0100, ext Omar Ramirez Luna wrote:
>> Ioctl numbers has changed, this will require an update on libbridge 
>> and clients accesing directly to the driver
>> 
>> - IO_ADDRESS is replaced for ioremap.
>> 
>> *v3
>> - modified:
>> 	DSPBRIDGE: replace IO_ADDRESS with ioremap, checking
>> 	the result of ioremap
>> 	(http://marc.info/?l=linux-omap&m=126324914710445&w=2).
>> 	DSPBRIDGE: Use _IOxx macro to define ioctls (as per Nishanth 
>> comments)
>> - new patch:
>>   	DSPBRIDGE: remove WCD_Cmd structure
>>   	
>> *v2
>> - dropped from the series:
>> 	DSPBRIDGE: Increased DMM size to 256MB
>> 	DSPBRIDGE: sysfs entry for global driver state
>> - will be kept in bridge-pm
>> 	DSPBRIDGE: Use dspbridge to initialize platform data
>> 	DSPBRIDGE: change to cpufreq_register_notifier for OPP changes
>> 	DSPBRIDGE: Fix header locations mach to plat
>
>Where is the bridge-pm repository?
>I am trying to compile dspbridge branch with HEAD commit as: DSPBRIDGE:
>Use _IOxx macro to define ioctls. But compilation fails because of following
>missing commit:
>
>DSPBRIDGE: Fix header locations mach to plat
>
>Can you move this commit from bridge-pm to dspbridge so that dspbridge is
>in compilable state?

This will break any attempt to compile dspbridge as is on LO.

I have created dspbridge-pm, however patch set to compile this branch has just
been sent as nobody reviewed it yet.

For the patches please refer to: http://marc.info/?l=linux-omap&m=126360672728600&w=2

Dspbridge-pm at dev.omapzoom.org
http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=shortlog;h=refs/heads/dspbridge-pm

The branch was created on top of pm-2.6.32.

Best Regards,

omar
