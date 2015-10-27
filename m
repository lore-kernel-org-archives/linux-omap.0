From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] regulator: tps65217: remove tps65217.dtsi file
Date: Tue, 27 Oct 2015 13:33:42 +0100
Message-ID: <562F6F26.4060005@denx.de>
References: <1445850836-17863-1-git-send-email-hs@denx.de>
 <20151027122148.GA819@earth>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151027122148.GA819@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Georg.Soffel@bosch-si.com, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, Mark Jackson <mpfj@newflow.co.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hello Sebastian,

Am 27.10.2015 um 13:21 schrieb Sebastian Reichel:
> Hi,
>
> On Mon, Oct 26, 2015 at 10:13:55AM +0100, Heiko Schocher wrote:
>> remove tps65217.dtsi and adapt all boards, which
>> used it.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> Suggested by Mark Brown, see:
>> https://lkml.org/lkml/2015/10/21/581
>>
>>   .../devicetree/bindings/regulator/tps65217.txt     | 78 ----------------------
>
> why did you delete the binding description?

Didn;t I sent a v2? I realized this after sending the v1 patch, and
prepared a v2, which does not remove this file ... Uh, yes, seems
I missed sending it ... Sorry. Send a v2 ASAP, thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
