From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: hwmod: Enable the keypad
Date: Tue, 31 May 2011 05:38:54 -0700
Message-ID: <20110531123854.GD11352@atomide.com>
References: <1298526157-2856-1-git-send-email-shubhrajyoti@ti.com>
 <4D6639DF.2040009@ti.com>
 <4DD4F52B.5070209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37508 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750818Ab1EaMi4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 08:38:56 -0400
Content-Disposition: inline
In-Reply-To: <4DD4F52B.5070209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shubhrajyoti <shubhrajyoti@ti.com> [110519 03:43]:
> On Thursday 24 February 2011 04:28 PM, Cousson, Benoit wrote:
> >On 2/24/2011 6:42 AM, Datta, Shubhrajyoti wrote:
> >>From: Shubhrajyoti D<shubhrajyoti@ti.com>
> >>
> >>Enable the keypad in the hwmod database.
> >>
> >>Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> >>Cc: Benoit Cousson<b-cousson@ti.com>
> >
> >Acked-by: Benoit Cousson<b-cousson@ti.com>
> Could this patch be queued for the next merge window. If there are
> no further comments.

Adding to fixes with the following description:

    Commit 407a6888f7362cb3dabe69ea6d9dcf3c750dc56a (OMAP4: hwmod data:
    Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU) added the
    entry for keypad, but did not enable it.
    
    Enable the keypad in the hwmod database so it works.

Regards,

Tony
