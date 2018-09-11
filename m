From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 00/11] dts: Update coresight device tree bindings
Date: Tue, 11 Sep 2018 22:21:38 +0100
Message-ID: <8bfdaa9a-eaa5-5223-80fa-c0a315e904bb@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Gross <andy.gross@linaro.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, David Brown <david.brown@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, "Ivan T . Ivanov" <ivan.ivanov@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, lipengcheng8@huawei.com, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, orsonzhai@gmail.com, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On 09/11/2018 11:17 AM, Suzuki K Poulose wrote:
> Coresight DT bindings have been updated to obey the DTS rules
> for label/address matching for graph nodes. The changes are in
> coresight/next tree scheduled for v4.20. This series updates the
> in kernel dts to match the new bindings along with updating a couple
> of new examples (e.,g CATU) in the Documentation (which were missed
> as they were still in flight when we created the series).
> 
> Please note that this should not be pulled for v4.19, which I assume
> is a safe assumption. But please do pull it for v4.20.
> The dt updates for the Juno boards were sent earlier with the original
> DT update series and has been queued for v4.20.
> 
> Applies on coresight/next (which is based on v4.19) and should apply
> cleanly on v4.19-rc3.
> 

All,

There are some additional warnings triggered by this series, as reported
by Sudeep [0]. I intend to fix the warnings and send and updated version
soon. So kindly ignore this thread. Apologies.

[0] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-September/601121.html

Suzuki
