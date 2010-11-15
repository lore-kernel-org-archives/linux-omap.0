From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
Date: Mon, 15 Nov 2010 14:12:53 -0800
Message-ID: <878w0ume1m.fsf@deeprootsystems.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-8-git-send-email-thara@ti.com>
	<87wrol56x9.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E67@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47611 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab0KOWNA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 17:13:00 -0500
Received: by qwb8 with SMTP id 8so986qwb.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 14:12:59 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E67@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Mon, 15 Nov 2010 16:30:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Thursday, November 11, 2010 12:43 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>>Vishwanath; Sawant, Anand
>>>Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and
>>>Smartreflex drivers
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch adds debug support to the voltage and smartreflex drivers.
>>>> This means a whole bunch of voltage processor and smartreflex
>>>> parameters are now visible through the pm debugfs.
>>>> The voltage parameters can be viewed at
>>>>         /debug/voltage/vdd_<x>/<parameter>
>>>> and the smartreflex parameters can be viewed at
>>>>         /debug/vdd_<x>/smartreflex/<parameter>
>>>>
>>>> To enable overriding of these parameters from user side, write 1
>>>> into
>>>> 	/debug/voltage/vdd_<x>/override_volt_params
>>>
>>>Please just git rid of any sort of override parameter from sysfs.
>>>
>>>Instead, you can detect in the sysfs code itself if any parameters were
>>>changed and then set the vdd->user_override flag.
>
> But when will I unset this flag??

You can't.

And, AFAICT, it wasn't clear from the current code or docs whether this
could work or was expected to work either, e.g., if you set
override_volt_params back to zero, to the original values all get reused?

If you want to provide this feature, then it should be documented and
made clear that this is an intended goal.

Thinking about this more, the main thing I don't like about this
approach is that the active code paths (enable & disable) have to check
each time if any of these values have been overidden.

Rather than have several places in the active code paths where this
override value is checked, there the sysfs methods should simply update
the values that are used by the core code.  This way, the core would 
not need to know about where the values came from (defalts, volt_data,
user override, etc.)

If you want to provide a way to revert this, then maybe writing -1 will
should switch that value back to the HW default, or volt_data default.

Kevin
