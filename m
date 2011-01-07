From: Ben Tucker <btucker@mpcdata.com>
Subject: RE: RFBI worked example
Date: Fri, 7 Jan 2011 14:18:56 -0000
Message-ID: <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54003 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1AGOSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 09:18:03 -0500
Received: by iyi12 with SMTP id 12so15811489iyi.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 06:18:03 -0800 (PST)
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com
In-Reply-To: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com

With further experimentation it appears that I can call the
omap_rfbi_update() from the call back, but as the callback is in interrupt
context this could be dangerous. I would love to see an example of this
elsewhere.

static void framedone_callback(void *data)
{
    int r;
    u16 dw, dh;
    struct omap_dss_device *dssdev = (struct omap_dss_device *)data;

    /* Start the next update, triggered on the external H/VSync signals */
    dssdev->driver->get_resolution(dssdev, &dw, &dh);
    r = omap_rfbi_update(dssdev, 0, 0, dw, dh, framedone_callback,
dssdev);
    if (r < 0)
        printk("omap_rfbi_update FAILED");
}

static int generic_panel_power_on(struct omap_dss_device *dssdev)
{
    int r;
    u16 dw, dh;

    r = omapdss_rfbi_display_enable(dssdev);
    if (r < 0)
        goto err0;

    /* Setup external HSYNC/VSYNC triggering */
    r = omap_rfbi_setup_te(OMAP_DSS_RFBI_TE_MODE_2,
                           4000000,     /* HSYNS pulse 4uS */
                           1000000000,  /* VSYNC pulse 1ms */
                           0, 0,       /* H/VSYNC not inverted */
                           0);
    if (r < 0)
        goto err1;

    /* Enable external triggering */
    r = omap_rfbi_enable_te(1, 0);
    if (r < 0)
        goto err1;

#if 0
    /* At a guess I do not think we need to do the prepare_update
     * if we are updating the whole area
     */
    r = omap_rfbi_prepare_update(dssdev, ???);
    if (r < 0)
        goto err1;
#endif

    /* Start the first update, triggered on the external H/VSync siganls.
     * The callback (FRAMEDONE interrupt context) will re-arm this
     * update once more.
     */
    dssdev->driver->get_resolution(dssdev, &dw, &dh);
    r = omap_rfbi_update(dssdev, 0, 0, dw, dh, framedone_callback,
dssdev);
    if (r < 0)
        goto err1;


    if (dssdev->platform_enable) {
        r = dssdev->platform_enable(dssdev);
        if (r)
            goto err1;
    }

    return 0;
err1:
    omap_rfbi_enable_te(0, 0);
    omapdss_dpi_display_disable(dssdev);
err0:
    return r;
}




-----Original Message-----
From: Ben Tucker [mailto:btucker@mpcdata.com]
Sent: 06 January 2011 15:32
To: 'linux-omap@vger.kernel.org'
Cc: 'tomi.valkeinen@nokia.com'
Subject: RFBI worked example



Hi,

I am trying to setup an OMAP3530 based system for RFBI video output using
external triggering. Looking at the omap dss2 source code (and also
searching around) I cannot find any worked example of how to use the rfbi
driver. I know that RFBI has worked in the past for a Nokia N800 device.
Can you dig out any source code that shows how to use the RFBI driver?
In particular I need to see how the omap_rfbi_prepare_update() and
omap_rfbi_update() calls operate with their callback. I am thinking that I
should simply call omap_rfbi_update() in a thread and wait for the
completion call back after each call. I want to confirm that this is the
correct way to run the driver.

Thanks,
	Ben



Ben Tucker
Senior Software Engineer
MPC Data Limited
e-mail: <btucker@mpc-data.co.uk>      web: www.mpc-data.co.uk
tel: +44 (0) 1225 710600              fax: +44 (0) 1225 710601
ddi: +44 (0) 1225 710660

MPC Data Limited is a company registered in England and Wales with company
number 05507446
Registered Address: County Gate, County Way, Trowbridge, Wiltshire, BA14
7FJ
VAT no: 850625238

The information in this email and in the attached documents is
confidential and may be
legally privileged. Any unauthorized review, copying, disclosure or
distribution is
prohibited and may be unlawful. It is intended solely for the addressee.
Access to this
email by anyone else is unauthorized. If you are not the intended
recipient, please
contact the sender by reply email and destroy all copies of the original
message. When
addressed to our clients any opinions or advice contained in this email is
subject to
the terms and conditions expressed in the governing contract.
