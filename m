From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] staging: tidspbridge: use the right type for list_is_last
Date: Sun, 12 Dec 2010 13:02:07 +0100
Message-ID: <201012121302.07970.laurent.pinchart@ideasonboard.com>
References: <1291846823-31513-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45195 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0LLMBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 07:01:19 -0500
In-Reply-To: <1291846823-31513-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ionut Nicu <ionut.nicu@gmail.com>

Hi Omar,

On Wednesday 08 December 2010 23:20:23 Omar Ramirez Luna wrote:
> Removes the following warning:
> 
>   CC [M]  drivers/staging/tidspbridge/rmgr/rmm.o
> drivers/staging/tidspbridge/rmgr/rmm.c: In function 'rmm_alloc':
> drivers/staging/tidspbridge/rmgr/rmm.c:147: warning: passing
> 	argument 1 of 'list_is_last' from incompatible pointer type
> include/linux/list.h:170: note: expected 'const struct list_head *'
> 	but argument is of type 'struct rmm_ovly_sect *'

I was about to send the same patch.

> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
