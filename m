From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Wed, 19 May 2010 13:00:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666371@dbde02.ent.ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <20100518234222.GV5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55152 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975Ab0ESHas convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 03:30:48 -0400
In-Reply-To: <20100518234222.GV5818@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, May 19, 2010 5:12 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
> khilman@deeprootsystems.com
> Subject: Re: [PATCH 00/11] OMAP: GPIO: Implement GPIO in HWMOD way
> 
> * Charulatha V <charu@ti.com> [100518 07:44]:
> > This patch series implements GPIO module in platform device model.
> > It also makes OMAP2PLUS specific GPIO implemented in HWMOD FW way.
> >
> > This patch series is created on "origin/pm-wip/runtime".
> >
> > This patch series is tested on OMAP3430 SDP board. It would be of
> > great help if someone could test the same on OMAP1 and OMAP2 boards.
> 
> Great, thanks. Let's give review these, and then if no more comments,
> let's test them in the linux-omap master branch. Too late to get
> these merged for this merge window for sure.

GPIO uses pm_runtime APIs and unless all pm_runtime related patches are 
upstreamed, we cannot test this patch series on linux-omap master branch. 

> 
> Regards,
> 
> Tony
