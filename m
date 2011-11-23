From: Sergey Kibrik <sergiikibrik@ti.com>
Subject: Re: [PATCH 35/65] OMAPDSS: APPLY: move spinlock outside the struct
Date: Wed, 23 Nov 2011 12:29:27 +0200
Message-ID: <4ECCCB07.10702@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:53753 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753861Ab1KWK3e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:29:34 -0500
In-Reply-To: <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On 11/22/2011 11:21 AM, Tomi Valkeinen wrote:
> dss_cache struct contains a spinlock used to protect the struct. A more
> logical place for the spinlock is outside the struct that it is
> protecting. So move it there.

a small question: isn't it clearer to keep lock inside struct, so it would be easier to read code? Say, if we meet

> spin_lock_irqsave(&dss_cache.lock, flags);

in code we already aware of what struct being actually protected, and in case of external lock it's not that obvious

-- 
regards,
Sergey
