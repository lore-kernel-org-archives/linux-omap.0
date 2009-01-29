From: Greg KH <greg@kroah.com>
Subject: Re: lowmemory android driver not needed?
Date: Wed, 28 Jan 2009 20:27:48 -0800
Message-ID: <20090129042748.GA24108@kroah.com>
References: <2f11576a0901160518g52a3e70endc98fe4792a98b9b@mail.gmail.com> <d6200be20901212213x1069762cpd377d04bc5a04a91@mail.gmail.com> <20090128234209.A949.KOSAKI.MOTOHIRO@jp.fujitsu.com> <d6200be20901281851k45f9692em1379140c8951c195@mail.gmail.com> <20090129124555.b83ea0ae.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:44712 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751049AbZA2EbM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Jan 2009 23:31:12 -0500
Content-Disposition: inline
In-Reply-To: <20090129124555.b83ea0ae.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, ext Juha =?utf-8?B?WXJq7pKU44O7?= <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com, Trilok Soni <soni.trilok@gmail.com>

On Thu, Jan 29, 2009 at 12:45:55PM +0900, KAMEZAWA Hiroyuki wrote:
> On Wed, 28 Jan 2009 18:51:07 -0800
> Arve Hj=F8nnev=E5g <arve@android.com> wrote:
>=20
> > >> >> static uint32_t lowmem_debug_level =3D 2;
> > >> >> static int lowmem_adj[6] =3D {
> > >> >
> > >> > why do you choice [6]?
> > >>
> > >> We use six levels.
> > >
> > > if you don't consider other user and other usage case,
> > > this file can't merge forever.
> >=20
> > I never expected it to be merged. I wrote it to allow us to ship a =
product.
> >=20
> Then, please write "DON'T MERGE ME" on the top of patch description.
> we can adjust our viewpoints.

The code will live in the drivers/staging/ directory for now and not ge=
t
merged into the "main" portion of the kernel tree until everyone can
agree on it.

But for now, it is useful and seems to work for a few million devices
out there, so we can't just ignore it :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
