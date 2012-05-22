From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 0/3] GPMC NAND isr using standard API
Date: Tue, 22 May 2012 04:26:32 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98EE28@DBDE01.ent.ti.com>
References: <cover.1337090835.git.afzal@ti.com>
 <20120519125018.GA2407@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43566 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2EVE0v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 00:26:51 -0400
In-Reply-To: <20120519125018.GA2407@parrot.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Ivan,

On Sat, May 19, 2012 at 18:20:18, Ivan Djelic wrote:

> Hi Afzal,
> 
> I tried to take your series of patches, but I had issues with the
> first [1] (I did not try the others): it depends on the following patch,
> which is not in the l2-mtd-2.6 tree:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg68258.html
> 
> and it does not apply anyway to l2-mtd-2.6 because of (at least) the
> following patches:
> 
> http://lists.infradead.org/pipermail/linux-mtd/2012-April/040631.html
> http://lists.infradead.org/pipermail/linux-mtd/2012-April/040724.html
> 
> So, do you think you could rebase your series on l2-mtd-2.6 ?
> And maybe merge the 3 series into a single one, if they have circular
> dependencies ?

I am not sure what the workflow should be here, all patch series were
made over omap tree, if it is generated over mtd tree, similar issue
would happen for omap platform patches. 

In any case, for your reference, the 3 series of patches of had been
rebased over mtd tree, and is available,

git@gitorious.org:x0148406-public/linux-kernel.git gpmc-mtd.

To prevent confusion the 3 patch series has not been posted.

Tony, Artem, how should the conflict between omap & mtd trees be handled
for patch series ?

I believe it is better to send the 3 patch series into one as mentioned
by Ivan, and planning to do so, but in that case over which tree should
it be based ?

Regards
Afzal
