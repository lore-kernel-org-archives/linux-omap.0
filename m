From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Sat, 17 Jan 2009 12:48:45 -0800
Message-ID: <200901171248.45757.david-b@pacbell.net>
References: <20090116083003.18344.38307.stgit@oreo.research.nokia.com> <20090116083709.18344.74524.stgit@oreo.research.nokia.com> <20090117160608.GA12341@n2100.arm.linux.org.uk>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:48208 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758671AbZAQUss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 Jan 2009 15:48:48 -0500
In-Reply-To: <20090117160608.GA12341@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Saturday 17 January 2009, Russell King - ARM Linux wrote:
> > +#ifdef DEBUG_VERBOSE
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(obj->dev, "%s:\ta n=
ew pte:%p\n", __func__, iopte);
> > +#endif
>=20
> Not sure wrapping these in DEBUG_VERBOSE is necessary. =A0dev_dbg() i=
s a
> no-op unless DEBUG is defined.

Use dev_vdbg() to get the "NOP unless VERBOSE is set" semantics.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
