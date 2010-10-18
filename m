From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/1] omap: Ptr "isr_reg" tracked as NULL was
 dereferenced
Date: Mon, 18 Oct 2010 16:11:47 -0700
Message-ID: <20101018231147.GK13341@atomide.com>
References: <cover.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
 <7bb69801f49283c3bde78aa008c15308ac8a5fbf.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D099AFD@dbde02.ent.ti.com>
 <1286970199.12782.28.camel@ekuznets-lx-nokia>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D099B87@dbde02.ent.ti.com>
 <1286971758.12782.35.camel@ekuznets-lx-nokia>
 <1287123378.12782.49.camel@ekuznets-lx-nokia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62662 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab0JRXMC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 19:12:02 -0400
Content-Disposition: inline
In-Reply-To: <1287123378.12782.49.camel@ekuznets-lx-nokia>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Cc: "ext Varadarajan, Charulatha" <charu@ti.com>, linux-omap@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tero.kristo@nokia.com" <tero.kristo@nokia.com>

* Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com> [101014 23:11]:
> On Wed, 2010-10-13 at 16:09 +0400, Evgeny Kuznetsov wrote:
> > On Wed, 2010-10-13 at 17:20 +0530, ext Varadarajan, Charulatha wrote:
> Hi Tony,
> 
> It is not a bug fix, it is just check to prevent potential issues. Used
> to warn in case of bug and prevent kernel oops. Check added only here
> (not all gpio code cleanup) since here it could cause kernel opps.
> 
> Would you apply patch if I will leave only if condition section in
> patch?
> 
> 	if (WARN_ON(!isr_reg))
> 		goto exit;
> 
> If yes, I'll resend v3 patch.

Sounds like a valid check to me.

Tony
