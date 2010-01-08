From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 3/8] DSPBRIDGE: Increased DMM size to 256MB
Date: Fri, 8 Jan 2010 16:08:19 +0200
Message-ID: <20100108140818.GD11897@annwn.felipec.org>
References: <1262912435-30024-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35964 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab0AHOI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 09:08:29 -0500
Content-Disposition: inline
In-Reply-To: <1262912435-30024-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Leed Aguilar <leed.aguilar@ti.com>

On Fri, Jan 08, 2010 at 02:00:35AM +0100, Omar Ramirez Luna wrote:
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> 
> This patch increases the DMM from 64MB to 256MB.

Will this work when shm_size=0x4000000?

-- 
Felipe Contreras
