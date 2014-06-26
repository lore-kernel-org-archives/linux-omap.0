From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] arm: mach-omap2: gpmc: ignore non-available nodes
Date: Thu, 26 Jun 2014 13:37:07 -0300
Message-ID: <20140626163707.GA26836@arch.cereza>
References: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Cc: Tony Lindgren <tony@atomide.com>, pekon@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 26 Jun 12:02 PM, Guido Mart=EDnez wrote:
> Currently, child nodes of the gpmc node are iterated and probed
> regardless of their 'status' property. This means adding 'status =3D
> "disabled";' has no effect.
>=20
> This patch changes the iteration to only probe nodes marked as
> available.
>=20
> Signed-off-by: Guido Mart=EDnez <guido@vanguardiasur.com.ar>

Just a nit: the commit title doesn't match the recent commits. If you
run "git log" on this file, you'll find the pattern should be something
like:

"ARM: OMAP2+: GPMC should only probe enabled devices"

Other than this, the patch looks correct.

Thanks,
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
