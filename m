From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: fix build error when undefining CONFIG_SMP
Date: Mon, 13 Jun 2011 07:35:01 -0700
Message-ID: <20110613143501.GG3352@atomide.com>
References: <BANLkTimf9D55OZ+-sOMPw2_WgG3QO_RooQ@mail.gmail.com>
 <4DF5B011.7080709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26480 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160Ab1FMOfE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 10:35:04 -0400
Content-Disposition: inline
In-Reply-To: <4DF5B011.7080709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "Vadillo, Miguel" <vadillo@ti.com>, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110612 23:32]:
> On 6/13/2011 11:55 AM, Vadillo, Miguel wrote:
> >
> >Function omap_smc2 is undeclared when disabling SMP

Looks like this won't apply to current mainline kernel, care
to check if it's still needed?

Tony

