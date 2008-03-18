From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP MMC multiport support
Date: Tue, 18 Mar 2008 13:52:47 +0200
Message-ID: <20080318115247.GE7843@atomide.com>
References: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57919 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbYCRMw3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 08:52:29 -0400
Content-Disposition: inline
In-Reply-To: <814dfab70803180547i37859e48o5bdf33212ff7cd51@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Remith Ravi <remithmailinglist@gmail.com>
Cc: linux-omap@vger.kernel.org

* Remith Ravi <remithmailinglist@gmail.com> [080318 14:47]:
> Hi,
> 
> Is there any OMAP MMC driver implementation exist which support multi
> port implementation?
> I am working on OMAP-2530 EVM and want to have support for both MMC
> port 1 and port 2.
> 
> Please let me know if you have any input.

Well if 2530 has same controller as 2420, then yes, it should be
supported by configuring it in board-*.c files.

Tony
