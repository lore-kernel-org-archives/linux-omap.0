From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Re: Resume crash: MUSB interrupt routine interactions with omap2430_musb_set_vbus()
Date: Thu, 06 Sep 2012 08:45:07 -0500
Message-ID: <k2a9d3$fuk$1@ger.gmane.org>
References: <5048A6B3.8030503@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40699 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab2IFNpW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 09:45:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1T9cOW-0000Ul-R8
	for linux-omap@vger.kernel.org; Thu, 06 Sep 2012 15:45:20 +0200
Received: from 66-162-60-14.static.twtelecom.net ([66.162.60.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 15:45:20 +0200
Received: from tim.nordell by 66-162-60-14.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 15:45:20 +0200
In-Reply-To: <5048A6B3.8030503@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Felipe let me know of the patch that I didn't see in the queue.

Thanks!

- Tim

On 09/06/12 08:35, Tim Nordell wrote:
> All -
>
> We've been doing some suspend/resume testing and found that on occasion
> (on the order of 1 in 5000 cycles) the system would lock up. The problem
> was traced into the MUSB subsystem. Specifically, the interrupt
> requested inside musb_core.c is of the non-threaded type (e.g. it runs
> in the interrupt context).

