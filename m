From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 10 Sep 2014 16:19:22 -0500
Message-ID: <5410C05A.50602@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>	<1405047349-15101-11-git-send-email-d-gerlach@ti.com>	<7h7g1dlp8b.fsf@linaro.org>	<CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com>	<540F5C39.7040201@ti.com> <540F62E3.6080804@ti.com> <7hr3zk7b5z.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36655 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaIJVTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2014 17:19:50 -0400
In-Reply-To: <7hr3zk7b5z.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Suman Anna <s-anna@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>

Kevin,
On 09/09/2014 04:10 PM, Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
> 
>> Kevin/Ohad,
>> On 09/09/2014 02:59 PM, Suman Anna wrote:
>>> Hi Ohad,
>>>
>>> On 09/09/2014 05:31 AM, Ohad Ben-Cohen wrote:
>>>> On Tue, Sep 9, 2014 at 1:30 AM, Kevin Hilman <khilman@linaro.org> wrote:
>>>>> To me, it's not terribly clear how you made the split between this PM
>>>>> core code an the remoteproc code.  In the changelog for the remoteproc
>>>>> patch, it states it's to "load the firmware for and boot the wkup_m3".
>>>>> But, while parts of the IPC are here in pm33xx.c, parts of the IPC are
>>>>> also inside the remoteproc driver, so I'm quite curious if that's OK
>>>>> with the remoteproc maintainers.  Either way, please make it clearer how
>>>>> and why you made the split, and please isolate the wkup_m3 IPC/protocol
>>>>> from this code.  Think of people wanting to rework/extend the wkup_m3
>>>>> firmware.  They shouldn't be messing around in here, but rather inside a
>>>>> driver specificaly for the wkup_m3.
>>>>
>>>> I haven't looked at the code very thoroughly yet, but generally a
>>>> remoteproc driver should only implement the three start/stop/kick
>>>> rproc_ops, and then register them via the remoteproc framework.
>>>> Exposing additional API directly from that driver isn't something we
>>>> immediately want to accept.
>>>>
>>>> If relevant, we would generally prefer to extend remoteproc instead,
>>>> so other platform-specific drivers could utilize that functionality as
>>>> well. Or rpmsg - if we're missing some IPC functionality.
>>>
>>> The WkupM3 cannot access DDR, and so we don't intend to use rpmsg. The
>>> IPC with wkup_m3 is usually one of the last steps for putting the SoC
>>> into a desired low-power state either during suspend or cpuidle, and the
>>> communication uses a bank of fixed registers. The .kick is specific
>>> to virtio-based communication, and so this is not gonna be used.
>>>
>>> If you can take a closer look at the wkup_m3 remoteproc driver and give
>>> your comments, then we can plan on the next steps. Especially as there
>>> are also pieces pertaining to the PM layer knowing the WkupM3 has been
>>> loaded and booted. There are already some pending comments on code
>>> fragments from Santosh and myself, but let us know your inputs on the
>>> integration aspects on PM, remoteproc and IPC with WkupM3.
>>>
>>
>> The split was defined by putting all the application specific (to the
>> firmware in use) code in the platform pm code while trying to keep all the
>> IPC code within the wkup_m3_rproc driver. 
> 
> I don't even see that split.  I see the platform PM code directly
> setting IPC register values, but then rproc driver actually sends the
> mailbox command.

Well, really the pm code is setting a structure which gets passed to the
wkup_m3_rproc API and that's what does the write. I suppose the naming of the
structure is misleading though. However, the wkup_m3 driver isn't aware of the
protocol or what is going into these registers for the writes, the PM code
defines the usage.

> 
>> The exposed API is definitely heavily biased towards the intended
>> use-case, 
> 
> Maybe if the API was actually documented, it would be easier for us to
> review it.
> 
>> but the CM3 was designed with this exact purpose in mind and
>> not much else, and due to the limited IPC registers we have to work
>> with there isn't a whole lot of flexibility. Only IPC reg 0 is always
>> used as the resume address, the usage of the other registers is
>> defined by the firmware and pm code.
>>
>> Just as a refresher for those not familiar with it, the IPC mechanism works
>> like this: we load the ipc registers (8 for am33xx, 16 for am43xx) with any
>> information we want to communicate to the CM3, 
> 
> OK, and this happens currently in the platform PM code, right?
> 
>> then we make a dummy write to
>> the Mailbox which triggers an interrupt on the CM3, the CM3 does what it
>> needs to with the info passed in the IPC regs and writes anything it wants to
>> communicate back to these registers, and then triggers a different interrupt
>> (not related to mailbox) to let the MPU know it is done. 
> 
> And this part happens in the rproc driver, right?
> 
>> It's kind of a mess so I figured one driver was the best way to
>> encapsulate it all,
> 
> So where is this "one driver" that encapsulates it all?  
>

Sp my thinking was that I put the IPC writing in the wkup_m3_rproc driver, but
the actual configuration of what gets written in the PM platform code, to at
least try to keep things generic. Still, I do agree now that the split is not
that clear.

>> and I still had to
>> introduce callbacks within the wkup_m3_rproc driver so it could let the pm code
>> know when the FW loaded (to actually enable pm) and when an interrupt was
>> received from the wkup_m3 (so the pm code can process the response).
> 
>> As Suman stated, this sequence is part of the suspend path and also will be part
>> of the lower c-states for cpuidle, so we need something fast and lightweight.
>> RPMsg is way more than we need and it doesn't really fit the use case, so I'm
>> not sure what makes the most sense, extending remoteproc in some way to support
>> IPC communication like described above or leaving the basic FW loading
>> functionality in place in remoteproc but moving the IPC and wkup_m3
>> functionality back into the platform pm33xx code as it's so specific to that
>> use-case anyway.
> 
> I'm not advocating for using rpmsg (anymore).  But I dont' think shoving
> your rpmsg-lite IPC into your rproc driver is the right answer either
> (and Ohad's repsonse confirmed my suspicion.)
> 
> What I think you need to do (and what I've recommended at least once in
> earlier reviews) put all the (non-rproc) wkup_m3 IPC into into one
> driver and create a well-described, well-documented API that the
> platform PM code will use.
> 
> IMO, the current "split" is very difficult to read/understand, which
> means it will even more difficult to maintain.

I dont think I entirely understand your vision for the API. I see it going in
one of two directions:

PM/Application agnostic: provide ability to write/read wkup_m3 (mailbox ping is
handled automatically by the driver also) and then callbacks for rproc being
ready and handling response from wkup_m3 for the PM code to use, and that's it.
Well let the PM code sort out how it uses everything. This means that there is a
payload (similar to the structure in place now that takes the register values)
that gets configured and then the wkup_m3 driver just passes the info back and
forth between the MPU and wkup_m3 without the driver ever knowing what's
actually happening.

OR

Application specific: Provide ability to set use-case specific functionality,
i.e. wkup_m3_set_low_power_mode, wkup_m3_set_resume_address, etc... which
exposes the high level functions provided by the wkup_m3 firmware (which are
limited to the functionality in the TI provided firmware, which is all that is
intended anyway), and the pm code uses this to accomplish what it wants without
any knowledge of the actual communication or configuration.

I think the first version is more scalable and maintainable for future
applications, but perhaps I am still not aligned with your vision. Thoughts?

Regards,
Dave

> 
> Kevin
> 

