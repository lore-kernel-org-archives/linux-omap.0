From: Frantisek Dufka <dufkaf@seznam.cz>
Subject: Re: 2.6.26-rc3-omap vs N810 and Xomap
Date: Thu, 29 May 2008 10:21:12 +0200
Message-ID: <483E6778.1030003@seznam.cz>
References: <20080525203855.2f6037f6@gen2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:51822 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbYE2Ifu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 May 2008 04:35:50 -0400
In-Reply-To: <20080525203855.2f6037f6@gen2.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Radoslaw Szkodzinski <astralstorm@gen2.org>
Cc: linux-omap@vger.kernel.org

Radoslaw Szkodzinski wrote:
> Hello,
> 
> I've managed to get 2.6.26-rc3-omap booting (was quite easy actually).
> Now I hit a road block - I get everything to start, it boots nicely
> (checked with SSH), but fails to display anything except a white screen.
> Looks like Xomap can't (re)init framebuffer, or focus isn't transferred
> to it.
> Any known possible reasons?
> 

Maybe your Xomap is built with older omapfb.h? I don't know about 2.6.2x 
kernels but I was bitten by this when trying Xomap binary built for N800 
with 2.6.18 on 770 with 2.6.16 kernel. There was change in 
OMAPFB_UPDATE_WINDOW ioctl and the symptomps were similar.

Frantisek
