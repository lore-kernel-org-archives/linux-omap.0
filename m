From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/4] [OMAPZOOM] DSPBRIDGE: Memory lock for DMM.
Date: Wed, 1 Apr 2009 08:01:29 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E236180C9@dlee03.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287E2BC72@dlee06.ent.ti.com>
 <20090401.104135.02295366.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38808 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbZDANBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2009 09:01:42 -0400
In-Reply-To: <20090401.104135.02295366.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Menon, Nishanth" <nm@ti.com>

Hi Doyu-san,

> 
> Hm....for this page swapping case, I think that handling this issue in
> kernel may cause more complexity and this can be avoided by "mlock()"
> for that buffer in userland? This looks more sipmpler?
> 
> >

-- I see your point of handling the locking from user-space itself. This can be done in normal Page swapping scenarios, but in the case of abnormal termination of the user-space Process that mapped the buffers we still have an issue.

This is what I think the problem might be if we move the locking to user-land.
	- User process mapped and locked the buffer using mlock.
	- The Physical address mapped to DSP VA by DSPBridge.
	- The User process got terminated abnormally. I think this will cause the Kernel to reclaim the User buffers that were mapped.
	- Now the DSP is not aware of this cleanup and it might be still trying to access the Mapped address, but since the Pages are removed we will end up with MMU fault or DSP corrupting the memory of other Processes as the reclaimed Pages might be allocated to other Processes. 

By moving the locking to Kernel space, we are guaranteed that these Pages are locked even when an application that mapped the buffers is terminated. These Pages will be unlocked only during Bridge's resource cleanup of this Process after Bridge informing the DSP s/w not to access this buffer.

I think if the resource cleanup is moved to bridge_release instead of bridge_open, then it might be possible to move the locking mechanism to User land. Here I am assuming that on abnormal termination of a Process, the Kernel first calls the bridge_release on behalf of the Process before reclaiming the buffers that were allocated by this Process otherwise there is a narrow Window when DSP might try to access the memory that is no longer valid.

Please share your thoughts.


Thank you,
Best regards,
Hari

