From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 4/8] ARM: am33xx: ll debug config help
Date: Tue, 19 Feb 2013 16:32:15 +0530
Message-ID: <51235BB7.2050600@ti.com>
References: <cover.1361186097.git.afzal@ti.com> <bfe941adb98a5000c2817f9fd6160070e59e53c9.1361186097.git.afzal@ti.com> <51235337.60209@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93EAA867A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA867A@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, "Nori, Sekhar" <nsekhar@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 February 2013 04:00 PM, Mohammed, Afzal wrote:
> Hi Santosh,
>
> On Tue, Feb 19, 2013 at 15:55:59, Shilimkar, Santosh wrote:
>
>> With DT, IIRC DEBUGLL is broken. So did you hack debug-macro.S
>> to get the earlyprintk working ?
>
> No, on linux-next, ll debug works properly.
>
Indeed. Tony fixed that now. Some how I missed
this patch on the list.

Regards,
Santosh
