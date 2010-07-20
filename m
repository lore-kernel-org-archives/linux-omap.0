From: Sergey Lapin <slapinid@gmail.com>
Subject: DSS2: RFBI: how to make it work?
Date: Tue, 20 Jul 2010 18:06:57 +0400
Message-ID: <AANLkTilaIeVWsEC-dKKsAf-M37BygHNUukGS9Bao6EgH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64392 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab0GTOG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 10:06:58 -0400
Received: by bwz1 with SMTP id 1so2874520bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Jul 2010 07:06:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

Hi, all!

I'm trying to rewrite my old driver to DSS2. The driver is for small
176x220 module attached over RFBI interface
on OMAP3525. It basically works with old kernel and drivers/video/omap/*.

I still can't make it work, so is it known which code is necessary to
initialize a panel? I tried
to compare APIs with old and new subsystems and can't see what I am doing wrong.

In original code, I just init rfbi and dispc, and then directly write
to panel (commands and their parameters).

The same code with new API does not seem to produce any results.
Display stays uninitialized,
so commands seem not to get to it.

The code:
...

static struct omap_video_timings panel_timings = {
        .x_res          = 176,
        .y_res          = 220,
};

static int panel_probe(struct omap_dss_device *dssdev)
{
        int err;
        struct rfbi_timings t;
        pr_debug("%s\n", __func__);
        dssdev->panel.config = OMAP_DSS_LCD_TFT |
                                OMAP_DSS_LCD_IVS | OMAP_DSS_LCD_IHS;
        dssdev->panel.timings = panel_timings;
        dssdev->phy.rfbi.channel = 0;
        dssdev->ctrl.pixel_size = 24;
        dssdev->phy.rfbi.data_lines = 8;
        hx8340_dss = dssdev;

        t.cs_on_time = 0;
        t.we_on_time = t.cs_on_time + 0;
        t.re_on_time = t.we_on_time + 0;
        t.we_off_time = t.we_on_time + 15000;
        t.re_off_time = t.we_off_time + 15000;
        t.access_time = 0;
        t.cs_off_time = t.we_off_time + 0;
        t.we_cycle_time = t.cs_off_time + 10000;
        t.re_cycle_time = t.we_cycle_time + 15000;
        t.cs_pulse_width = 41000;
        dssdev->ctrl.rfbi_timings = t;
        if (dssdev->platform_enable)
                dssdev->platform_enable(dssdev);
.....
        return 0;
}
static void cmd_data(u8 cmd, u8 data)
{
        omap_rfbi_write_command(&cmd, 1);
        omap_rfbi_write_data(&data, 1);
}

static int panel_power_on(struct omap_dss_device *dssdev)
{
        int err;
        err = omapdss_rfbi_display_enable(dssdev);
        if (err < 0)
                return err;
        if (dssdev->platform_enable) {
                err = dssdev->platform_enable(dssdev);
                if (err)
                        return err;
        }
        cmd_data(0x18, 0x44);
        cmd_data(0x1B, 0x44);
.....

        return 0;
}
static int panel_enable(struct omap_dss_device *dssdev)
{
        panel_power_on(dssdev);
        dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
        return 0;
}
...
static void panel_get_timings(struct omap_dss_device *dssdev,
                struct omap_video_timings *timings)
{
        *timings = dssdev->panel.timings;
}

static int panel_check_timings(struct omap_dss_device *dssdev,
                struct omap_video_timings *timings)
{
        return 0;
}
struct omap_dss_driver hx8340_panel_driver = {
        .probe          = panel_probe,
....
        .enable         = panel_enable,
...
        .get_timings    = panel_get_timings,
        .check_timings  = panel_check_timings,
...
        .driver         = {
                .name   = "custom-panel",
                .owner  = THIS_MODULE,
        },
};

Any ideas on what is wrong with initialization?
Driver works with old susbystem, but it is very messed-up and requires
patching of subsystem itself.
I skip timer-based auto-update setup here, because I want to make
initialization work first and then move
to that portion later.

Thanks a lot,
S.
