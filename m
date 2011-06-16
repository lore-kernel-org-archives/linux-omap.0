From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Fix wrong OMAP_ES_x_y defines that make omap_rev_lt_x_y
 and friends misbehave
Date: Thu, 16 Jun 2011 18:57:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D563DE4@dbde02.ent.ti.com>
References: <BANLkTinWdQsjttt0m1h9KbVPjb6rWXNpvA@mail.gmail.com>
 <BANLkTi=75up6OQwRzGJ586eVLorEdpCa7w@mail.gmail.com>
 <20110614114116.GQ3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab1FPN1O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 09:27:14 -0400
In-Reply-To: <20110614114116.GQ3352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, June 14, 2011 5:11 PM
> To: Tasslehoff Kjappfot
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Fix wrong OMAP_ES_x_y defines that make 
> omap_rev_lt_x_y and friends misbehave
> 
> * Tasslehoff Kjappfot <tasskjapp@gmail.com> [110614 03:35]:
> > From 620fa271b32f8bdd8f06954c0a2c96af6ed1dc7b Mon Sep 17 
> 00:00:00 2001
> > From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
> > Date: Tue, 14 Jun 2011 12:06:09 +0200
> > Subject: [PATCH] Fix wrong OMAP_ES_x_y defines that make
> > omap_rev_lt_x_y and friends misbehave
> 
> Hmm, we don't seem to have these in the mainline kernel?
> Maybe take a look if something still needs to patched
> there?

[sp] Yes. these don't apply on mainline.
     I believe the kernel is using this patch I submitted [1],
     (or derived from it), but missing [2].

Tony,
  Now that there are multiple processors with their own
  revisions, do you believe an update version of [1]
  patch would be useful?

  [1] http://marc.info/?l=linux-omap&m=127972517400499&w=2
  [2] http://marc.info/?l=linux-omap&m=128597605524824&w=2
 
~sanjeev

> 
> Tony
> 
