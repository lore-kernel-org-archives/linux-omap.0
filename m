From: Mike Chan <mike@android.com>
Subject: Re: [PATCH] video: omap2: dss: RET on idle, enable/disable dss clocks
	only when needed.
Date: Fri, 18 Sep 2009 10:33:09 -0700
Message-ID: <8bb80c380909181033s2fd5e3a1o16404f1667760b25@mail.gmail.com>
References: <1253230586-931-1-git-send-email-mike@android.com>
	 <1253262472.28956.10.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:35631 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbZIRRdI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 13:33:08 -0400
Received: by vws33 with SMTP id 33so1062044vws.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2009 10:33:10 -0700 (PDT)
In-Reply-To: <1253262472.28956.10.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 18, 2009 at 1:27 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> If you disable the clocks to allow RET, you also allow OFF mode. And
> resuming from OFF mode hasn't been implemented for DSI, if I recall
> right. And when I was testing it, it didn't seem to be trivial with t=
he
> DSI PLL.
>

You can limiting the pwrdm next state to RET when being called from cpu=
idle.

> That's why currently you need to disable the display to turn off the
> clocks, and the whole DSI block is re-configured when enabling the
> display again.
>

Display enable/disable should only be called when you turn on / off
the screen, I'm not sure how this applies to getting the dss_pwrdm to
enter RET on idle while scren is on.

We haven't tested OFF, but having all power domains enter RET while
screen is on and device idle (no rendering) can give significant (~2x)
battery life improvements, depending on your hardware of course.


-- Mike

