From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v7 0/2] More fixes for twl4030 charger
Date: Sat, 1 Jul 2017 13:49:16 +0200
Message-ID: <B93260EC-F61D-4B51-9B2C-707917CEBC53@goldelico.com>
References: <cover.1497861705.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497861705.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Nikolaus Schaller <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Russell King <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, NeilBrown <neil@brown.name>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

> Am 19.06.2017 um 10:41 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Changes V7:
> * removed already merged patches from patch set
> * further fix for potentially wrong irq and notifier initialization =
sequence (suggested by Sebastian Reichel)
> * NULLify transceiver pointer in case of errors (suggested by =
Sebastian Reichel)

Did you find time to review the updated v7 patches?
I have not seen them arrive in linux-next.

BR and thanks,
Nikolaus
