From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Thu, 20 May 2010 05:30:10 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E22DF08@dlee03.ent.ti.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
 <4BF44384.40901@ti.com> <20100520010046.GL5818@atomide.com>
 <4BF48A4E.7040208@ti.com> <20100520010622.GM5818@atomide.com>
 <4BF48BAC.6080904@ti.com> <20100520012425.GN5818@atomide.com>
 <4BF4951D.8010300@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C56668CA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45298 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab0ETKaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 06:30:13 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C56668CA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Hi,

> > Bad news: Same results I got as in linus tree - NAK for NFS booting :(
> > full log: http://pastebin.mozilla.org/725960
> > from the log, I dont see the driver probe even starting up or any
> > reports as you posted above (which I guess is from Blaze)..
> >
> As Tony pointed out, those patches are enough to get ethernet working.
> 

>From my side... this is the latest commit...

  commit 7b93a0d31f28bd6e531bae7f59716a04d943fe8d
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Wed May 19 17:41:36 2010 -0700
      Linux-omap rebuilt: Updated with final patches queued into for-next

One extra macro for my old filesystem
  CONFIG_SYSFS_DEPRECATED_V2

My bootargs

  setenv bootargs mem=255M console=ttyS2,115200n8 noinitrd root=/dev/nfs rw nfsroot=10.87.231.229:/data/EVM_filesystems/x0066660/filesystem/target.clean,nolock,tcp,rsize=8192,wsize=8192 ip=dhcp

Let us know if this works...

Best Regards
Abraham
