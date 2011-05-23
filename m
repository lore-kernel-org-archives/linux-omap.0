From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v4 2/2] USB: TWL6025 allow different regulator name
Date: Mon, 23 May 2011 13:58:44 +0100
Message-ID: <4DDA5A04.7050703@ti.com>
References: <1306095684-7732-1-git-send-email-gg@slimlogic.co.uk> <1306095684-7732-3-git-send-email-gg@slimlogic.co.uk> <20110522225103.GB15882@opensource.wolfsonmicro.com> <4DDA2FC3.20009@ti.com> <20110523111326.GD5663@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110523111326.GD5663@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux@slimlogic.co.uk" <linux@slimlogic.co.uk>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On 23/05/11 12:13, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, May 23, 2011 at 10:58:27AM +0100, Liam Girdwood wrote:
>> On 22/05/11 23:51, Mark Brown wrote:
>>> On Sun, May 22, 2011 at 09:21:24PM +0100, Graeme Gregory wrote:
>>>> The twl6025 uses a different regulator for USB than the 6030 so select
>>>> the correct regulator name depending on the subclass of device.
>>>
>>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>>
>> Acked-by: Liam Girdwood <lrg@ti.com>
> 
> Maybe it's better for you to carry this one Liam. I'm done taking
> patches for this merge window and this is related to the same series
> adding support to twl6025. Either that or this will be pending until
> 2.6.41 merge window.
> 

Ok, I've now applied it to regulator.

Thanks !

Liam
