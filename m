From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] omap4: Add board_data and initialise the serial pads
Date: Thu, 20 Jan 2011 09:33:00 -0800
Message-ID: <20110120173259.GV4957@atomide.com>
References: <1295363712-5940-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55328 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab1ATRdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 12:33:13 -0500
Content-Disposition: inline
In-Reply-To: <1295363712-5940-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, santosh.shilimkar@ti.com

Hi,

* sricharan <r.sricharan@ti.com> [110118 07:11]:
> Pass the board specific serial pad mux data
> to the platform level init code.
> 
> Signed-off-by: sricharan <r.sricharan@ti.com>
> ---
> This is a test patch and not intended for a specific use case.
> 
> 1) The support to add the pad data to the device hwmod entry and to use
>    it to dynamically configure the pads based on the state of the
>    hwmod is already present.
> 
> 2) But using that for pads that requires only  initialisation and not 
>    dynamic remux, brings in a overhead to iterate over all the
>    hwmod signals of the device for every device enable/idle transitions.

The right fix for this problem is to change the mux code to keep a separate
list for dynamic pads and static pads. That way all the static pads can
be skipped, and the dynamic list is empty in most cases.

Regards,

Tony
