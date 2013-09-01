From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] omap2: panel-generic: Added panel parameters for
 ortus-com37h3m05dtc/99dtc and sharp-lq070y3dg3b.
Date: Sun, 1 Sep 2013 14:32:05 +0200
Message-ID: <CAAfyv35ViR6PxTAs-Q2OUHWn93RsX8eep-ew8m-AN1SjS-V80g@mail.gmail.com>
References: <1377779724-30648-1-git-send-email-marek@goldelico.com>
	<52205056.8080908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52205056.8080908@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On Fri, Aug 30, 2013 at 9:57 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 29/08/13 15:35, Marek Belisko wrote:
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>>  drivers/video/omap2/displays/panel-generic-dpi.c | 53 ++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
>> index bebebd4..d573291 100644
>> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
>> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
>> @@ -107,6 +107,33 @@ static struct panel_config generic_dpi_panels[] = {
>>               .name                   = "sharp_ls",
>>       },
>
> The drivers in drivers/video/omap2/displays/ are on their way out, and
> will probably be removed for 3.12. Please look at the new one at
> drivers/video/omap2/displays-new/panel-dpi.c.
I've probably miss series (OMAPDSS: remove old panel model code)
and in time when sent patch it wasn't in linux-next yes. AFAIU generic
panel settings
was moved to board files which is not case for our patch as gta04
(other) board with panel isn't yes mainlined.
>
>  Tomi
>
>

Regards,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
