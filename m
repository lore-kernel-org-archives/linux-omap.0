From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Prevent memory corruption in
 DRV_ProcFreeDMMRes
Date: Wed, 10 Feb 2010 15:07:59 +0200
Message-ID: <20100210130759.GC9214@annwn.felipec.org>
References: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
 <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602AA725BDE@dlee06.ent.ti.com>
 <94a0d4531002091548n18897915kd236f9f7b332c1eb@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602AA725D82@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32911 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0BJNIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 08:08:44 -0500
Content-Disposition: inline
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA725D82@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>

On Wed, Feb 10, 2010 at 05:06:26AM +0100, ext Guzman Lugo, Fernando wrote:
> >At this point there's an obvious question; what's the point of
> >reserving a memory region and not mapping it?
> >
> >I remember the answer from Hari was: some clients prefer to reserve a
> >big region once, and map parts of it continuously. I have my doubts
> >that the use-case even works with the current code-base. But assuming
> >it does work, your proposed changes would break it.
> 
> Resource cleanup does not support that even without my proposed changes.

Aha! I suspected it :P

> I just proposed a solution which fixes two issues in one patch.
> Moreover if this change is merged when the second issue be fixed this
> patch will not needed anymore, so why don't merge the patch which
> fixes both errors at this moment?

simple patches > complicated patches

Personally I think your patches should be a continuation to the patches
I just proposed.

If nobody wants to split these patches, I'll gladly do so.

> >+			u32 dsp_res_addr = p_cur_res->ulDSPResAddr;
> >+
> >+			status = PROC_UnMap(p_cur_res->hProcessor,
> >+				 (void *)p_cur_res->ulDSPAddr, p_ctxt);
> >
> >It would be much easier to merge the two functions into one.
> 
> Yes, I am agreed.

Good. Perhaps we can start moving reserve/unreserve functionality to
map/unmap, and eventually depreate the former.

Cheers.

-- 
Felipe Contreras
