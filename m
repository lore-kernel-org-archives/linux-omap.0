From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 01/12] ARM: OMAP2+: declare file-local functions as
 static
Date: Wed, 11 Apr 2012 12:16:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111215480.29473@utopia.booyaka.com>
References: <20120411003454.27059.37500.stgit@dusk> <20120411003516.27059.99477.stgit@dusk> <201204110843.57548.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44589 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760820Ab2DKSQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 14:16:13 -0400
In-Reply-To: <201204110843.57548.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Govindraj R <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, David Anders <x0132446@ti.com>

On Wed, 11 Apr 2012, Arnd Bergmann wrote:

> On Wednesday 11 April 2012, Paul Walmsley wrote:
> > Several function declarations used only in the files in which they're
> > declared should include the static keyboard, but don't:
> 					^^^ ???

Heh, should have read "keyword".

> The patch looks good otherwise,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the comment, ack added.

- Paul
