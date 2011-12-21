From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Is Pandaboard cpuhotplug working stably?
Date: Wed, 21 Dec 2011 10:07:06 +0000
Message-ID: <20111221100706.GC3354@n2100.arm.linux.org.uk>
References: <CAGsJ_4ydbMaS0DD6+j1m9tdCTCzw3TGELcY=KotupvvMMK1YOA@mail.gmail.com> <20111221094624.GB3354@n2100.arm.linux.org.uk> <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44668 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab1LUKHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 05:07:16 -0500
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w0iVXC6qmDzmkuOb=ZN=Q0bF7EAFkxeYR_d7-vo+8bqQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-omap@vger.kernel.org, yongsheng.liu@csr.com, linaro-dev <linaro-dev@lists.linaro.org>, peiyu.li@csr.com, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 21, 2011 at 05:59:07PM +0800, Barry Song wrote:
> 2011/12/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > cpu hotplug is basically totally buggered - the preconditions place=
d
> > upon the bringup code path are basically impossible to satisfy in a=
ny
> > shape or form at the moment.
> >
> > There's the requirement that the secondary CPU is marked online and
> > active before interrupts are enabled for the thread migration stuff
> > to behave correctly. =A0However, this is incompatible with smp_call=
_function()
> > which will wait for online CPUs to respond to an IPI - which this o=
ne
> > won't because interrupts are disabled.
> >
> > I think there was some discussion about how to fix this but I don't
> > recall the details.
>=20
> thanks, Russell. then could i think this is an ARM-kernel-specific bu=
g
> which exists on all ARM SMP chips for the moment?
> and that bug doesn't happen on x86:

I don't think so.  There's nothing ARM specific about it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
