From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: Re: [PATCH 1/2] OMAP4: PMIC: Rename twl6030_codec as
	twl6040_codec
Date: Tue, 16 Mar 2010 12:35:40 -0500
Message-ID: <1889FA7136B567478A67D4B0F85B0CCE66217061@dlee06.ent.ti.com>
References: <1889FA7136B567478A67D4B0F85B0CCE66173AF6@dlee06.ent.ti.com>
	<ea13b3e438eb2455f4d0d91396f2500e@secure211.sgcpanel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <ea13b3e438eb2455f4d0d91396f2500e@secure211.sgcpanel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Saturday, March 13, 2010 5:18 AM  Felipe Balbi wrote: 

> Hi,
> 
> On Fri, 12 Mar 2010 19:52:15 -0600, "Olaya, Margarita"
> <magi.olaya@ti.com> wrote:
> 
> please add a description here. Why do you need to rename it ?

Ok, I'll add a description. We were using twl6030 for Phoenix
Audio and Phoenix Power chips but Phoenix Audio is actually twl6040.

> 
>> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> 
> [snip]
> 
>>  	if (twl_has_codec() && pdata->codec && twl_class_is_6030()) {
>>  		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
>> -		child = add_child(sub_chip_id, "twl6030_codec",
>> +		child = add_child(sub_chip_id, "twl6040_codec",
> 
> you rename the platform_device but no the platform_driver ??
> how do you expect the driver to probe() ??

Platform_driver register is called in twl6040.c file, I haven't found an issue
at probe.
