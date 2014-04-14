From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH RFC v2 0/2] Fix simple-card *-master DT parameter
 handling
Date: Mon, 14 Apr 2014 12:53:43 +0300
Message-ID: <534BB027.8000808@ti.com>
References: <cover.1394451329.git.jsarha@ti.com>	<877g80rzgg.wl%kuninori.morimoto.gx@gmail.com>	<CAHPCO9FmL__LmUyMRhsy2mnPNAV0h--aMY=GBJjL9TBrAqWSFw@mail.gmail.com>	<87wqg0q74d.wl%kuninori.morimoto.gx@gmail.com>	<5320286D.6080009@ti.com> <878ur81ou7.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40870 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbaDNJyA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Apr 2014 05:54:00 -0400
In-Reply-To: <878ur81ou7.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Richard Lee <superlibj8301@gmail.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com

On 04/14/2014 08:07 AM, Kuninori Morimoto wrote:
>
> Hi Jyri, Mark
>
...
> Could you please teach me current status of this patch ?

Hi,
This patch-set was never merged as such. Instead there is another 
patch-set that has been applied by Mark to cover this issue [1]. The 
patch maintains backward compatibility, with the Nicolin Chen's patch 
[2]. In other words, old style "bitclock-master" and "frame-master" 
boolean parameters are read from the codec node if they can not be found 
from the top level node. The backward compatibility does not apply to 
multi-link [3] configurations.

Best regards,
Jyri


[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074717.html

[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074219.html

[3] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074592.html

ps. The discussions that lead to the current solution can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074388.html

