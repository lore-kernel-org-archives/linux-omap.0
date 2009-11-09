From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3 1/2] arm: a driver for on-chip ETM and ETB
Date: Mon, 09 Nov 2009 13:48:10 +0200
Message-ID: <1257767290.21596.307.camel@localhost>
References: <1256230315-22340-1-git-send-email-virtuoso@slind.org>
	 <20091030121024.GB15200@shisha.kicks-ass.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41787 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbZKILsl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 06:48:41 -0500
In-Reply-To: <20091030121024.GB15200@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2009-10-30 at 14:10 +0200, Alexander Shishkin wrote:
> On Thu, Oct 22, 2009 at 07:51:54PM +0300, Alexander Shishkin wrote:
> > Changes:
> > v3 -- major update:
> >       * switched from platform device to AMBA device
> >       * started using clk API in a more proper way
> >       * changed omap3 Kconfig part to select the driver instead of =
depending
> >         on it
>=20
> Russell, I believe this one addresses your concerns about my previous=
 patches.
> Shall I wait for more comments from you or do you want me to upload t=
hem to
> your patch tracker?

Alex, I suggest you to:

1. Double check that you really addressed _everything_ Russel and other=
s
pointed - may be this is the reason why your patch is stuck.

2. If you have addressed everything, upload the patch to the patch
system. My (very limited) experience was that I re-sent a patch several
times, got no response for long time, but then Russel simply asked me t=
o
upload it, and it was merged. Thus, the silence may simply mean "upload
to the patch system".

HTH.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
