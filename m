From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: AM43XX: hwmod: Fix RSTST register offset for pruss
Date: Mon, 20 Jun 2016 07:05:45 +0000
Message-ID: <5E94841CD408F1498111ED1D1196B1B237B18D3A@DBDE04.ent.ti.com>
References: <1466394745-983-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466394745-983-1-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, "Gerlach, Dave" <d-gerlach@ti.com>, "Anna, Suman" <s-anna@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

J, KEERTHY wrote on Monday, June 20, 2016 9:22 AM:

> pruss hwmod RSTST register wrongly points to PWRSTCTRL register in case of
> am43xx. Fix the RSTST register offset value.

> This can lead to setting of wrong power state values for PER domain.

Just curious, does it happen or noticed by going thr' the code ?

Regards
afzal
