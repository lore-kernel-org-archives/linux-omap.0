From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 1/2 v2] DSPBRIDGE: remove dependency of mpu freq
Date: Tue, 2 Feb 2010 15:44:12 +0200
Message-ID: <20100202134411.GF4048@annwn.felipec.org>
References: <1265095046-25253-1-git-send-email-nm@ti.com>
 <1265095046-25253-2-git-send-email-nm@ti.com>
 <20100202130044.GB4048@annwn.felipec.org>
 <7A436F7769CA33409C6B44B358BFFF0C012E98E8B9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19011 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab0BBNo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:44:28 -0500
Content-Disposition: inline
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012E98E8B9@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Romit Dasgupta <romit@ti.com>

On Tue, Feb 02, 2010 at 02:41:51PM +0100, Nishanth Menon wrote:
> > From: Felipe Contreras [mailto:felipe.contreras@nokia.com]
> > You forgot to mention the impact of this patch: DVFS is effectively
> > disabled until the next patch is applied. Right?
> 
> That is the reason why it is a patch series 2/2 is the last of the
> series ;) I don't mind merging it as part of this patch though..

Yeah, but that's not mentioned in the commit msg of *this* patch; each
patch must make sense on its own.

-- 
Felipe Contreras
