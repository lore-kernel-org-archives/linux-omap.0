From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Mon, 19 Jan 2009 11:44:07 +0200 (EET)
Message-ID: <20090119.114407.177399457.Hiroshi.DOYU@nokia.com>
References: <20090116083709.18344.74524.stgit@oreo.research.nokia.com>
	<20090117160608.GA12341@n2100.arm.linux.org.uk>
	<200901171248.45757.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62277 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149AbZASJpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 04:45:11 -0500
In-Reply-To: <200901171248.45757.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net, david-b@pacbell.net
Cc: linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi David,

=46rom: "ext David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Sat, 17 Jan 2009 12:48:45 -0800

> On Saturday 17 January 2009, Russell King - ARM Linux wrote:
> > > +#ifdef DEBUG_VERBOSE
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(obj->dev, "%s:\ta=
 new pte:%p\n", __func__, iopte);
> > > +#endif
> >=20
> > Not sure wrapping these in DEBUG_VERBOSE is necessary. =A0dev_dbg()=
 is a
> > no-op unless DEBUG is defined.
>=20
> Use dev_vdbg() to get the "NOP unless VERBOSE is set" semantics.

Thanks. This is what I wanted... I'll update with "dev_vdbg()".
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
