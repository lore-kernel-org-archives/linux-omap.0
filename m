From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 14:32:54 +0200
Message-ID: <AANLkTikTmBxjRfy-0Ks_iJk2O7+jMYoKk6WChyO21wDW@mail.gmail.com>
References: <20101002004821.GN3117@atomide.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
 <AANLkTim_x=AykoGMZkHTPpXkX=6k+QA04VetqY56c57G@mail.gmail.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC09@dbde02.ent.ti.com>
 <AANLkTikMmqe0ozTLY5qc8O3k=_vLAa1n2PB7cYsrEuR7@mail.gmail.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC13@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47245 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab0JDMdQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 08:33:16 -0400
Received: by iwn5 with SMTP id 5so6867260iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 05:33:15 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CC13@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 4, 2010 at 2:20 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> Can you post complete boot log? so far, it failed on one blaze and
> one 3430sdp both of them are having es2.0

Sure:

wizery.com/ohad/blaze-linux-omap.txt.gz

Summary of my setup:
- Blaze ES2.0
- linux-omap-2.6 master branch (commit
0882b1455797b0a104978000a622c3f2412e7cf5 "omap: READ CAREFULLY: Fix
build after merging in hwmod support for testing")
- omap2plus_defconfig
- kernel boots (with 2-3 warnings)
