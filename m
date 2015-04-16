From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: dra7: Implement Workaround for
 Errata i813
Date: Thu, 16 Apr 2015 13:55:03 +0300
Message-ID: <CANOLnOMYgPxDnqrvBjV-dddniThJAGOioDtsJ54CB8rP6+iwzw@mail.gmail.com>
References: <1429179514-21677-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1429179514-21677-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 16, 2015 at 1:18 PM, Keerthy <j-keerthy@ti.com> wrote:
> DESCRIPTION
>
> Spurious Thermal Alert: Talert can happen randomly while the device r=
emains under the temperature limit
> defined for this event to trig. This spurious event is caused by a in=
correct re-synchronization between
> clock domains. The comparison between configured threshold and curren=
t temperature value can happen
> while the value is transitioning (metastable), thus causing inappropr=
iate event generation.
> No spurious event occurs as long as the threshold value stays unchang=
ed. Spurious event can be
> generated while a thermal alert threshold is modified in
> CONTROL_BANDGAP_THRESHOLD_MPU/GPU/CORE/DSPEVE/IVA_n.
> WORKAROUND
>
> Spurious event generation can be avoided by performing following sequ=
ence when the threshold is
> modified:
> 1. Mask the hot/cold events at the thermal IP level.
> 2. Modify Threshold.
> 3. Unmask the hot/cold events at the thermal IP level.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 41 ++++++++++++=
+++++++++-
>  drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 ++-
>  3 files changed, 45 insertions(+), 3 deletions(-)
>
> ...

> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/th=
ermal/ti-soc-thermal/ti-bandgap.h
> index b2da3fc..0c52f7a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -320,7 +320,8 @@ struct ti_temp_sensor {
>   *
>   * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the bandg=
ap device
>   *     has Errata 814
> - *
> + * TI_BANDGAP_FEATURE_ERRATA_813 - used to workaorund when the bandg=
ap device
> + *     has Errata 813

workaorund?


--
Gra=C5=BEvydas
