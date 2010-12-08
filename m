From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and
 Smartreflex drivers
Date: Wed, 8 Dec 2010 21:48:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373831615@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-8-git-send-email-thara@ti.com>
	<87wrol56x9.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E67@dbde02.ent.ti.com>
 <878w0ume1m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51737 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab0LHQSd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 11:18:33 -0500
In-Reply-To: <878w0ume1m.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Tuesday, November 16, 2010 3:43 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and
>>Smartreflex drivers
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>>>>-----Original Message-----
>>>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>Sent: Thursday, November 11, 2010 12:43 AM
>>>>>To: Gopinath, Thara
>>>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>>>>Vishwanath; Sawant, Anand
>>>>>Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and
>>>>>Smartreflex drivers
>>>>>
>>>>>Thara Gopinath <thara@ti.com> writes:
>>>>>
>>>>>> This patch adds debug support to the voltage and smartreflex drivers.
>>>>>> This means a whole bunch of voltage processor and smartreflex
>>>>>> parameters are now visible through the pm debugfs.
>>>>>> The voltage parameters can be viewed at
>>>>>>         /debug/voltage/vdd_<x>/<parameter>
>>>>>> and the smartreflex parameters can be viewed at
>>>>>>         /debug/vdd_<x>/smartreflex/<parameter>
>>>>>>
>>>>>> To enable overriding of these parameters from user side, write 1
>>>>>> into
>>>>>> 	/debug/voltage/vdd_<x>/override_volt_params
>>>>>
>>>>>Please just git rid of any sort of override parameter from sysfs.
>>>>>
>>>>>Instead, you can detect in the sysfs code itself if any parameters were
>>>>>changed and then set the vdd->user_override flag.

But in the sys-fs code I do not have access to vdd. How do I then set this flag?

>>>
>>> But when will I unset this flag??
>>
>>You can't.
>>
>>And, AFAICT, it wasn't clear from the current code or docs whether this
>>could work or was expected to work either, e.g., if you set
>>override_volt_params back to zero, to the original values all get reused?
>>
>>If you want to provide this feature, then it should be documented and
>>made clear that this is an intended goal.
>>
>>Thinking about this more, the main thing I don't like about this
>>approach is that the active code paths (enable & disable) have to check
>>each time if any of these values have been overidden.
>>
>>Rather than have several places in the active code paths where this
>>override value is checked, there the sysfs methods should simply update
>>the values that are used by the core code.  This way, the core would
>>not need to know about where the values came from (defalts, volt_data,
>>user override, etc.)
>>
>>If you want to provide a way to revert this, then maybe writing -1 will
>>should switch that value back to the HW default, or volt_data default.
Kevin, Benoit, Nishant et al,

Without this override flag today there is no direct way of
allowing user to write into these parameters. My question is,
is there a need for the parameters to be over-written
from the user-space? If yes, I need ideas on how to
implement it with using override_volt_params !

Regards
Thara
