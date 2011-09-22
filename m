From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v5 09/15] OMAP2+: UART: Add runtime pm support for
 omap-serial driver
Date: Thu, 22 Sep 2011 13:25:36 +0530
Message-ID: <CAAL8m4zzynRm+c1xiwu117OkkX4X2ERoTDBPDL7XsihVcEL53g@mail.gmail.com>
References: <1316607206-21669-1-git-send-email-govindraj.raja@ti.com>
 <1316607206-21669-7-git-send-email-govindraj.raja@ti.com> <CACVXFVMpvF5foA1asLYE5WbvHQ3b_eXaBpiMT7Q1h0KHDGLSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40745 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab1IVHz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 03:55:57 -0400
In-Reply-To: <CACVXFVMpvF5foA1asLYE5WbvHQ3b_eXaBpiMT7Q1h0KHDGLSCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

On Thu, Sep 22, 2011 at 1:18 PM, Ming Lei <tom.leiming@gmail.com> wrote=
:
> Hi,
>
> On Wed, Sep 21, 2011 at 8:13 PM, Govindraj.R <govindraj.raja@ti.com> =
wrote:
>> Adapts omap-serial driver to use pm_runtime API's.
>
>> =A0 =A0 =A0 =A0console_unlock();
>>
>> - =A0 =A0 =A0 if ((cpu_is_omap34xx() && bdata->pads) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata->wk_en && pdata->wk_mask))
>> + =A0 =A0 =A0 if ((cpu_is_omap34xx() && bdata->pads))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_init_wakeup(&pdev->dev, true);
>
> Just a bit curious, why doesn't the code enable wakeup at default
> on omap4, which will disable runtime pm of serial port on omap4.
>

yes sure will add for omap4.


> I have tested your patches on omap4 panda(enable wakeup at
> default manually), runtime pm of serial port 2 can work well and
> remote wakeup too.
>

Thanks, for testing.

--
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
