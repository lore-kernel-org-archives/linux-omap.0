From: Jason Kridner <jkridner@beagleboard.org>
Subject: Staging tree for AM335x platforms
Date: Wed, 21 Sep 2011 14:30:26 -0400
Message-ID: <CA+T6QP=H0=WYcrA0HL+06Az6mFk7=K0O3MYNR=t+5Za-vDSyJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63971 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469Ab1IUSab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 14:30:31 -0400
Received: by eya28 with SMTP id 28so1194300eya.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 11:30:29 -0700 (PDT)
Received: by ewy1 with SMTP id 1so1993390ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 11:30:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Tony,

I'm looking at creating a public repository to hold patches not yet in
shape for inclusion in linux-omap (if not personally, then someone at
TI that meets the below charter).  I know there can be concern that
this becomes a distraction if we start pulling in community patches.
It seems it needs to be coupled with reworking systems for acceptance
upstream, but we'd like for there to be something where community
members can generate patches against while we are in the process of
cleaning up the underlying platform bits.

Do you have any recommendations or guidelines that should be followed
regarding anything about such a public repository?  Recommendations
and guidelines can include, but not be limited to, where the
repository should live, where patches and pull requests should be
submitted, what types of patches should be accepted and what state
they should be in, when should it be rebased, who is suitable to
maintain this repository and what should be used for managing patch
status (ie. patchwork and which patchwork).

If this doesn't sound useful to you, then please feel free to shut me
down on this.  The goal is to help and it is understood that
contributions to the infrastructure (dev tree, pwr mgmt, etc.) are
required to be productive.

Regards,
Jason
