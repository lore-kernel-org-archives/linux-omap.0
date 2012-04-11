From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 01/12] ARM: OMAP2+: declare file-local functions as static
Date: Wed, 11 Apr 2012 08:43:57 +0000
Message-ID: <201204110843.57548.arnd@arndb.de>
References: <20120411003454.27059.37500.stgit@dusk> <20120411003516.27059.99477.stgit@dusk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65471 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab2DKJMM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 05:12:12 -0400
In-Reply-To: <20120411003516.27059.99477.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Govindraj R <govindraj.raja@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, David Anders <x0132446@ti.com>

On Wednesday 11 April 2012, Paul Walmsley wrote:
> Several function declarations used only in the files in which they're
> declared should include the static keyboard, but don't:
					^^^ ???

The patch looks good otherwise,

Acked-by: Arnd Bergmann <arnd@arndb.de>

