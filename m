From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 0/3] Prepare for OMAP2+ movement to Common Clk
Date: Thu, 30 Aug 2012 20:56:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1208302052210.29754@utopia.booyaka.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42350 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2H3U4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:56:15 -0400
In-Reply-To: <1346230576-20004-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Rajendra

On Wed, 29 Aug 2012, Rajendra Nayak wrote:

> Changes in v4:
> * Added *hack* comments around clk_prepare usage in hwmod
> rebased on 3.6-rc

Assuming this is so (haven't looked closely at this series yet), and after 
the existing comments are taken into consideration and a new version 
reposted, will queue this series for 3.7.

Care to respin your series that converts the data also, on top of your new 
version of this series?  We should try to get that into 3.7 also.
BTW are you still waiting for something from Vaibhav Hiremath for this?  
Or can the scripts convert the existing clock33xx_data.c also?


- Paul
