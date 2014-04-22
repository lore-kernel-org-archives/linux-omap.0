From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH 00/11] Embeddable Position Independent Executable
Date: Tue, 22 Apr 2014 10:15:09 +0200
Message-ID: <1441820.DP5PYDOd2T@phil>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com> <201310241009.12597.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201310241009.12597.heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mans@mansr.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kbuild@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Dave Martin <Dave.Martin@arm.com>
List-Id: linux-omap@vger.kernel.org

Hi Russ,

Am Donnerstag, 24. Oktober 2013, 10:09:12 schrieb Heiko St=FCbner:
> Am Dienstag, 17. September 2013, 14:43:26 schrieb Russ Dill:
> > This patch adds support for and demonstrates the usage of an embedd=
ed
> > position independent executable (PIE). The goal is to allow the use=
 of C
> > code in situations where carefully written position independent ass=
embly
> > was previously required.
>=20
> As suggested yesterday evening by Kevin Hilman, just adding my 2ct of
> support.
>=20
> This series looks exactly like the foundation I'll need at some point=
 in the
> (probably still distant) future to handle suspend on my Rockchip plat=
form -
> where like in your example stuff like putting the ram into selfrefres=
h has
> to be done by the os.

just as it came up recently again for me and I couldn't find any newer =
version,=20
ist this series still on the table?


Thanks
Heiko
