From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Thu, 10 Feb 2011 16:13:50 +0000
Message-ID: <20110210161350.GA9350@n2100.arm.linux.org.uk>
References: <20110125125656.GG13300@n2100.arm.linux.org.uk> <20110125130422.GH13300@n2100.arm.linux.org.uk> <20110125130611.GA15663@n2100.arm.linux.org.uk> <627ff975140c8e4afbad281105b29d35@mail.gmail.com> <20110204104113.GD15004@n2100.arm.linux.org.uk> <c703383234131695d040a1e5b8a79413@mail.gmail.com> <20110204113053.GF15004@n2100.arm.linux.org.uk> <247f9ef444eeb8ca59de74837a3e9c62@mail.gmail.com> <20110207101829.GA32431@n2100.arm.linux.org.uk> <06aa531b67f240da586a7b56238d56b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39492 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1BJQOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 11:14:10 -0500
Content-Disposition: inline
In-Reply-To: <06aa531b67f240da586a7b56238d56b2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

On Thu, Feb 10, 2011 at 08:19:19PM +0530, Santosh Shilimkar wrote:
> This patch will need below update so that the smp_scu.h
> header can be included from assembly files. Will you
> fold this into your patch or you want me to
> send below as separate patch ?

Folded.
