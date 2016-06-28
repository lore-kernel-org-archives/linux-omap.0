From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 5/5] regulator: tps65218: do not disable DCDC3 during
 poweroff on broken PMICs
Date: Tue, 28 Jun 2016 12:12:06 +0100
Message-ID: <20160628111206.GB17585@dell>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
 <1466756892-17015-5-git-send-email-j-keerthy@ti.com>
 <20160627165930.GC17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160627165930.GC17217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 27 Jun 2016, Mark Brown wrote:

> On Fri, Jun 24, 2016 at 01:58:11PM +0530, Keerthy wrote:
> > From: Tero Kristo <t-kristo@ti.com>
> >=20
> > Some versions of tps65218 do not seem to support poweroff modes pro=
perly
> > if DCDC3 regulator is shut-down. Thus, keep it enabled even during
> > poweroff if the version info matches the broken silicon revision.
>=20
> This is fine but depends on the MFD bit so needs to wait for that to =
be
> reviewed.

I think it's fine for you to take this.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
