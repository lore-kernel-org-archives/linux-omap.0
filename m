From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
Date: Tue, 10 Dec 2013 08:50:07 +0000
Message-ID: <20131210085007.GO12675@lee--X1>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
 <20131208190739.GA18977@saruman.home>
 <20131209093748.GA12675@lee--X1>
 <20131209161422.GC24047@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131209161422.GC24047@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, sameo@linux.intel.com, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> > > > The code looks mostly fine, but the implementation of the commi=
t logs
> > > > seems lazy. Please submit a v3 using coherent sentences with fu=
ll
> > > > explanations and correct punctuation.
> > >=20
> > > example ?
> >=20
> > All of your commit messages.
> >=20
> > > that macro just helps removing some extra
> >=20
> >   ^- Sentences start with an uppercase character.
> >=20
> > > line of code and hides ffs() calls.
> > >=20
> > > while at that, also fix a variable shadowing
> >=20
> >   ^- Sentences start with an uppercase character.
> >=20
> > > bug where 'int irq' was being redeclared inside
> > > inner loop while it was also argument to interrupt
> > > handler.
> >=20
> >   < ---------------   50 chars   ----------------- >
> >=20
> > Please use the full 72 char (or there abouts) width of the buffer.
>=20
> I don't see any mention of punctuation problems, however. Also, you'r=
e
> not complaining about the content at all, which tells me those senten=
ces
> aren't as incoherent as you claimed before.

I didn't read them in any detail. I traversed through the patches and
saw that the formatting looked obscure on all of them. As I have come
to expect more of your submissions, I provided a generic reply
detailing how I expected the commit logs to be. I wasn't insinuated
that you failed to meet all of the criteria, but they definitely fell
short of the mark.

> But fair enough, I'll fix those up and add Aaro's Tested-by

Thank you.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
