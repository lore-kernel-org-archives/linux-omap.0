From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v4 2/2] USB: TWL6025 allow different regulator name
Date: Mon, 23 May 2011 10:58:27 +0100
Message-ID: <4DDA2FC3.20009@ti.com>
References: <1306095684-7732-1-git-send-email-gg@slimlogic.co.uk> <1306095684-7732-3-git-send-email-gg@slimlogic.co.uk> <20110522225103.GB15882@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110522225103.GB15882@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux@slimlogic.co.uk" <linux@slimlogic.co.uk>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On 22/05/11 23:51, Mark Brown wrote:
> On Sun, May 22, 2011 at 09:21:24PM +0100, Graeme Gregory wrote:
>> The twl6025 uses a different regulator for USB than the 6030 so select
>> the correct regulator name depending on the subclass of device.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
