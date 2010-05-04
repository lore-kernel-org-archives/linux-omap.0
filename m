From: "Hemanth V" <hemanthv@ti.com>
Subject: RE: [RFC][PATCH1/2] SFH7741: proximity sensor driver support
Date: Tue, 4 May 2010 11:46:09 +0530 (IST)
Message-ID: <52275.10.24.255.17.1272953769.squirrel@dbdmail.itg.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B3164B2F@dbde02.ent.ti.com>
    <02ab01caea96$26e07a40$LocalHost@wipblrx0099946>
    <0680EC522D0CC943BC586913CF3768C003B3164BC3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34733 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab0EDGQN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 02:16:13 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3164BC3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> ----- Original Message -----
>> From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
>> >
>> > From: Datta, Shubhrajyoti
>> > Sent: Monday, May 03, 2010 11:07 AM
>> > To: Datta, Shubhrajyoti
>> > Subject: [RFC][PATCH1/2] SFH7741: proximity sensor driver support
>> >
>>
>> > +
>> > +static irqreturn_t sfh7741_isr(int irq, void *dev_id)
>> > +{
>> > + struct sfh7741_drvdata *ddata = dev_id;
>> > +
>> > + int proximity = gpio_get_value(ddata->proximity_out);
>> > + input_report_abs(ddata->input, ABS_DISTANCE, proximity);
>> > + input_sync(ddata->input);
>> > +
>> > + return IRQ_HANDLED;
>> > +}
>> > +
>> > +static int __devinit sfh7741_setup(struct device *dev,
>> > + struct sfh7741_drvdata *ddata
>> > + )
>> > +{
>> > + int  error;
>> > + char *desc = "sfh7741";
>> > +
>> > + error = gpio_request(ddata->proximity_out, desc);
>> > + if (error < 0) {
>> > + dev_err(dev, "failed to request GPIO %d, error %d\n",
>> > + ddata->proximity_out, error);
>> > + return error;
>> > + }
>> > +
>> > + error = gpio_direction_input(ddata->proximity_out);
>> > + if (error < 0) {
>> > + dev_err(dev, "failed to configure direction for GPIO %d,\
>> > + error %d\n", ddata->proximity_out, error);
>> > + goto fail1;
>> > + }
>> > +
>>
>> General comment about GPIO,
>> It might be better to have GPIO configuration as part of board file,
>> rather than being part of the driver. This is should make the driver
>> more generic.
> I read GPIO in the ISR how can I take care of that?

A generic read function pointer could be defined as part
of platform data, which could be used to retieve gpio value


