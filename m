From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] usb: musb: Update FIFO mode_5_cfg to accomodate 4K
Date: Tue, 4 May 2010 14:40:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322BA91B3@dbde02.ent.ti.com>
References: <1272963722-8659-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48672 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab0EDJLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 05:11:04 -0400
In-Reply-To: <1272963722-8659-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> FIFO table fifo_5_cfg was added so that it can be used as a
> workaround for OMAP34x/35x errata which limits the FIFO space
> uses to be within first 8K or next 8K.
> 
> Updating this table to accomodate an endpoint of 4K so that
> the same table can be used for high bandwidth transfers as
> used by some USB cameras.
> 

No issues with this patch as is, but it's probably high time we
made this fifo table something that the board files can pass down.

Is anyone already working on this, or should I give it a shot?

- Anand
