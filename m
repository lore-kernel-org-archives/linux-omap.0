From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 9/10] drivers/mmc: Move a dereference below a NULL test
Date: Mon, 20 Jul 2009 13:47:36 +0100
Message-ID: <20090720134736.605f86d1@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0907191729580.16542@ask.diku.dk>
	<4A642458.6080008@nokia.com>
	<c656a4d20907200533t1cbe1476l62d8a51fdb796c70@mail.gmail.com>
	<4A64665B.9000504@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37235 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752235AbZGTMqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 08:46:37 -0400
In-Reply-To: <4A64665B.9000504@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: arun c <arun.edarath@gmail.com>, Julia Lawall <julia@diku.dk>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

> It is not a "NULL check" it is an assertion, which can be compiled out.
> On some platforms BUG is implemented as a null dereference anyway
> e.g. on ARM  it is *(int *)0 = 0;

It's a bogus check because the 

struct mmc_omap_host *host = slot->host;

has already been executed before you check for slot == NULL

