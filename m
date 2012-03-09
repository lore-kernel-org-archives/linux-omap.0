From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
Date: Thu, 8 Mar 2012 18:57:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com> <20120309014016.GC12083@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41407 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2CIB5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 20:57:05 -0500
In-Reply-To: <20120309014016.GC12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Thu, 8 Mar 2012, Tony Lindgren wrote:

> Got these now merged into l-o master, but ran into a merge
> conflict with already queued sr branch. Resolved it by using
> your version except left out vdd_name.

Definitely we want the vdd_name fields.  Other than that it looks okay.  

> As the namings have changed for smartreflex, now I suspect it's broken 
> for the interrupts..

Hmm, not sure I understand that part?  AFAIK the SmartReflex code doesn't 
rely on hwmod names.  Or are you talking about the vdd_name?


- Paul
