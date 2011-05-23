From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v4 1/2] REGULATOR: TWL6025: add support to twl-regulator
Date: Mon, 23 May 2011 10:57:54 +0100
Message-ID: <4DDA2FA2.2000604@ti.com>
References: <1306095684-7732-1-git-send-email-gg@slimlogic.co.uk> <1306095684-7732-2-git-send-email-gg@slimlogic.co.uk> <20110522224857.GA15882@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110522224857.GA15882@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux@slimlogic.co.uk" <linux@slimlogic.co.uk>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On 22/05/11 23:48, Mark Brown wrote:
> On Sun, May 22, 2011 at 09:21:23PM +0100, Graeme Gregory wrote:
>> Adding support for the twl6025. Major difference in the twl6025 is the
>> group functionality has been removed from the chip so this affects how
>> regulators are enabled and disabled.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
>> Since V1
>>
>> Use the features variable passed via platform data instead of calling
>> global function.
> 
> Change histories like this should usually come after the --- so things
> like git am strip them out of what actually ends up in git.

Applied.

Thanks

Liam
