From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/1] omap: Ptr "isr_reg" tracked as NULL was
 dereferenced
Date: Tue, 16 Nov 2010 13:39:18 -0800
Message-ID: <20101116213918.GN9264@atomide.com>
References: <cd6fa21776a4564d602cc072358a4bf79a9fe883.1289205105.git.EXT-Eugeny.Kuznetsov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32249 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab0KPVjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 16:39:36 -0500
Content-Disposition: inline
In-Reply-To: <cd6fa21776a4564d602cc072358a4bf79a9fe883.1289205105.git.EXT-Eugeny.Kuznetsov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk

* Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com> [101108 00:35]:
> From: Evgeny Kuznetsov <ext-eugeny.kuznetsov@nokia.com>
> 
> Value of "isr_reg" pointer is depend on configuration and GPIO method.
> Potentially it may have NULL value and it is dereferenced later
> in code. Warning and exit from function are added in this case.

Thanks, queueing this for 2.6.38 merge window.

Tony
