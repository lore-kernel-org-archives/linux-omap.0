From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 15/19] ARM: dts: omap: replace legacy *,wakeup property
 with wakeup-source
Date: Tue, 15 Dec 2015 16:37:01 +0000
Message-ID: <567041AD.1020702@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-16-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445422216-29375-16-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 21/10/15 11:10, Sudeep Holla wrote:
> Though the keyboard and other driver will continue to support the leg=
acy
> "gpio-key,wakeup", "linux,wakeup" boolean property to enable the wake=
up
> source, "wakeup-source" is the new standard binding.
>
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>

Ping, do you prefer taking via your tree or should I send to armsoc
directly ?

--=20
Regards,
Sudeep
