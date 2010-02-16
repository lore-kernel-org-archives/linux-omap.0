From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
Date: Tue, 16 Feb 2010 20:27:15 +0200
Message-ID: <94a0d4531002161027k421304a3j80a7433363ab3a5d@mail.gmail.com>
References: <cover.1266326009.git.ameya.palande@nokia.com>
	 <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:53026 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771Ab0BPS1S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 13:27:18 -0500
Received: by ywh6 with SMTP id 6so4774040ywh.4
        for <linux-omap@vger.kernel.org>; Tue, 16 Feb 2010 10:27:16 -0800 (PST)
In-Reply-To: <f966f5c490999696e567486ded3b08c4c01f366f.1266326009.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, felipe.contreras@nokia.com, nm@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, x0095840@ti.com

On Tue, Feb 16, 2010 at 3:20 PM, Ameya Palande <ameya.palande@nokia.com> wrote:
> In its current state DMM_RES_OBJECT is not correctly tracking reserve and
> unreserve but only map and unmap. So lets rename it to DMM_MAP_OBJECT to
> clarify what it is really doing!
>
> In addition to this, this patch also does some trivial code cleanup.
>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

Reviewed-by: Felipe Contreras <felipe.contreras@nokia.com>

-- 
Felipe Contreras
