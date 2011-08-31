From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Wed, 31 Aug 2011 08:56:41 +0800
Message-ID: <CACVXFVN8PoJqKKBr8gejPHPEiKcv9r3Apskb0mPOPkEMdtuodA@mail.gmail.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57195 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab1HaA4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 20:56:43 -0400
In-Reply-To: <20110830175432.GG3464@e102144-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Mark Salter <msalter@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 31, 2011 at 1:54 AM, Will Deacon <will.deacon@arm.com> wrote:

> Although this doesn't have anything to do with ordering; it's all to do with
> immediacy so I think we should try to avoiding using the term `barrier'. If
> this can be made part of the coherent DMA API, that might be the best place
> for it (I can't think of any other areas this is needed given that the
> streaming DMA API and I/O accessors already deal with it).

Agree too.


thanks,
--
Ming Lei
