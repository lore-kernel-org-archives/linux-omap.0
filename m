From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and
 Smartreflex drivers
Date: Thu, 9 Dec 2010 19:43:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03738319F3@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-8-git-send-email-thara@ti.com>
	<87wrol56x9.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E67@dbde02.ent.ti.com>
 <878w0ume1m.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0373831615@dbde02.ent.ti.com>
 <4CFFB397.60203@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03738318AA@dbde02.ent.ti.com>
 <4D00BC41.8090508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43516 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab0LIOOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 09:14:14 -0500
In-Reply-To: <4D00BC41.8090508@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Thursday, December 09, 2010 4:54 PM
>>To: Gopinath, Thara
>>Cc: Kevin Hilman; linux-omap@vger.kernel.org; paul@pwsan.com; Cousson,
>>Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage and
>>Smartreflex drivers
>>
>>Gopinath, Thara wrote, on 12/09/2010 03:43 AM:
>>>
>>>
>>>>> -----Original Message-----
>>>>> From: Nishanth Menon [mailto:nm@ti.com]
>>>>> Sent: Wednesday, December 08, 2010 10:05 PM
>>>>> To: Gopinath, Thara
>>>>> Cc: Kevin Hilman; linux-omap@vger.kernel.org; paul@pwsan.com; Cousson,
>>>>> Benoit; Sripathy, Vishwanath; Sawant, Anand
>>>>> Subject: Re: [PATCH v4 7/9] OMAP3: PM: Adding debug support to Voltage
>>and
>>>>> Smartreflex drivers
>>>>>
>>>>> Gopinath, Thara had written, on 12/08/2010 10:18 AM, the following:
>>>>> [..]
>>>>>>>> And, AFAICT, it wasn't clear from the current code or docs whether
>>this
>>>>>>>> could work or was expected to work either, e.g., if you set
>>>>>>>> override_volt_params back to zero, to the original values all get
>>reused?
>>>>>>>>
>>>>>>>> If you want to provide this feature, then it should be documented and
>>>>>>>> made clear that this is an intended goal.
>>>>>>>>
>>>>>>>> Thinking about this more, the main thing I don't like about this
>>>>>>>> approach is that the active code paths (enable&  disable) have to
>>check
>>>>>>>> each time if any of these values have been overidden.
>>>>>>>>
>>>>>>>> Rather than have several places in the active code paths where this
>>>>>>>> override value is checked, there the sysfs methods should simply
>>update
>>>>>>>> the values that are used by the core code.  This way, the core would
>>>>>>>> not need to know about where the values came from (defalts, volt_data,
>>>>>>>> user override, etc.)
>>>>>>>>
>>>>>>>> If you want to provide a way to revert this, then maybe writing -1
>>will
>>>>>>>> should switch that value back to the HW default, or volt_data default.
>>>>>> Kevin, Benoit, Nishant et al,
>>>>>>
>>>>>> Without this override flag today there is no direct way of
>>>>>> allowing user to write into these parameters. My question is,
>>>>> Glancing at the debug entries being overidden, as developer (debug
>>>>> users) working for tweaking parameters for their platform - yes - we
>>>>> will need some mechanism to runtime tweak and see the behavior without
>>>>> needing to rebuild the kernel everytime.
>>>>>
>>>>> On production system (OS users): they should'nt be using this.
>>>>>
>>>>>
>>>>>> is there a need for the parameters to be over-written
>>>>>> from the user-space? If yes, I need ideas on how to
>>>>>> implement it with using override_volt_params !
>>>>>
>>>>> Lets get the basics in kernel.org in some form! IMHO, all this double
>>>>> knobs are un-necessary overheads in codeflow for development only code-
>>>>> just provide the debugfs entries that reflect the data in their original
>>>>> structures, use the original structures everytime we go to a new
>>>>> transition (aka if you change the params in debugfs, they dont take
>>>>> effect till you do another transition).. but that is just my 2cents.
>>>
>>> Nishant,
>>> The issue here is most of these parameters are one time setting (during
>>init)
>> > and need not be changed at all if the user does not wish to over-ride
>>them for
>> > debug purpose. Hence the need for the checks (not double-hooks). But
>>I agree
>>If they are init time thingy, then why not set it up so that when some
>>one echo's to the debugfs, it writes to the register as well? That way
>>you dont need to add runtime check and the debug developer does'nt need
>>to worry about echo 1> magic_control_sys_fs_file (just kidding).

Yes but then for it the debugfs set get APIs should have access to the data structures which stores the register offset etc. Today I am using a single API to set any parameter any vdd. This will have to change. Maybe one API per parameter. I cannot currently think of any better solution :-)! 
>>
>> > with your point that let us get the basic in the kernel.org in some
>>form. So
>> >for this first version that we plan to push to kernel.org, I plan to
>>expose out
>> > these parameters to user space but not allow a write access to them.
>>The write
>> >access part can be added later whenever required.
>>Sure.. at this point, anything that actually works is welcome :)
Ok :-) !

Regards
Thara
