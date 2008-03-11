From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Problems booting Filesystem
Date: Tue, 11 Mar 2008 03:14:24 -0500
Message-ID: <e241a85aa2137c14d9ba7e9a310a1153@felipebalbi.com>
References: <ae36f8040803101904u2a0ab067rbeda8993d40fedae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60772 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbYCKIOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 04:14:25 -0400
In-Reply-To: <ae36f8040803101904u2a0ab067rbeda8993d40fedae@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lvcargnini@gmail.com
Cc: "Hunter, Jon" <jon-hunter@ti.com>, linux-omap@vger.kernel.org



On Mon, 10 Mar 2008 23:04:07 -0300, "Lu=C3=ADs Vit=C3=B3rio Cargnini"
<lvcargnini@gmail.com> wrote:
> ebuilding the kernel, my intern will test it tomorrow morning, then
> I'll send the results but as you all I do not understood why it
> generate so many partitions nad not booted the filesystem, it was
> everything ok until 2.6.24, since the last upgrade things stop
> working.

Might be a regression.
If you know the exact point where it was working (2.6.23-omap1 was work=
ing
?) then you
can git bisect to track down where it broke.

Try this:

$ git bisect start
$ git bisect good v2.6.23-omap1
$ git bisect bad

then it'll start a binary search between v2.6.23-omap1 and HEAD and cho=
ose
one commit in the middle.
After it chooses you, build the kernel and flash to see whether it work=
s or
not. If it works then you
$ git bisect good
otherwise you
$ git bisect bad

You keep doing that until you get the exact commit that broke omap_nor.=
c

--=20
Best Regards,

=46elipe Balbi
http://felipebalbi.com
me@felipebalbi.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
