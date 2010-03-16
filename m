From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv5 2/2] ASoC: TWL6040: Add twl6040 codec
	driver
Date: Tue, 16 Mar 2010 18:19:26 +0000
Message-ID: <778BD450-4E6A-481F-A87B-9C7E4CCFDB83@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCE66173AF7@dlee06.ent.ti.com>
	<05b5d6bc0abd41e31334184e66718cec@secure211.sgcpanel.com>
	<1889FA7136B567478A67D4B0F85B0CCE66217087@dlee06.ent.ti.com>
	(sfid-20100316_175124_684510_30CE5530)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE66217087@dlee06.ent.ti.com>
	(sfid-20100316_175124_684510_30CE5530)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On 16 Mar 2010, at 17:51, "Olaya, Margarita" <magi.olaya@ti.com> wrote:

> On Saturday, March 13, 2010 5:23 AM  Felipe Balbi wrote:
>
>> Hi,
>>
>> On Fri, 12 Mar 2010 19:52:20 -0600, "Olaya, Margarita"
>> <magi.olaya@ti.com> wrote:
>>> +/*
>>> + * twl6040 register cache & default register settings + */
>>> +static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
>>> +       0x00, /* not used               0x00    */
>>> +       0x4B, /* TWL6040_ASICID (ro)    0x01    */
> [snip]
>>
>> a little comment about what the default values are would be nice.
>
> Most of the codecs only have the register description, not sure if  
> this
> is an standard in alsa. Some values are kind of hard to describe  
> briefly.

The standard is that these are the power on reset values, used to init  
the register cache and reduce the amount of I/O done to restore on  
resume.

>
>>
>> #ifdef CONFIG_PM
>>
>>> +static int twl6040_suspend(struct platform_device *pdev,
> [snip]
>>
>> #else
>> #define twl6040_suspend    NULL
>> #define twl6040_resume     NULL
>> #endif
>
> I'll add this.
>
> Regards,
> Margarita
>
