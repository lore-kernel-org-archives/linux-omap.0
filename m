From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Tue, 9 Oct 2012 04:41:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210090440290.5736@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com> <50187644.40308@ti.com> <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
 <5073528F.2020902@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56443 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2JIElO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 00:41:14 -0400
In-Reply-To: <5073528F.2020902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Madhav Vij <mvij@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Mon, 8 Oct 2012, Jon Hunter wrote:

> I was looking at what got merged and it appears that the above code was
> added to the omap2 clkdm enable/disable functions and not omap3. I believe
> that is a mistake? If so the below fixes this.

Yep looks like either a mismerge or a victim of a rebase -- queued for 
late 3.7 fixes -- thanks,

- Paul
