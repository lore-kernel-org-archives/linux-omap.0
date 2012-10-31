From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 05/13] ARM: OMAP2+: PRCM: create SoC-specific chip restart
 functions
Date: Wed, 31 Oct 2012 06:38:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210310638280.8340@utopia.booyaka.com>
References: <20121025231818.17558.57884.stgit@dusk.lan> <20121025232116.17558.47458.stgit@dusk.lan> <5090C6B5.3080407@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50509 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2JaGiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 02:38:51 -0400
In-Reply-To: <5090C6B5.3080407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 31 Oct 2012, Vaibhav Hiremath wrote:

> omap5xxx_restart declaration needs to be removed from here.
> There is no such function implemented in code.

Thanks, prototype dropped.


- Paul
