From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8-omap] twl4030 power scripts, initsection fixups
Date: Mon, 16 Mar 2009 14:11:41 -0700
Message-ID: <200903161411.41810.david-b@pacbell.net>
References: <200903131825.52114.david-b@pacbell.net> <200903141200.53768.david-b@pacbell.net> <20090316002419.GA551@gandalf>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:33890 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753410AbZCPVLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2009 17:11:44 -0400
In-Reply-To: <20090316002419.GA551@gandalf>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: OMAP <linux-omap@vger.kernel.org>

On Sunday 15 March 2009, Felipe Balbi wrote:
> how about applying this one instead ?

Looks OK to me, though it implies re-ordering the patches
I sent on Friday since change prevents the updated

 From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
 Subject: Group and resource assignments for TWL4030

patch from applying ... that is, I *think* just applying
this one after that one will work.



> ================ cut here ===================
> 
> >From 1ce7606214e9b3caad9ccd3cc356f905c7a5ee23 Mon Sep 17 00:00:00 2001
> From: David Brownell <dbrownell@users.sourceforge.net>
> Date: Fri, 13 Mar 2009 18:25:52 -0700
> Subject: [PATCH] twl4030 power scripts, initsection fixups
> 
> Remove section mismatch warnings from twl4030 power script
> declaration ... unfortunately, this use-once data can't live
> in initdata sections (or initconst) until some driver stacks
> (starting with I2C) have better support for non-hotpluggable
> componentry.
> 
> [felipe.balbi@nokia.com: updated twl4030-power.c]
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>


