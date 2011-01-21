From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
Date: Fri, 21 Jan 2011 10:57:13 -0600
Message-ID: <A24693684029E5489D1D202277BE89448521EEB1@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>,<20110121103005.GA14142@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362Ab1AUQ70 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 11:59:26 -0500
In-Reply-To: <20110121103005.GA14142@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Russell,

> ________________________________________
> From: Russell King - ARM Linux [linux@arm.linux.org.uk]
> Sent: Friday, January 21, 2011 4:30 AM
> To: Aguirre, Sergio
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
> 
> On Thu, Jan 20, 2011 at 03:06:30PM -0600, Aguirre, Sergio wrote:
> > And while debugging further, i realized that the point of stall was
> > in mm/memory.c, function:
> >
> > static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >                       unsigned long addr, unsigned long end,
> >                       unsigned long pfn, pgprot_t prot)
> > {

> >               BUG_ON(!pte_none(*pte)); <---******* HERE

> > }

> > How should i interpret this? Does this mean something specific?
> 
> It is asserting that the pte we are about to overwrite was empty.  In
> other words, there is no existing mapping in place at that virtual
> address.
> 
> If there was a pre-existing mapping, you're doing something wrong
> because you're potentially overwriting something else.

Ok. I see.

Thanks for the detailed explanation. I appreciate it.

Regards,
Sergio
> 