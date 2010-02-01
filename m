From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bug: access to already released memory
Date: Mon, 1 Feb 2010 15:10:16 -0800
Message-ID: <20100201231016.GH22747@atomide.com>
References: <a328840c1001301356r14505614pbb4563754c6890ac@mail.gmail.com>
 <20100131035540.GA13428@linux-sh.org>
 <a328840c1001310200n6314cf2emf69656b807fcb191@mail.gmail.com>
 <alpine.DEB.2.00.1002011426400.20004@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50248 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab0BAXJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Feb 2010 18:09:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002011426400.20004@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Marek Skuczynski <mareksk7@gmail.com>, linux-omap@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

* Paul Walmsley <paul@pwsan.com> [100201 13:25]:
> On Sun, 31 Jan 2010, Marek Skuczynski wrote:
> 
> > Hello,
> >    I have found an access to already released memory in
> > clk_debugfs_register_one() function,
> >    attaching a patch. The included patch was prepared for Linux 2.6 repository.
> > 
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks Marek and Paul.

Adding to omap-fixes queue for 2.6.33.

Tony
