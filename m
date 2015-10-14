From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 12:53:04 +0200
Message-ID: <20151014105304.GB13084@pali>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444819456-26728-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: tony@atomide.com, wsa@the-dreams.de, sre@kernel.org, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 14 October 2015 13:44:16 Roger Quadros wrote:
> Let's keep the SSI ports disabled in the omap3.dtsi to avoid
> getting the following noise on the console for boards that don't
> use the SSI ports.
>=20
> "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=
=3D-2)"
>=20
> As omap3-n900 uses one SSI port, mark it enabled there.
>=20

Sebastian, why is second SSI port disabled on N900? It is not used or
in DTS file are missing some definitions?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
