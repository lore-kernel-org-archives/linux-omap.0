From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Mon, 29 Aug 2011 12:24:48 -0400
Message-ID: <1314635090.2344.53.camel@deneb.redhat.com>
References: <20110829085209.GB26917@n2100.arm.linux.org.uk>
	 <Pine.LNX.4.44L0.1108290951250.2525-100000@iolanthe.rowland.org>
	 <CACVXFVNTGsaw2jLosqrTOdnZX399VfE7dWuVYvLcN50_bsa+tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1H2QZN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 12:25:13 -0400
In-Reply-To: <CACVXFVNTGsaw2jLosqrTOdnZX399VfE7dWuVYvLcN50_bsa+tQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Santosh <santosh.shilimkar@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, 2011-08-29 at 23:55 +0800, Ming Lei wrote:
> If writing to coherent memory can't reach physical memory immediately on
> other ARCHs,  the problem can still happen on these ARCHs. But I am
> not sure if there are these kind of ARCHs except for ARM.

If there is write buffering which prevents outside bus masters from
seeing the data, can we really call it coherent memory?

--Mark


