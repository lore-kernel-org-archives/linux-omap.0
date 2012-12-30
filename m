From: Ido Yariv <ido@wizery.com>
Subject: Re: [PATCH] hwspinlock/core: Add testing capabilities
Date: Sun, 30 Dec 2012 16:27:10 +0200
Message-ID: <20121230142710.GA16250@WorkStation.localnet>
References: <CAKvkGKfc5jw+_ABgB8nrX37B7zHCoA5Ld0Gs5O-EDFD-Gk0OKg@mail.gmail.com>
 <20121230112018.GA14042@WorkStation.localnet>
 <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "steve.zhan" <zhanzhenbo@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Steve,

On Sun, Dec 30, 2012 at 10:13:08PM +0800, steve.zhan wrote:
> Hi,
> =A0=A0 Acked-by: Steve zhan zhanzhenbo@gmail.com
> =A0
> =A0=A0 "I'd rather not test the spinlocks after they are registering =
as they
> might already be in use by then."
>=20
> =A0=A0=A0 Why? I think user must use it after hwspin_lock_register ha=
ve retured
> sucess.

Once the spinlocks are registered anyone can request and acquire these.
The tests could then interfere with any users of the hwspinlock layer,
or simply fail (because the spinlocks might already be acquired).

Thanks,
Ido.
