From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
Date: Thu, 17 Feb 2011 08:17:57 -0800
Message-ID: <20110217161756.GO20795@atomide.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
 <20110217104207.GB17370@m-desktop>
 <4D5D0162.6010505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20641 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1BQQSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 11:18:22 -0500
Content-Disposition: inline
In-Reply-To: <4D5D0162.6010505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Lambert, David" <dlambert@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

* Cousson, Benoit <b-cousson@ti.com> [110217 03:05]:
> >
> >McSPI is already merged to l-o master. Will not this series breaks spi
> >hwmod?

The master branch is just a merge of the various branches, I have not
yet merged any of the hwmod touching branches into omap-for-linus.
 
> It will not break, it will just make the merge a little bit painful
> for Tony if we do not re-submit the updated McSPI hwmod data for
> OMAP4.

I'll apply Benoit's patches first, then merge or rebase the hwmod
data touching branches with that. This way following hwmod related
patches will not have merge conflicts.

Regards,

Tony
