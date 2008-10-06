From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/10] HDQ driver: Remove global pointer
Date: Mon, 6 Oct 2008 12:17:06 +0300
Message-ID: <20081006091705.GA2806@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EAA@dbde02.ent.ti.com> <20080925114057.GB31477@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58062 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbYJFJON (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:14:13 -0400
Content-Disposition: inline
In-Reply-To: <20080925114057.GB31477@2ka.mipt.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

* Evgeniy Polyakov <johnpol@2ka.mipt.ru> [080925 14:41]:
> Hi.
> 
> On Thu, Sep 25, 2008 at 12:19:44PM +0530, Gadiyar, Anand (gadiyar@ti.com) wrote:
> > From: Madhusudhan Chikkature <madhu.cr@ti.com>
> > 
> > This patch provides the necessary modifications to the driver to
> > remove the global ptr hdq_data.
> > 
> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> Looks ok, IA ck the whole serie.

Great, pushing to linux-omap tree.

Evgeniy, are these already in your queue for upstream?

Tony
