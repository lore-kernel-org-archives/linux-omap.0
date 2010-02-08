From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP2/3 clock: Extend find_idlest() to pass back
 idle state value
Date: Mon, 8 Feb 2010 10:37:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002081036480.22923@utopia.booyaka.com>
References: <1263892819-2330-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.1002051315020.18110@utopia.booyaka.com> <4B704B33.7010906@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab0BHRhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 12:37:23 -0500
In-Reply-To: <4B704B33.7010906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ranjith,

On Mon, 8 Feb 2010, Ranjith Lohithakshan wrote:

> On Sat, 06-Feb-10 1:46 AM +0530, Paul Walmsley wrote:
> > 
> > I had to make some changes to this patch for it to apply after the recent
> > clock split patches.  Could you please check this patch and make sure it
> > is okay?
> 
> It looks good to me. I have verified these latest changes on AM3517 EVM

Thanks, queued for 2.6.34.

- Paul