> =A0Tomi
>
>
> On Fri, 2009-09-18 at 01:36 +0200, ext Mike Chan wrote:
>> Signed-off-by: Mike Chan <mike@android.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 =A06 ++++-
>> =A0drivers/video/omap2/dss/dsi.c =A0 | =A0 50 ++++++++++++++++++++++=
+++++++++++++---
>> =A02 files changed, 51 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/d=
ss/dispc.c
>> index d061d75..4216466 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -484,13 +484,17 @@ static inline void enable_clocks(bool enable)
>> =A0bool dispc_go_busy(enum omap_channel channel)
>> =A0{
>> =A0 =A0 =A0 int bit;
>> + =A0 =A0 bool ret;
>>
>> =A0 =A0 =A0 if (channel =3D=3D OMAP_DSS_CHANNEL_LCD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D 5; /* GOLCD */
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit =3D 6; /* GODIGIT */
>>
>> - =A0 =A0 return REG_GET(DISPC_CONTROL, bit, bit) =3D=3D 1;
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 ret =3D REG_GET(DISPC_CONTROL, bit, bit) =3D=3D 1;
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 return ret;
>> =A0}
>>
>> =A0void dispc_go(enum omap_channel channel)
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss=
/dsi.c
>> index 5e3d653..e9d8a5f 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -1186,6 +1186,9 @@ int dsi_pll_init(bool enable_hsclk, bool enabl=
e_hsdiv)
>> =A0 =A0 =A0 if (r)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>>
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 DSSDBG("PLL init done\n");
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1199,11 +1202,9 @@ err0:
>>
>> =A0void dsi_pll_uninit(void)
>> =A0{
>> - =A0 =A0 enable_clocks(0);
>> - =A0 =A0 dsi_enable_pll_clock(0);
>> -
>> =A0 =A0 =A0 dsi.pll_locked =3D 0;
>> =A0 =A0 =A0 dsi_pll_power(DSI_PLL_POWER_OFF);
>> +
>> =A0 =A0 =A0 regulator_disable(dsi.vdds_dsi_reg);
>> =A0 =A0 =A0 DSSDBG("PLL uninit done\n");
>> =A0}
>> @@ -1848,6 +1849,9 @@ static int dsi_vc_send_bta_sync(int channel)
>>
>> =A0 =A0 =A0 INIT_COMPLETION(dsi.bta_completion);
>>
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 dsi_vc_enable_bta_irq(channel);
>>
>> =A0 =A0 =A0 r =3D dsi_vc_send_bta(channel);
>> @@ -1870,6 +1874,9 @@ static int dsi_vc_send_bta_sync(int channel)
>> =A0err:
>> =A0 =A0 =A0 dsi_vc_disable_bta_irq(channel);
>>
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 return r;
>> =A0}
>>
>> @@ -1921,6 +1928,9 @@ static int dsi_vc_send_long(int channel, u8 da=
ta_type, u8 *data, u16 len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 dsi_vc_write_long_header(channel, data_type, len, ecc);
>>
>> =A0 =A0 =A0 /*dsi_vc_print_status(0); */
>> @@ -1964,6 +1974,9 @@ static int dsi_vc_send_long(int channel, u8 da=
ta_type, u8 *data, u16 len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_vc_write_long_payload(channel, b1, b=
2, b3, 0);
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 return r;
>> =A0}
>>
>> @@ -1979,6 +1992,9 @@ static int dsi_vc_send_short(int channel, u8 d=
ata_type, u16 data, u8 ecc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 channel,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_typ=
e, data & 0xff, (data >> 8) & 0xff);
>>
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 if (FLD_GET(dsi_read_reg(DSI_VC_CTRL(channel)), 16, 16))=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("ERROR FIFO FULL, aborting transf=
er\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -1990,6 +2006,9 @@ static int dsi_vc_send_short(int channel, u8 d=
ata_type, u16 data, u8 ecc)
>>
>> =A0 =A0 =A0 dsi_write_reg(DSI_VC_SHORT_PACKET_HEADER(channel), r);
>>
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -2775,13 +2794,15 @@ static int dsi_update_thread(void *data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_bus_lock();
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dsi.update_mode =3D=3D OMAP_DSS_UPDA=
TE_DISABLED ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kthread_=
should_stop()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_bus_unlock();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 enable_clocks(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_perf_mark_setup();
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dsi.update_region.dirty) {
>> @@ -2872,6 +2893,9 @@ static int dsi_update_thread(void *data)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete_all(&dsi.update_completion);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 enable_clocks(0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_bus_unlock();
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XXX We need to give others chance to =
get the bus lock. Is
>> @@ -3068,6 +3092,9 @@ static int dsi_display_enable(struct omap_dss_=
device *dssdev)
>> =A0 =A0 =A0 if (dsi.update_mode =3D=3D OMAP_DSS_UPDATE_AUTO)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_start_auto_update(dssdev);
>>
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 dsi_bus_unlock();
>> =A0 =A0 =A0 mutex_unlock(&dsi.lock);
>>
>> @@ -3101,6 +3128,9 @@ static void dsi_display_disable(struct omap_ds=
s_device *dssdev)
>> =A0 =A0 =A0 dsi.update_mode =3D OMAP_DSS_UPDATE_DISABLED;
>> =A0 =A0 =A0 dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
>>
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 dsi_display_uninit_dispc(dssdev);
>>
>> =A0 =A0 =A0 dsi_display_uninit_dsi(dssdev);
>> @@ -3128,6 +3158,9 @@ static int dsi_display_suspend(struct omap_dss=
_device *dssdev)
>> =A0 =A0 =A0 dsi.update_mode =3D OMAP_DSS_UPDATE_DISABLED;
>> =A0 =A0 =A0 dssdev->state =3D OMAP_DSS_DISPLAY_SUSPENDED;
>>
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 dsi_display_uninit_dispc(dssdev);
>>
>> =A0 =A0 =A0 dsi_display_uninit_dsi(dssdev);
>> @@ -3181,6 +3214,9 @@ static int dsi_display_resume(struct omap_dss_=
device *dssdev)
>> =A0 =A0 =A0 if (dsi.update_mode =3D=3D OMAP_DSS_UPDATE_AUTO)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_start_auto_update(dssdev);
>>
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 dsi_bus_unlock();
>> =A0 =A0 =A0 mutex_unlock(&dsi.lock);
>>
>> @@ -3325,6 +3361,9 @@ static int dsi_display_enable_te(struct omap_d=
ss_device *dssdev, bool enable)
>>
>> =A0 =A0 =A0 dsi_bus_lock();
>>
>> + =A0 =A0 enable_clocks(1);
>> + =A0 =A0 dsi_enable_pll_clock(1);
>> +
>> =A0 =A0 =A0 dsi.te_enabled =3D enable;
>>
>> =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
>> @@ -3332,6 +3371,9 @@ static int dsi_display_enable_te(struct omap_d=
ss_device *dssdev, bool enable)
>>
>> =A0 =A0 =A0 dsi_set_te(dssdev, enable);
>> =A0end:
>> + =A0 =A0 enable_clocks(0);
>> + =A0 =A0 dsi_enable_pll_clock(0);
>> +
>> =A0 =A0 =A0 dsi_bus_unlock();
>>
>> =A0 =A0 =A0 return 0;
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
