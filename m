From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime functions
 when not needed.
Date: Sat, 11 Jun 2016 00:21:12 +0300
Message-ID: <575B2F48.4090707@gmail.com>
References: <1462634508-24961-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1462634508-24961-6-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160509193624.GH5995@atomide.com> <5730F840.3050807@gmail.com>
 <20160610102225.GS22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610102225.GS22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, thierry.reding@gmail.com, bcousson@baylibre.com, linux@arm.linux.org.uk, mchehab@osg.samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com
List-Id: linux-omap@vger.kernel.org


On 10.06.2016 13:22, Tony Lindgren wrote:
>
> OK. And I just applied the related dts changes. Please repost the driver
> changes and DT binding doc with Rob's ack to the driver maintainers to
> apply.
>

Already did, see https://lkml.org/lkml/2016/5/16/429

Shall I do anything else?

Thanks,
Ivo
