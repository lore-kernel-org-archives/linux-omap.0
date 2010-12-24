From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: Issue : jffs2 and ecc layout
Date: Fri, 24 Dec 2010 16:02:36 +1300
Message-ID: <201012241602.36582.manningc2@actrix.gen.nz>
References: <ActfCy0cZc3bW9yIT5u5fx8oZO9GQw==> <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com> <AANLkTimJFsjLT15FA+TqDKzjvPXgxUAvovWpWKP3NCK4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:45763 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752721Ab0LXDCl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 22:02:41 -0500
In-Reply-To: <AANLkTimJFsjLT15FA+TqDKzjvPXgxUAvovWpWKP3NCK4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 23 December 2010 21:24:35 Ming Lei wrote:
> Hi,
>
> 2010/9/28 Ghorai, Sukumar <s-ghorai@ti.com>:
> > Hi,
> > I was using the following ecc layout which is not working to mount =
the
> > jffs2 File-system. I was in 2.6.32 kernel and working; but same lay=
out is
> > not working with latest 2.6 kernel.
> >
> > Observation is that - no read request issued to the driver (say oma=
p2.c).
> >
> > # mount -t jffs2 /dev/mtdblock4 /mnt/nand
> > [=A0=A0 32.505218] cannot read OOB for EB at 00000000, requested 8 =
bytes,
> > read 0 bytes, error -22 mount: Mounting /dev/mtdblock4 on /mnt/nand
> > failed: Input/output error
>
> I meet the issue too, kernel is  2.6.37-rc6-next-20101217+, and board=
 is
> beagle B5.
>
> Is there any way to fix or workaround the issue?
>
>
> thanks,

THis might be due to the way the omap2.c driver is now screwed up so th=
at it=20
does not read when not u32 aligned.

Try this:
http://www.spinics.net/linux/lists/linux-omap/msg42422.html

Please report back if that fixes the problem for you.

-- Charles



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
