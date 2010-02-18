From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCHv5 0/4] DSPBRIDGE: Improved reserved and mapped resource
 cleanup
Date: Thu, 18 Feb 2010 20:16:15 +0200
Message-ID: <20100218181615.GA9816@annwn.felipec.org>
References: <cover.1266503387.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49672 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab0BRSQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 13:16:31 -0500
Content-Disposition: inline
In-Reply-To: <cover.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "nm@ti.com" <nm@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, "x0095840@ti.com" <x0095840@ti.com>, "omar.ramirez@ti.com" <omar.ramirez@ti.com>

On Thu, Feb 18, 2010 at 03:40:49PM +0100, Ameya Palande wrote:
> This patch series splits DMM_RES_OBJECT into DMM_MAP_OBJECT and DMM_RSV_OBJECT
> which are used independently for mapped and reserved memory resources
> accounting. This will help in cleanup of reserved memory resources which was
> not handled properly before. With these patches resource cleanup mechanism
> will work perfectly in a use case where a big chunk of memory is reserved and
> then lot of mappings are created inside it.
> 
> Changes since v4:
> 1. Replace unnecessary list_for_each_entry_safe to list_for_each_entry
>    http://marc.info/?l=linux-omap&m=126645721715598&w=2
> 2. Comments at appropriate places to explain resource tracking objects
>    insertion and removals.
>    http://marc.info/?l=linux-omap&m=126649541624172&w=2
> 
> Changes since v3:
> 1. Improved mapped memory resource cleanup
> 
> Changes since v2:
> 1. Removed locking from DRV_RemoveAllDMMResElements()
> 2. Removed cleanup variable from PROC_UnReserveMemory()
>    http://marc.info/?l=linux-omap&m=126637211831587&w=2
> 3. Rebased patchset on top of following commit:
>    DSPBRIDGE: Remove conditional check from the InputMsg function
> 
> Changed since v1:
> 1. Reduced indentation
>    http://marc.info/?l=linux-omap&m=126624982331523&w=2
> 
> Ameya Palande (4):
>   DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
>   DSPBRIDGE: New reserved memory accounting framework
>   DSPBRIDGE: Fix memory corruption in DRV_ProcFreeDMMRes
>   DSPBRIDGE: Improved mapped memory cleanup

I'm not entirely happy with this order, I generally prefer:
 1) critical fixes (fix memory corruption)
 2) reorganization
 3) new feature (fix res object leakage)

This way the critical fixes can be merged first, while the rest of the
patches are worked on. And reorganization usually don't have much
problem going in.

Currently in your patch #2 the spinlocks protection is not symmetrical
between map and res.

But in general they look ok:
Reviwed-by: Felipe Contreras <felipe.contreras@nokia.com>

-- 
Felipe Contreras
