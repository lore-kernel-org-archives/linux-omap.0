From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 2/2][OMAPZOOM] DSPBRIDGE: Change address resources to
 void 	__iomem *
Date: Tue, 24 Feb 2009 16:28:48 -0600
Message-ID: <496565EC904933469F292DDA3F1663E6028775160C@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602877515DC@dlee06.ent.ti.com>
 <94a0d4530902241414v74f6ef1do378a51c55a40fbfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005AbZBXW24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:28:56 -0500
In-Reply-To: <94a0d4530902241414v74f6ef1do378a51c55a40fbfd@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>Why wasn't dwMemBase updated too?
>
><snip/>
>
>A step in the right direction. Thanks.


Hi Felipe,

	In this moment the array dwMemBase is used to store iomem addresses but also the element two stores a kernel address.


MEM_FreePhysMem((void *)pResources->dwMemBase[1], pResources->dwMemPhys[1],
					shm_size);

But we are seeing how to resolve this, and we will send this patch when it is ready.

Regards,
Fernando.
