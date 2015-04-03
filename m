From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] usb: musb: dsps: fix build on i386 when COMPILE_TEST
 is set
Date: Fri, 3 Apr 2015 19:10:42 +0200
Message-ID: <20150403171042.GA30686@kroah.com>
References: <1427318317-13927-1-git-send-email-tony@atomide.com>
 <20150403151403.GA5503@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44859 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbDCRKr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 13:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20150403151403.GA5503@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Fri, Apr 03, 2015 at 10:14:14AM -0500, Felipe Balbi wrote:
> Hi Greg,
>=20
> On Wed, Mar 25, 2015 at 02:18:37PM -0700, Tony Lindgren wrote:
> > Commit 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with mus=
b_dsps")
> > fixed a USB error on dm816x, but introduced a new build error on i3=
86
> > when COMPILE_TEST is set:
> >=20
> > drivers/usb/musb/musb_dsps.c: In function =E2=80=98dsps_read_fifo32=
=E2=80=99:
> > drivers/usb/musb/musb_dsps.c:624:3: error: implicit declaration of =
function
> > =E2=80=98readsl=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> > readsl(fifo, dst, len >> 2);
> >=20
> > Let's fix this by using ioread32_rep() instead of readsl() as that'=
s
> > more portable.
> >=20
> > Fixes: 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with mus=
b_dsps")
> > Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> > Cc: Bin Liu <binmlist@gmail.com>
> > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> Can you apply this one directly ? It fixes a build error on i386.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Now queued up, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
