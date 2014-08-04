From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/1] ARM: OMAP: add external clock provider support
Date: Mon, 4 Aug 2014 14:37:56 +0300
Message-ID: <53DF7094.7050601@ti.com>
References: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59593 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbaHDLjo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Aug 2014 07:39:44 -0400
In-Reply-To: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, sassmann@kpanic.de, jsarha@ti.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/01/2014 04:15 PM, Tero Kristo wrote:
> Hi,
>=20
> This patch adds possibility to register external clocks (outside the =
main
> SoC) on TI boards through device tree. Clock sources as such include =
for
> example twl-6030 / twl-6040 chips and variants which can be used to c=
lock
> for example audio / WLAN chips.

Just one question to Mike and Tero:
would it be possible to have generic binding for such an external clock=
s?
We have the palmas clock driver already upstream which handles the 32K =
clocks
from the PMIC. Palmas class of PMICs can be used with TI/nVidia(/Intel?=
)
platforms. We use Palmas on omap5-uevm, DRA7-EVM also uses Palmas compa=
tible
PMIC and some nVidia platform also uses this class of devices (and they=
 all
need to have control over the 32K clock(s)).

> This patch can be queued once someone has a use-case + patches that r=
equires
> usage of such clocks.
>=20
> -Tero
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
