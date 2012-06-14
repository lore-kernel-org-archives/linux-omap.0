From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Thu, 14 Jun 2012 08:22:55 -0500
Message-ID: <4FD9E5AF.6010201@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com> <4FD64D6D.3020401@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com> <4FD77EF1.8000600@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com> <4FD8A906.8080202@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50631 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab2FNNWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 09:22:54 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 06/14/2012 02:03 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, Jun 13, 2012 at 20:21:50, Hunter, Jon wrote:
>  
>> If the clk handle for the gpmc is passed to the gpmc driver, then there
>> is no reason why the driver cannot do this.
> 
> I believe passing clk details through platform data is an abuse of
> clock framework.

Why? You currently have a global variable storing the clock handle. It
can be quite common for drivers to know the clock frequencies of their
functional clocks. How else can drivers calculate timings?

Jon
