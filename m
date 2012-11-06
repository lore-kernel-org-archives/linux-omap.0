From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after
 re-enabling gic
Date: Tue, 6 Nov 2012 11:15:25 +0200
Message-ID: <1352193325.8788.40.camel@sokoban>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
	 <1350552010-28760-7-git-send-email-t-kristo@ti.com>
	 <878vafg008.fsf@deeprootsystems.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab2KFJPj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 04:15:39 -0500
In-Reply-To: <878vafg008.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Colin Cross <ccross@android.com>, Sebastien Jan <s-jan@ti.com>

On Mon, 2012-11-05 at 14:25 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Colin Cross <ccross@android.com>
> >
> > 'Workaround for ROM bug because of CA9 r2pX gic control'
> > register change disables the gic distributor while the secondary
> 
> Just to clarify: this is referring to PATCH 3/8 of this series, correct?
> 

Yes.

-Tero

