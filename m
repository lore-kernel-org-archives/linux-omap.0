From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/2] Introduce support for AM35xx
Date: Mon, 2 Nov 2009 19:15:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBD82@dbde02.ent.ti.com>
References: <1256652138-5669-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbZKBNps convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 08:45:48 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA2Djob9008841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 Nov 2009 07:45:53 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA2DjnFx016722
	for <linux-omap@vger.kernel.org>; Mon, 2 Nov 2009 19:15:50 +0530 (IST)
In-Reply-To: <1256652138-5669-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Tuesday, October 27, 2009 7:32 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH 0/2] Introduce support for AM35xx
> 
> This patch adds support for the recently announced
> AM3505 and AM3517 devices from Texas Instruments.
> 
> It also defines the AM3517 EVM board. Detailed
> support will follow in subsequent patches.
> 
>   [1] http://www.ti.com/sitara 
>   [2] http://www.ti.com/arm 
>   [3] 
> http://tiexpressdsp.com/index.php?title=Applications_Processor
> s_Crossreference 
>   [4] http://marc.info/?l=linux-omap&m=125615009412281&w=2
>   
> The patches have been created against omap-next branch.
> 
> Sanjeev Premi (2):
>   AM35xx: Runtime detection of the device
>   AM35xx: Define the AM3517EVM board
> 
>  arch/arm/mach-omap2/Kconfig           |    4 +++
>  arch/arm/mach-omap2/id.c              |   43 
> ++++++++++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/cpu.h |   12 +++++++++
>  3 files changed, 53 insertions(+), 6 deletions(-)
> 
> 

Tony,

Do you have any comments on this series?

Best regards,
Sanjeev
