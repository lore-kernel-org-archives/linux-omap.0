From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/10] ARM: OMAP5: hwmod, clock and prm data files
Date: Wed, 3 Apr 2013 20:13:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304032012260.16711@utopia.booyaka.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59213 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762534Ab3DCUNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:13:36 -0400
In-Reply-To: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com

Hi,

On Fri, 18 Jan 2013, Santosh Shilimkar wrote:

> Series contains the hwmod, clock and prm data files for OMAP54xx SOCs.
> This data was kept out of tree to be validated on es2.0 silicon version
> and also to avoid the es1.0/es2.0 differences which are many.
> 
> Benoit Cousson, Rajendra Nayak, Paul Walmesly and Mike have all contributed
> to get the autogen scripts in shape for OMAP5.
> 
> >From various discussion on the list, the clock data files are suppose
> to be moved to drivers/clk/. Once the direction is clear, patch 8
> can be updated accordingly.
> 
> Patches are tested on OMAP5 sEVM and uEVM. For testing few additional patches
> are needed. Same tree can be fetched from here [1]
> 
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
> 
>   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/SantoshShilimkar/linux.git for_3.9/omap5_data_files
> 
> for you to fetch changes up to 7f534e1ebeb2bc64250b56fe00eb7d4dfa585e8e:
> 
>   ARM: OMAP5: Enable build and frameowrk initialisations (2013-01-18 19:45:48 +0530)

I've posted several comments on the patch contents themselves, all of 
which are relatively minor, and should be easy to fix:

http://marc.info/?l=linux-omap&m=136501977311223&w=2


- Paul
