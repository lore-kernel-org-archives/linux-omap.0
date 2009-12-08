From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
Date: Wed, 9 Dec 2009 00:19:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372105C9@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1256724210-20581-1-git-send-email-hvaibhav@ti.com>
	 <19F8576C6E063C45BE387C64729E73940436EEAD77@dbde02.ent.ti.com>
	 <20091110010905.GR23952@atomide.com>
	 <19F8576C6E063C45BE387C64729E73940436F94084@dbde02.ent.ti.com>
 <1257847956.2400.62.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49152 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119AbZLHStg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 13:49:36 -0500
In-Reply-To: <1257847956.2400.62.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Tuesday, November 10, 2009 3:43 PM
> To: Hiremath, Vaibhav
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/2] OMAP3: Enable DSS2 for OMAP3EVM board
> 
> On Tue, 2009-11-10 at 04:42 +0100, ext Hiremath, Vaibhav wrote:
> 
> > >
> > > It's best that we let Tomi queue up all the DSS2 related
> patches.
> > [Hiremath, Vaibhav] I am ok with that.
> > Let me update this patch with the latest kernel + DSS2 and re-
> submit it again.
> 
> Wait until DSS2 patches have been merged. I don't want the extra
> complexity of board/panel patches, there's enough work with just the
> half-megabyte DSS patches =).
> 
[Hiremath, Vaibhav] Tomi and Tony,

Now since DSS2 has already merged to linux-omap/master, I think now we can merge all other dependent patches like,

	- OMAP3EVM support
	- Sharp LQ LCD panel
	- AM3517EVM support
	- V4L2 Driver support

Please let me know your opinion on this, so that I can submit it to the list.

Thanks,
Vaibhav

>  Tomi
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

