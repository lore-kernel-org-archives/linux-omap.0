From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Wed, 5 Aug 2015 20:26:45 +0530
Message-ID: <55C2242D.4030703@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com> <20150805094717.GX16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150805094717.GX16878@atomide.com>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 05 August 2015 03:17 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150727 04:27]:
>> vsel_reg and enable_reg of the pbias regulator descriptor should actually
>> have the offset from syscon. However after the pbias device tree node
>> is moved as a child node of syscon, vsel_reg and enable_reg has the
>> absolute address because of the address translation that happens while
>> creating device from device tree node.
>> So avoid using platform_get_resource and use of_get_address in order to
>> get only the offset (untranslated address) and populate these in
>> vsel_reg and enable_reg.
> 
> I think this gets fixed automatically with your other series
> adding the "simple-bus" to the nodes. For the children of_ioremap

Nope. The probe of pbias regulator fails as Grygorii has already pointed out
here [1].

Thanks
Kishon

[1] -> http://www.spinics.net/lists/linux-omap/msg120462.html
