From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 3/3] DSPBRIDGE: NULL Pointer Dereference fix
Date: Mon, 18 Jan 2010 12:31:16 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50D12@dlee03.ent.ti.com>
References: <1263431476-19206-1-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-2-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-3-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53222 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337Ab0ARSbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:31:24 -0500
In-Reply-To: <1263431476-19206-4-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

>From: Omar Ramirez Luna on Wednesday, January 13, 2010 7:11 PM
>
>From: Ernesto Ramos <ernesto@ti.com>
>
>This patch takes care of the possible null pointers
>dereferenced within dsp bridge driver.
>
>Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>CC: Nishanth Menon <nm@ti.com>
>CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
>CC: Ameya Palande <ameya.palande@nokia.com>
>---
> drivers/dsp/bridge/rmgr/nldr.c   |    3 ++-
> drivers/dsp/bridge/rmgr/node.c   |    6 +++---
> drivers/dsp/bridge/rmgr/proc.c   |    9 ++++-----
> drivers/dsp/bridge/wmd/chnl_sm.c |    2 +-
> 4 files changed, 10 insertions(+), 10 deletions(-)
>

Pushed to dspbridge.

- omar
