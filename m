From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP2xxx EAC: update per recent IO address changes
Date: Thu, 4 Sep 2008 23:52:21 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809042352080.25143@utopia.booyaka.com>
References: <20080905052312.28183.55601.stgit@localhost.localdomain> <20080905052419.28183.16156.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52943 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYIEFwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 01:52:23 -0400
In-Reply-To: <20080905052419.28183.16156.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thu, 4 Sep 2008, Paul Walmsley wrote:

> Commit f228a725b975832ac5771ab2fc86d06bd694cdb3 breaks the build for this
> driver; fix by using OMAP2_IO_ADDRESS.

Hmmm.  I should be using ioremap().  New version coming.


- Paul
