From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Wed, 6 Aug 2008 07:21:14 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
 <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52949 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429AbYHFMYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 08:24:36 -0400
In-Reply-To: <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Why not use normal uncached memory? Strongly ordered is pretty
> inefficient as it cannot do any reordering or write buffer merging
> (it's
> like having a memory barrier before and after each instruction).
> Speculative accesses are not allowed either. Strongly ordered memory
> is
> not really meant for executing code from.

It could be.  This is a discussion we were having off line.

The code in question is a small bit of assembly interacting with hardware mainly and has not been audited for full pipeline/buffering correctness.

Most of the weak memory attributes in newer ARMs are not exploited today in tree.  I'll guess this was more a correctness and capability judgment from Russell.

Regards,
Richard W.

