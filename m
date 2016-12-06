From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 01/12] phy: rcar-gen3-usb2: Replace the deprecated extcon
 API
Date: Tue, 6 Dec 2016 01:35:17 +0000
Message-ID: <HK2PR06MB05489F8F613E9FEE6B9D262CD8820@HK2PR06MB0548.apcprd06.prod.outlook.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kishon@ti.com" <kishon@ti.com>, "sre@kernel.org" <sre@kernel.org>
Cc: "Peter.Chen@nxp.com" <Peter.Chen@nxp.com>, "wens@csie.org" <wens@csie.org>, "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "chanwoo@kernel.org" <chanwoo@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Chanwoo Choi
> Sent: Wednesday, November 30, 2016 2:57 PM
>=20
> This patch replaces the deprecated extcon API as following:
> - extcon_set_cable_state_() -> extcon_set_state_sync()
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Thank you for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
