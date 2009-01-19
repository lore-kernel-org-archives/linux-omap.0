From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Mon, 19 Jan 2009 21:58:58 +0000
Message-ID: <20090119215858.GA31848@n2100.arm.linux.org.uk>
References: <20090116083709.18344.74524.stgit@oreo.research.nokia.com> <20090117160608.GA12341@n2100.arm.linux.org.uk> <200901171248.45757.david-b@pacbell.net> <20090119.114407.177399457.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42557 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbZASV7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 16:59:24 -0500
Content-Disposition: inline
In-Reply-To: <20090119.114407.177399457.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: dbrownell@users.sourceforge.net, david-b@pacbell.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Jan 19, 2009 at 11:44:07AM +0200, Hiroshi DOYU wrote:
> Hi David,
>=20
> From: "ext David Brownell" <david-b@pacbell.net>
> Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
> Date: Sat, 17 Jan 2009 12:48:45 -0800
>=20
> > On Saturday 17 January 2009, Russell King - ARM Linux wrote:
> > > > +#ifdef DEBUG_VERBOSE
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(obj->dev, "%s:\=
ta new pte:%p\n", __func__, iopte);
> > > > +#endif
> > >=20
> > > Not sure wrapping these in DEBUG_VERBOSE is necessary. =A0dev_dbg=
() is a
> > > no-op unless DEBUG is defined.
> >=20
> > Use dev_vdbg() to get the "NOP unless VERBOSE is set" semantics.
>=20
> Thanks. This is what I wanted... I'll update with "dev_vdbg()".

Sorry, drop the 'v' in that (typo).
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
