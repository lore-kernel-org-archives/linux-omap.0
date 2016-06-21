From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] ARM: AM43XX: hwmod: Fix RSTST register offset for pruss
Date: Tue, 21 Jun 2016 15:27:23 +0530
Message-ID: <57690F83.80709@ti.com>
References: <1466394745-983-1-git-send-email-j-keerthy@ti.com>
 <5E94841CD408F1498111ED1D1196B1B237B18D3A@DBDE04.ent.ti.com>
 <5767A81E.1040809@ti.com> <5768177B.9070306@ti.com>
 <5E94841CD408F1498111ED1D1196B1B237B191FD@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5E94841CD408F1498111ED1D1196B1B237B191FD@DBDE04.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>, "Anna, Suman" <s-anna@ti.com>, "J, KEERTHY" <j-keerthy@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, "Gerlach, Dave" <d-gerlach@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org



On Tuesday 21 June 2016 01:22 PM, Mohammed, Afzal wrote:
> Hi Suman,
>
> Anna, Suman wrote on Monday, June 20, 2016 9:49 PM:
>
>> It does happen when the pruss module is exercised. We found this when we
>> tried to do a standby test on suspend, and while it worked on AM33xx,
>> AM437x failed because of this difference.
>
> Okay, seems on am335x, PER doesn't have RSTST register itself.

Seems like code has some reference!

arch/arm/mach-omap2/prm33xx.h
#define AM33XX_RM_PER_RSTST_OFFSET		0x0004

But TRM: http://www.ti.com/lit/ug/spruh73m/spruh73m.pdf
claims that offset is reserved.

Should i remove the above lines altogether?

>
> Regards
> afzal
>
