From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/26] omapfb: panel-tpo-td028ttec1: Remove legacy boot
 support
Date: Mon, 30 May 2016 15:35:46 +0300
Message-ID: <385de2e1-cc92-833b-fee5-6b34a065c485@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
 <20160530114258.30879-2-peter.ujfalusi@ti.com>
 <CAAfyv34WVZFu9MMRsGFYdxv8Gde3v+PPCOjEM0G0LE8k+EhOCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAfyv34WVZFu9MMRsGFYdxv8Gde3v+PPCOjEM0G0LE8k+EhOCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, robdclark@gmail.com, Dave Airlie <airlied@linux.ie>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

On 05/30/2016 02:56 PM, Belisko Marek wrote:
> Hi Peter,
>=20
> On Mon, May 30, 2016 at 1:42 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> The panel is not used by any legacy board files so the legacy (pdata=
) boot
>> support can be dropped.
> What about platforms which doesn't support DT boot yet?

We don't have non DT users for these panels.

>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   | 43 +++--------=
-----------
>>  include/video/omap-panel-data.h                    | 13 -------
>>  2 files changed, 6 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td0=
28ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028tt=
ec1.c
>> index 4d657f3ab679..f4dc023868ae 100644
>> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1=
=2Ec
>> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1=
=2Ec
>> @@ -29,7 +29,6 @@
>>  #include <linux/spi/spi.h>
>>  #include <linux/gpio.h>
>>  #include <video/omapdss.h>
>> -#include <video/omap-panel-data.h>
>>
>>  struct panel_drv_data {
>>         struct omap_dss_device dssdev;
>> @@ -365,31 +364,6 @@ static struct omap_dss_driver td028ttec1_ops =3D=
 {
>>         .check_timings  =3D td028ttec1_panel_check_timings,
>>  };
>>
>> -static int td028ttec1_panel_probe_pdata(struct spi_device *spi)
>> -{
>> -       const struct panel_tpo_td028ttec1_platform_data *pdata;
>> -       struct panel_drv_data *ddata =3D dev_get_drvdata(&spi->dev);
>> -       struct omap_dss_device *dssdev, *in;
>> -
>> -       pdata =3D dev_get_platdata(&spi->dev);
>> -
>> -       in =3D omap_dss_find_output(pdata->source);
>> -       if (in =3D=3D NULL) {
>> -               dev_err(&spi->dev, "failed to find video source '%s'=
\n",
>> -                               pdata->source);
>> -               return -EPROBE_DEFER;
>> -       }
>> -
>> -       ddata->in =3D in;
>> -
>> -       ddata->data_lines =3D pdata->data_lines;
>> -
>> -       dssdev =3D &ddata->dssdev;
>> -       dssdev->name =3D pdata->name;
>> -
>> -       return 0;
>> -}
>> -
>>  static int td028ttec1_probe_of(struct spi_device *spi)
>>  {
>>         struct device_node *node =3D spi->dev.of_node;
>> @@ -415,6 +389,9 @@ static int td028ttec1_panel_probe(struct spi_dev=
ice *spi)
>>
>>         dev_dbg(&spi->dev, "%s\n", __func__);
>>
>> +       if (!spi->dev.of_node)
>> +               return -ENODEV;
>> +
>>         spi->bits_per_word =3D 9;
>>         spi->mode =3D SPI_MODE_3;
>>
>> @@ -432,17 +409,9 @@ static int td028ttec1_panel_probe(struct spi_de=
vice *spi)
>>
>>         ddata->spi_dev =3D spi;
>>
>> -       if (dev_get_platdata(&spi->dev)) {
>> -               r =3D td028ttec1_panel_probe_pdata(spi);
>> -               if (r)
>> -                       return r;
>> -       } else if (spi->dev.of_node) {
>> -               r =3D td028ttec1_probe_of(spi);
>> -               if (r)
>> -                       return r;
>> -       } else {
>> -               return -ENODEV;
>> -       }
>> +       r =3D td028ttec1_probe_of(spi);
>> +       if (r)
>> +               return r;
>>
>>         ddata->videomode =3D td028ttec1_panel_timings;
>>
>> diff --git a/include/video/omap-panel-data.h b/include/video/omap-pa=
nel-data.h
>> index 56830d1dc762..fbdaa4c3ae96 100644
>> --- a/include/video/omap-panel-data.h
>> +++ b/include/video/omap-panel-data.h
>> @@ -223,17 +223,4 @@ struct panel_nec_nl8048hl11_platform_data {
>>         int qvga_gpio;
>>  };
>>
>> -/**
>> - * panel-tpo-td028ttec1 platform data
>> - * @name: name for display entity
>> - * @source: name of the display entity used as a video source
>> - * @data_lines: number of DPI datalines
>> - */
>> -struct panel_tpo_td028ttec1_platform_data {
>> -       const char *name;
>> -       const char *source;
>> -
>> -       int data_lines;
>> -};
>> -
>>  #endif /* __OMAP_PANEL_DATA_H */
>> --
>> 2.8.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> BR,
>=20
> marek
>=20


--=20
P=E9ter
