From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/5] OMAP4: DSS2: HDMI: Add support for audio
Date: Wed, 18 May 2011 09:13:46 +0300
Message-ID: <1305699226.1834.2.camel@deskari>
References: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
	 <1305655217.1883.51.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37687 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753474Ab1ERGNw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 02:13:52 -0400
Received: by mail-ey0-f181.google.com with SMTP id 5so370565eyh.26
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 23:13:51 -0700 (PDT)
In-Reply-To: <1305655217.1883.51.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

Hi,

On Tue, 2011-05-17 at 13:00 -0500, Ricardo Neri wrote:
> Hi,
> 
> I would like to solicit comments on this set of patches. Now that ASoC
> part of the implementation has been Ack'ed by ASoC maintainers, these
> patches are needed.

I think the patches look ok. However, they don't apply to the current
DSS2 master branch. Can you rebase to

git://gitorious.org/linux-omap-dss2/linux.git master

and send me patches or a git url from which I can pull.

 Tomi


