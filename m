From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH v3 14/14] omap: mailbox: reorganize headers
Date: Tue, 25 May 2010 08:49:47 +0300
Message-ID: <20100525054947.GA26007@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
 <1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
 <20100524171634.GA23202@nokia.com>
 <AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50357 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab0EYFtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 01:49:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>

Hi,

On Mon, May 24, 2010 at 09:14:24PM +0200, ext Felipe Contreras wrote:
>Now, regarding device.h:

which was my only concern

>Now, I am pretty sure that platform_device.h will always depend on
>device.h that's why I removed them, but I can add them again if
>somebody wants to, but again, the situation is already bad.

so there's platform_device.h on that file, a little comment on the 
changelog would suffice to avoid this kind of mis-understanding.

-- 
balbi

DefectiveByDesign.org
