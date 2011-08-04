From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 3/4] TI816X: clock: Add clockdomains and powerdomains
 data
Date: Thu, 4 Aug 2011 22:58:22 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABA7E9FB@dbde02.ent.ti.com>
References: <1301070022-8405-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1107160154080.25013@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60794 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383Ab1HDR2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 13:28:31 -0400
In-Reply-To: <alpine.DEB.2.00.1107160154080.25013@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Paul Walmsley wrote on Saturday, July 16, 2011 1:25 PM:

> On Fri, 25 Mar 2011, Hemant Pedanekar wrote:
> 
>> This patch adds data for various clock domains and power domains in TI816X.
>> 
>> Note that at present this is not exhaustive and need to add missing
>> domains. 
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>> ---
>>  arch/arm/mach-omap2/clockdomains816x.h |  167
> ++++++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/powerdomains816x.h |   74 ++++++++++++++
>>  2 files changed, 241 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-omap2/clockdomains816x.h
>>  create mode 100644 arch/arm/mach-omap2/powerdomains816x.h
> 
> Static data shouldn't be declared in .h files; it should be declared in
> *domains81*_data.c files, as is the practice with the rest of the
> powerdomains/clockdomains data here.
> 
Will take care of this in next version.

Thanks.

   Hemant