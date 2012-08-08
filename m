From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/4] ARM: OMAP3: Switch to use the unified
 audio driver (omap-twl4030) for selected boards
Date: Wed, 08 Aug 2012 15:29:41 +0300
Message-ID: <50225BB5.3000407@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
 <1344419650-5389-4-git-send-email-peter.ujfalusi@ti.com>
 <50225A84.5010008@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50225A84.5010008@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

Hi Igor,

On 08/08/2012 03:24 PM, Igor Grinberg wrote:
>> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/bo=
ard-cm-t35.c
>> index 97d7190..b73fa5c 100644
>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>> @@ -731,6 +731,7 @@ static void __init cm_t3x_common_init(void)
>>  	cm_t35_init_ethernet();
>>  	cm_t35_init_led();
>>  	cm_t35_init_display();
>> +	omap_twl4030_audio_init("overo", 26000000);
> =

> Can the card_name here be "cm-t3x" ?

I have used the "overo" as card name here since what I gathered is that cm-=
t35
used the sound/soc/omap/overo.c machine driver for audio support.
If the card name is changing your existing user space might get confused by
the card name change.
But sure, I can change the card name to "cm-t3x" if it is better for you.

-- =

P=E9ter
