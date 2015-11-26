From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Thu, 26 Nov 2015 23:12:38 +0200
Message-ID: <565775C6.8070500@gmail.com>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com> <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali> <20151126203930.GW2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151126203930.GW2517@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Sebastian Reichel <sre@debian.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 26.11.2015 22:39, Tony Lindgren wrote:

> Just to explore options.. How about make a minimal device driver that
> just loads the atags blob from /lib/firmware and then shows it in
> /proc/atags? Of course some checking on the atags should be done by
> the driver..
>

What is the chance for such a driver to be accepted upstream? As IIRC 
the current situation is because similar driver was rejected. Might be 
wrong as well, it was about 2-3 years ago.

Regards,
Ivo
