From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Prevent memory corruption in
	DRV_ProcFreeDMMRes
Date: Tue, 9 Feb 2010 14:29:32 +0200
Message-ID: <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
References: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f181.google.com ([209.85.223.181]:52761 "EHLO
	mail-iw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0BIMhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 07:37:38 -0500
Received: by iwn11 with SMTP id 11so30259iwn.17
        for <linux-omap@vger.kernel.org>; Tue, 09 Feb 2010 04:37:37 -0800 (PST)
In-Reply-To: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com, felipe.contreras@nokia.com, ext-phil.2.carmody@nokia.com

On Mon, Feb 8, 2010 at 10:25 PM, Ameya Palande <ameya.palande@nokia.com> wrote:
> Background: bridge_close() has the responsibility to cleanup all the
> resources allocated by user space process. One of those resources is
> DMMRes which is used for tracking DMM resource allocation done in
> PROC_Map() and PROC_UnMap().
>
> DRV_ProcFreeDMMRes() function was used for cleaning up DMMRes has following
> problems which are fixed by this patch:
>
> 1. It access and modifies pDMMRes pointer when it is already freed by
> PROC_UnMap()
> 2. Instead of passing ulDSPAddr it passes ulDSPResAddr to PROC_UnMap() which
> will not retrive correct DMMRes element.

This patch is doing the right thing to me, however, it's a bit
difficult to review because it's doing many changes at once.

Personally I would
 1) Fix the wrong dereferences in DRV_ProcFreeDMMRes
[at this point the bug should be fixed]
[the leaks would be freed by the outer loop]

 2) Fix the wrong PROC_UnMap address passed in DRV_ProcFreeDMMRes
 3) Remove the unnecessary outer loop in DRV_RemoveAllDMMResElements
[at this point the code would actually make sense]

 4) Merge DRV_ProcFreeDMMRes into DRV_RemoveAllDMMResElements
 5) Improve coding style

The end result would be the same, but easier to see what's going on :)

Cheers.

-- 
Felipe Contreras
