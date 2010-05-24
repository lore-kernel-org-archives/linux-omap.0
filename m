From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 11/14] omap: mailbox: only compile for configured
	archs
Date: Mon, 24 May 2010 22:00:50 +0100
Message-ID: <20100524210050.GG21117@n2100.arm.linux.org.uk>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com> <1274548465-20208-12-git-send-email-felipe.contreras@gmail.com> <20100524.174205.22049047.Hiroshi.DOYU@nokia.com> <AANLkTim7Jxlx3Owyn2IM_TjUWxS72I7h9H5d0evbCsVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47307 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab0EXVBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 17:01:09 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim7Jxlx3Owyn2IM_TjUWxS72I7h9H5d0evbCsVQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 24, 2010 at 10:29:01PM +0300, Felipe Contreras wrote:
> On Mon, May 24, 2010 at 5:42 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
>=20
> >> +     if (false);
> >
> > nitpcik:
> > The above may look better as below:
> >
> > =A0 =A0 =A0 =A0if (false)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;
> >
> > "checkpatch.pl" also doesn't complain.
>=20
> Personally I think it looks weird and it's a checkpatch bug, but fine=
 by me.

No, I'd say it's intentional.

	if (false);

looks too much like an error - think about:

	if (false);
		do_something();

which would be very easy to miss while reviewing.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
