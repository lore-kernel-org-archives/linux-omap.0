From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 3/8] DSPBRIDGE: Increased DMM size to 256MB
Date: Fri, 8 Jan 2010 08:14:13 -0600
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E43C0449B@dlee03.ent.ti.com>
References: <1262912435-30024-1-git-send-email-omar.ramirez@ti.com>
 <20100108140818.GD11897@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45113 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437Ab0AHOOW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 09:14:22 -0500
In-Reply-To: <20100108140818.GD11897@annwn.felipec.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>

Felipe,

> Will this work when shm_size=0x4000000?

It will. Increasing DMM pool size doesn't have any dependency on shm size. The SHM is used for IPC mechanism to exchange data and loading base images. The DMM is just the DSP virtual address pool that is used for dynamic memory mapping to the buffers allocated on ARM (this buffer is not coming from SHM).

Thank you,
Best regards,
Hari

-----Original Message-----
From: Felipe Contreras [mailto:felipe.contreras@nokia.com] 
Sent: Friday, January 08, 2010 7:38 PM
To: Ramirez Luna, Omar
Cc: linux-omap; Hiroshi Doyu; Ameya Palande; Guzman Lugo, Fernando; Ramos Falcon, Ernesto; Kanigeri, Hari; Aguilar Pena, Leed
Subject: Re: [PATCH 3/8] DSPBRIDGE: Increased DMM size to 256MB

On Fri, Jan 08, 2010 at 02:00:35AM +0100, Omar Ramirez Luna wrote:
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> 
> This patch increases the DMM from 64MB to 256MB.

Will this work when shm_size=0x4000000?

-- 
Felipe Contreras
