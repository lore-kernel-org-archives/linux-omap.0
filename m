From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 8/8] ARM: dts: am43-pre-silicon support
Date: Tue, 19 Feb 2013 16:41:15 +0530
Message-ID: <51235DD3.2060701@ti.com>
References: <cover.1361186097.git.afzal@ti.com> <e344f74da47579c11db68d9f6efe25259ed7f25d.1361186097.git.afzal@ti.com> <5123556A.9050109@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93EAA86DE@DBDE01.ent.ti.com> <51235B3D.5000907@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93EAA8731@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA8731@DBDE01.ent.ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, "Nori, Sekhar" <nsekhar@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 February 2013 04:33 PM, Mohammed, Afzal wrote:
> Hi Santosh,
>
> On Tue, Feb 19, 2013 at 16:30:13, Shilimkar, Santosh wrote:
>> On Tuesday 19 February 2013 04:22 PM, Mohammed, Afzal wrote:
>
>>> SoC support is already added in patch 7/8. This is board (which doesn't
>>> exist now) support, hence a pre-silicon temporary one to validate it.
>>>
>> I mean we can call it am437x-xyxboard.dtb already considering the data
>> here can be re-used. Boot-args can be used from default kernel config
>> with CONFIG_CMDLINE_FORCE.
>>
>> No strong opinion if you still insist to have a pre-silicon dtb.
>
> This patch would be replaced by original board, once it is known.
> This was included to make a working complete series and if someone
> wants (internally) to test the series as is.
>
Ohh. I assumed it is for merge as well.
Thanks for clarification.

Regards,
Santosh

