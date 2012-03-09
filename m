From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod data: cleanup in preparation for
 link array removal
Date: Thu, 8 Mar 2012 19:04:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203081900500.26543@utopia.booyaka.com>
References: <alpine.DEB.2.00.1203072102150.21662@utopia.booyaka.com> <20120309014016.GC12083@atomide.com> <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40404 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab2CICEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 21:04:32 -0500
In-Reply-To: <alpine.DEB.2.00.1203081851570.9551@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

on second thought...

On Thu, 8 Mar 2012, Paul Walmsley wrote:

> On Thu, 8 Mar 2012, Tony Lindgren wrote:
> 
> > Got these now merged into l-o master, but ran into a merge
> > conflict with already queued sr branch. Resolved it by using
> > your version except left out vdd_name.
> 
> Definitely we want the vdd_name fields.  Other than that it looks okay.  

I guess that other SR series that you merged removed the vdd_name fields?

If so then yeah, we'd better leave those out.

This means that I'm going to have to rebase those big hwmod data changes 
:-(

Can you send me a stable commit for that?


- Paul
