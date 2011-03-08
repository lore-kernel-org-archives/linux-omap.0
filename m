From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] OMAP2+: powerdomain: add
 pwrdm_can_ever_lose_context()
Date: Tue, 8 Mar 2011 11:10:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081108300.10981@utopia.booyaka.com>
References: <20110308021018.31946.29962.stgit@twilight.localdomain> <20110308021551.31946.19903.stgit@twilight.localdomain> <AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39629 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab1CHSKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 13:10:55 -0500
In-Reply-To: <AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 8 Mar 2011, Varadarajan, Charulatha wrote:

> Do you really want to return 1 in case of invalid powerdomain pointer?

Sure, that's why I wrote it that way.  It seems less risky than returning 
0.  Do you have a proposal that makes more sense, given that this is going 
to be called immediately after a omap_{device,hwmod}_get_pwrdm() ?


- Paul
