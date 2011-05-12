From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Thu, 12 May 2011 14:47:37 +0300
Message-ID: <1305200857.2062.24.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari> <4DCB80DD.5090408@compulab.co.il>
	 <4DCB8937.2060101@compulab.co.il> <4DCB9C71.2020503@compulab.co.il>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC13C0@dbde02.ent.ti.com>
	 <4DCBC273.9030807@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:49115 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755202Ab1ELLrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:47:42 -0400
Received: by mail-ey0-f173.google.com with SMTP id 6so495427eyb.4
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 04:47:40 -0700 (PDT)
In-Reply-To: <4DCBC273.9030807@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Janorkar, Mayuresh" <mayur@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>

On Thu, 2011-05-12 at 14:20 +0300, Igor Grinberg wrote:

> Right. Do both fixes make it work?
> 
> If it is, then Tomi,
> will you add both fixes to the patch set with our SOBs?
> or do you want this to be sent properly as a follow up?

Yes, I can add these all to the same patch and handle it through DSS
tree. Although due to the reluctance to make changes to arch/arm/*omap*,
I guess we'll pass these patches in this merge window.

Mayuresh, if you're able to test this and it works, can you send me the
full diff so that I don't make any mistakes combining the code?

 Tomi


