From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] memory: emif: add device tree support to emif
 driver
Date: Sat, 30 Jun 2012 00:23:56 -0400
Message-ID: <20120630042356.GC1816@kroah.com>
References: <1340977407-7594-1-git-send-email-santosh.shilimkar@ti.com>
 <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
 <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63401 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab2F3EYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jun 2012 00:24:00 -0400
Received: by gglu4 with SMTP id u4so3334437ggl.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 21:23:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, tony@atomide.com

On Sat, Jun 30, 2012 at 09:38:41AM +0530, Shilimkar, Santosh wrote:
> (+ Greg, By mistake the your name got dropped cc from list)
>=20
> On Fri, Jun 29, 2012 at 7:13 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > From: Aneesh V <aneesh@ti.com>
> >
> > Device tree support for the EMIF driver.
> >
> > Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> > Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Aneesh V <aneesh@ti.com>
> > [santosh.shilimkar@ti.com: Rebased against 3.5-rc]
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > =A0drivers/memory/emif.c | =A0291 +++++++++++++++++++++++++++++++++=
+++++++++++++++-
> > =A01 file changed, 290 insertions(+), 1 deletion(-)

Wouldn't this just be better off as a separate file that only gets buil=
d
if CONFIG_OF is set, as I'm sure that other systems are going to want
access to these "read the device tree values" functions, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
