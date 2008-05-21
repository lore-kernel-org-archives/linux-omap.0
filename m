From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: sdio cmd53 doesn't work on omap 2430sdp
Date: Wed, 21 May 2008 14:42:09 -0500
Message-ID: <2e1baaf9ae66f81f8c4352d583da0e8f@felipebalbi.com>
References: <200805211521.10604.dmytro.chumak@inobject.com> <007901c8bb40$f8b8a290$538918ac@ent.ti.com> <200805211616.39484.dmytro.chumak@inobject.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40745 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758208AbYEUTmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 15:42:19 -0400
In-Reply-To: <200805211616.39484.dmytro.chumak@inobject.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmytro.chumak@inobject.com
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org



On Wed, 21 May 2008 16:16:39 +0300, Dmitriy Chumak
<dmytro.chumak@inobject.com> wrote:
> On Wednesday 21 May 2008 15:48:27 you wrote:
> 
>> the SDIO core issues a series of CMD52 to read the card capabilities and
>> Setup the bus width etc... Does these go through fine for the card you
> are
>> using? Does the core detect the new SDIO card?
> 
> Yes, all these go fine and the core detects a new SDIO card, only CMD53
> doesn't work. Could it be because of using DMA? Are there any way to not
> use
> DMA with CMD53?

You can disable dma for the whole driver by changing the following line
from:

736         host->use_dma   = 1;

to:

736         host->use_dma   = 0;

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

