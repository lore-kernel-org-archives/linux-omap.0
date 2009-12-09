From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [APPLIED] [PATCH v3] omap: serial: fix non-empty uart fifo read
 abort
Date: Wed, 9 Dec 2009 14:12:48 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ACBFA1C@dbde02.ent.ti.com>
References: <1259972404-28784-1-git-send-email-vikram.pandita@ti.com>
 <notify-1260224602@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33595 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbZLIInA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 03:43:00 -0500
In-Reply-To: <notify-1260224602@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> 
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
> 
> Branch in linux-omap: for-next-vol2
> 

Tony,

A query on this for-next-vol2 branch:
Is this branch going to be pushed in the current merge
window, or is it for the -rc series?


> PatchWorks
> http://patchwork.kernel.org/patch/65022/


With current Linus' tree + this patch, I can boot up on 3630.

Playing with the omap3_defconfig now, to see how many boards
we can boot up with a single image :)

- Anand
