From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] clk: Add driver for Palmas clk32kg and clk32kgaudio clocks
Date: Fri, 4 Apr 2014 09:53:11 +0300
Message-ID: <533E56D7.3060102@ti.com>
References: <1396522348-31989-1-git-send-email-peter.ujfalusi@ti.com> <533D66F2.7050600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <533D66F2.7050600@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ldewangan@nvidia.com, linux-doc@vger.kernel.org, grant.likely@linaro.org
List-Id: linux-omap@vger.kernel.org

On 04/03/2014 04:49 PM, Nishanth Menon wrote:
> On 04/03/2014 05:52 AM, Peter Ujfalusi wrote:
> [...]
>>  .../devicetree/bindings/clock/clk-palmas.txt       |  35 +++
>>  drivers/clk/Kconfig                                |   7 +
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/clk-palmas.c                           | 307 ++++++++++=
+++++++++++
>>  include/dt-bindings/mfd/palmas.h                   |  18 ++
>>  5 files changed, 368 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/clk-palm=
as.txt
>>  create mode 100644 drivers/clk/clk-palmas.c
>>  create mode 100644 include/dt-bindings/mfd/palmas.h
>=20
>=20
> Only complaint i have is based on :
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2a9330010bea5982a5c6593824bc036bf62d67b7

Oh, I see.
I'll wait for comments and resend as a series. Probably it is going to =
be
better if I rename the documentation file as well to
bindings/clock/ti,palmas-clk.txt
I think having two separate document for the two clock is overkill.

> you may want to split the new binding off to a separate patch.
> Otherwise, personally, I think it is an good evolution, thanks for
> doing it.
>=20
>=20


--=20
P=E9ter
