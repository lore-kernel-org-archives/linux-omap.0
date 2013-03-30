From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: standardize integration for AES & SHA/MD5
 IP blocks for 3.9
Date: Sat, 30 Mar 2013 22:49:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303302247510.6436@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302081752190.28008@utopia.booyaka.com> <20130304185019.GP11806@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab3C3Wtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 18:49:40 -0400
In-Reply-To: <20130304185019.GP11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On Mon, 4 Mar 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130208 09:57]:
>
> > For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
> > code and data to use hwmod and omap_device.  This is a prerequisite for moving
> > the hwmod code out of arch/arm.
> > 
> > Basic test logs are available at:
> > 
> >     http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.9/20130208093215/
> 
> Sorry looks like I totally missed this one somehow as discussed last
> week. Anyways, let's get it queued early at -rc2 or so, let me know
> if you want to update the branch or if I should just use this pull
> request.

Well, I missed -rc2, but here it is:

http://marc.info/?l=linux-arm-kernel&m=136468366425369&w=2

It's got a dependency on omap-cleanup-a-for-3.10 (the clock flags 
removal).


- Paul
