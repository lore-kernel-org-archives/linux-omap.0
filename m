From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
Date: Wed, 1 Apr 2009 11:05:45 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2368BE23@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E236180C9@dlee03.ent.ti.com>
	<20090401.171730.52174968.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2368BCBF@dlee03.ent.ti.com>
 <20090401.185535.13760351.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50784 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760024AbZDAQF6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 12:05:58 -0400
In-Reply-To: <20090401.185535.13760351.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>

Doyu-san,

> What I meant by "vma->vm_ops->close(vma)" was that, if (v)-(p)-(d)
> mapping can be tied just to some process context in saner manner, I
> think that we don't have to call "find_task_by_vpid(pCtxtclosed->pid)"
> explicitly/globally, but automatically it can be cleaned up, when a
> process is exitting, although I'm not so sure right now;), just
> guessing...
>

Ah, I see. Actually the call to find_task_by_vpid(pCtxtclosed->pid) will be removed once we move the cleanup to bridge_release (we are working on this change at present). So, when a process exits we can do the unmapping of PA-VA right away in the bridge_release instead of doing a lazy cleanup during bridge_open.

One question I have is, does the Kernel reclaim the memory before closing the file handles (bridge_release in this case) ? If it doesn't then your proposal of moving the locking to Kernel space might work perfectly.
If the kernel reclaims the memory and then call the bridge_release for the Process that was killed, then I believe there is a narrow window where DSP might be accessing invalid memory.


Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, April 01, 2009 10:56 AM
> To: Kanigeri, Hari
> Cc: Pandita, Vikram; linux-omap@vger.kernel.org; Guzman Lugo, Fernando;
> Menon, Nishanth
> Subject: Re: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
> Date: Wed, 1 Apr 2009 16:58:08 +0200
> 
> > Doyu-san,
> >
> > > There can be multiple user applications which can do (v)-(p)-(d)
> > > mapping and these processes can be killed unexpectedly. Even in such a
> > > case, it would be nice if (p)-(d) mapping could be released without
> > > restarting a whole iommu.
> > >
> > > (v): mpu virtual address
> > > (p): physicall address
> > > (d): device virtual address
> >
> > -- This patch is not basing on restarting the iommu when a process
> > is killed unexpectedly. It will just remove the p-d translations of
> > the Killed process from DSP MMU along with unlocking this buffer
> > during the Bridge's resource cleanup.
> 
> What I meant by "vma->vm_ops->close(vma)" was that, if (v)-(p)-(d)
> mapping can be tied just to some process context in saner manner, I
> think that we don't have to call "find_task_by_vpid(pCtxtclosed->pid)"
> explicitly/globally, but automatically it can be cleaned up, when a
> process is exitting, although I'm not so sure right now;), just
> guessing...
> 
> >
> > Thank you,
> > Best regards,
> > Hari
> >
> > > -----Original Message-----
> > > From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> > > Sent: Wednesday, April 01, 2009 9:18 AM
> > > To: Kanigeri, Hari
> > > Cc: Pandita, Vikram; linux-omap@vger.kernel.org; Guzman Lugo,
> Fernando;
> > > Menon, Nishanth
> > > Subject: Re: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
> > >
> > > Hi Hari,
> > >
> > > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> > > Subject: RE: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
> > > Date: Wed, 1 Apr 2009 15:01:29 +0200
> > >
> > > [...]
> > >
> > > > > Hm....for this page swapping case, I think that handling this
> issue in
> > > > > kernel may cause more complexity and this can be avoided by
> "mlock()"
> > > > > for that buffer in userland? This looks more sipmpler?
> > > > >
> > > > > >
> > > >
> > > > -- I see your point of handling the locking from user-space
> > > > itself. This can be done in normal Page swapping scenarios, but in
> > > > the case of abnormal termination of the user-space Process that
> > > > mapped the buffers we still have an issue.
> > > >
> > > > This is what I think the problem might be if we move the locking to
> > > user-land.
> > > > 	- User process mapped and locked the buffer using mlock.
> > > > 	- The Physical address mapped to DSP VA by DSPBridge.
> > > > 	- The User process got terminated abnormally. I think this
> > > >	will cause the Kernel to reclaim the User buffers that were
> > > >	mapped.
> > > > 	- Now the DSP is not aware of this cleanup and it might be
> > > >	still trying to access the Mapped address, but since the Pages
> > > >	are removed we will end up with MMU fault or DSP corrupting
> > > >	the memory of other Processes as the reclaimed Pages might be
> > > >	allocated to other Processes.
> > > >
> > > > By moving the locking to Kernel space, we are guaranteed that these
> > > > Pages are locked even when an application that mapped the buffers is
> > > > terminated. These Pages will be unlocked only during Bridge's
> > > > resource cleanup of this Process after Bridge informing the DSP s/w
> > > > not to access this buffer.
> > > >
> > > > I think if the resource cleanup is moved to bridge_release instead
> > > > of bridge_open, then it might be possible to move the locking
> > > > mechanism to User land. Here I am assuming that on abnormal
> > > > termination of a Process, the Kernel first calls the bridge_release
> > > > on behalf of the Process before reclaiming the buffers that were
> > > > allocated by this Process otherwise there is a narrow Window when
> > > > DSP might try to access the memory that is no longer valid.
> > >
> > > There can be multiple user applications which can do (v)-(p)-(d)
> > > mapping and these processes can be killed unexpectedly. Even in such a
> > > case, it would be nice if (p)-(d) mapping could be released without
> > > restarting a whole iommu.
> > >
> > > (v): mpu virtual address
> > > (p): physicall address
> > > (d): device virtual address
> > >
> > > So I am considering if "vma->vm_ops->close(vma)" can afford the above
> > > mechanism.
> > >
> > > 	Hiroshi DOYU
> > >
> > >
> >

