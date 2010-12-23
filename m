From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex
 modules.
Date: Thu, 23 Dec 2010 12:06:32 -0600
Message-ID: <4D138FA8.9030109@ti.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>	<1292864437-15353-5-git-send-email-thara@ti.com>	<4D133B78.5030807@ti.com>	<a58103fd01d89decba08fcdf282b7f70@mail.gmail.com> <87d3osl8bl.fsf@deeprootsystems.com> <4D1385D6.6090407@ti.com> <3f3f455d44f6ee5009a9ea387f35376c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37639 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753021Ab0LWSGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 13:06:36 -0500
Received: by yxe42 with SMTP id 42so2915032yxe.9
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 10:06:35 -0800 (PST)
In-Reply-To: <3f3f455d44f6ee5009a9ea387f35376c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, Anand Sawant <sawant@ti.com>

Vishwanath Sripathy had written, on 12/23/2010 11:36 AM, the following:
[..]
>> Further, why is SR enabled by default on this platform if it does not
>> have all domains available to be enabled (e.x. we dont have it on
>> PandaBoard even though it is OMAP4 rt?)
> Why do you think SR is enabled by default? The above log says that SR
> Module is initialized. However sr auto compensation is not started by
> default.
oops.. my bad. Apologies, I missed that this is part of probe path not 
part of sr_classX_init path. looking at the code, I will refrain from 
commenting further on probe function at this point.

-- 
Regards,
Nishanth Menon
