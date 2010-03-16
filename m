From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCHv5 2/2] ASoC: TWL6040: Add twl6040 codec
	driver
Date: Tue, 16 Mar 2010 12:51:10 -0500
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE66217087@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE66173AF7@dlee06.ent.ti.com>
	<05b5d6bc0abd41e31334184e66718cec@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <05b5d6bc0abd41e31334184e66718cec@secure211.sgcpanel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Saturday, March 13, 2010 5:23 AM  Felipe Balbi wrote: 

> Hi,
> 
> On Fri, 12 Mar 2010 19:52:20 -0600, "Olaya, Margarita"
> <magi.olaya@ti.com> wrote:
>> +/*
>> + * twl6040 register cache & default register settings + */
>> +static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
>> +       0x00, /* not used               0x00    */
>> +       0x4B, /* TWL6040_ASICID (ro)    0x01    */
[snip]
> 
> a little comment about what the default values are would be nice.

Most of the codecs only have the register description, not sure if this
is an standard in alsa. Some values are kind of hard to describe briefly.

> 
> #ifdef CONFIG_PM
> 
>> +static int twl6040_suspend(struct platform_device *pdev,
[snip]
> 
> #else
> #define twl6040_suspend    NULL
> #define twl6040_resume     NULL
> #endif

I'll add this.

Regards,
Margarita
