From: Dmitriy Chumak <dmytro.chumak@inobject.com>
Subject: Re: sdio cmd53 doesn't work on omap 2430sdp
Date: Wed, 21 May 2008 16:16:39 +0300
Message-ID: <200805211616.39484.dmytro.chumak@inobject.com>
References: <200805211521.10604.dmytro.chumak@inobject.com> <007901c8bb40$f8b8a290$538918ac@ent.ti.com>
Reply-To: dmytro.chumak@inobject.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kyiv.inobject.com ([62.221.40.190]:58042 "EHLO
	kyiv.inobject.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763188AbYEUNcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 09:32:03 -0400
In-Reply-To: <007901c8bb40$f8b8a290$538918ac@ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org

On Wednesday 21 May 2008 15:48:27 you wrote:

> the SDIO core issues a series of CMD52 to read the card capabilities and
> Setup the bus width etc... Does these go through fine for the card you are
> using? Does the core detect the new SDIO card?

Yes, all these go fine and the core detects a new SDIO card, only CMD53 
doesn't work. Could it be because of using DMA? Are there any way to not use 
DMA with CMD53?

Regards,
Dmitriy

