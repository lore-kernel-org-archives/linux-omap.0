From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
Date: Wed, 8 Sep 2010 13:04:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D30A5@dbde02.ent.ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTi=chtedwbDDJnZOe5yTqobUeXz=aZYUNNUDpQQm@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "per.xx.fransson@stericsson.com" <per.xx.fransson@stericsson.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.ml.walleij@gmail.com]
> Sent: Tuesday, September 07, 2010 11:49 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> tglx@linutronix.de; linux-omap@vger.kernel.org;
> per.xx.fransson@stericsson.com
> Subject: Re: [PATCH 0/6] ARM: l2x0: kexex, cleanup and optimisation
> =

> 2010/9/7 Santosh Shilimkar <santosh.shilimkar@ti.com>:
> =

> > This series is just repost adding Catalin's ack to the patches and
> > combining Thomas's two rebased kexec patches.
> > It's generated against the mainline 2.6.36-rc3 + Catalin's
> > "[PATCH 0/9] Various patches for 2.6.37-rc1" series.
> >
> > Santosh Shilimkar (4):
> > =A0omap4: l2x0: Override the default l2x0_disable
> > =A0ARM: l2x0: Fix coding-style in the cache-l2x0.h
> > =A0ARM: l2x0: Determine the cache size
> > =A0ARM: l2x0: Optimise the range based operations
> >
> > Thomas Gleixner (2):
> > =A0arm: Disable outer (L2) cache in kexec
> > =A0arm: Implement l2x0 cache disable functions
> =

> FWIW:
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> =

Thanks !!
> Can you also include the patch by Per Fransson I sent off to
> Thomas and the list just a few days ago with the subject
> "[PATCH] ARM: ux500 specific L2 cache code"
> in this patch series?
> =

Basically I plan to push all these patches to =

RMK's patch system after getting his OK. I can push =

your patch along with that.

Is that ok with you ?

Regards,
Santosh
