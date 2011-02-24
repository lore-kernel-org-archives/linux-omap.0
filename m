From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 06/19] omap3+: voltage: use volt_data pointer instead values
Date: Thu, 24 Feb 2011 22:52:14 +0530
Message-ID: <AANLkTimGy=+BxCRrKTVOBLCceJGyzOQib-Pz_YbXqduv@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-7-git-send-email-nm@ti.com>
 <AANLkTik8=zPKU9UNVij-VxXui4kCtN2fqNCGs_dM7E+i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49239 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521Ab1BXRWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 12:22:38 -0500
Received: by mail-wy0-f172.google.com with SMTP id 42so802393wyb.31
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 09:22:37 -0800 (PST)
In-Reply-To: <AANLkTik8=zPKU9UNVij-VxXui4kCtN2fqNCGs_dM7E+i@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

On Thu, Feb 24, 2011 at 10:58, Gulati, Shweta <shweta.gulati@ti.com> wrote:
> Hi,
>
> On Sat, Feb 19, 2011 at 5:31 PM, Nishanth Menon <nm@ti.com> wrote:
>> Voltage values can get confusing in meaning with various Smartreflex
>> classes being active. Depending on the class used, the actual voltage
>> selected might be a variant. Hence pass the volt_data pointers through
>> the structure. Each voltage domain contains a set of volt_data structs.
>> Each of those volt_data struct represents a voltage point that is supported
>> for that domain. Hence, this is a more accurate representation of the
>> voltage point we are interested in going to, and the actual translation
>> of this voltage point to the voltage value is done inside the voltage layer
>> which allows the users of the voltage layer to be blissfully ignorant
>> of any complexity of the underneath layers.
> Volt_data has efuse, Errgain and errminlimit other than nom_volt
> How does this data differs in different SR Class implementation which
> is why using volt_data is required?
fair question. let me try it this way.
with smart reflex class 3:
a) you dont have SR enabled, you will go to volt_nominal
b) you have SR enabled, you go to volt_nominal, then enable SR and
expect it to adjust voltage.
we dont really care about the resultant voltage(until the next scale
ofcourse). but when we ask voltage layer to scale to voltage x for OPP
y, it always means x is the nominal voltage for OPP y.

Now with class 1.5 as introduced in
http://marc.info/?l=linux-omap&m=129811707718325&w=2,
a) if you are booting for the first time OR if you never enable SR,
you go to volt_nominal
b) if you enable SR and the OPP is calibrated, you will not enable SR
again when that OPP is accessed anymore, but when you set voltage, the
voltage achieved will be volt_calibrated
c) if recalibration timeout triggers, the calibrated values are
nullified, and you set voltage, the voltage achieved will be
volt_dynamic_nominal

so, voltage for that OPP you are setting has not 1 single value
anymore, but 3 possible valid values depending on which state the
system is at.

This is the motivation of decoupling values representing voltage in
this patch and instead we use a "voltage object" represented by the
pointer to volt_data to decide adequately the OPP voltage we go to.
The decision as to what the "voltage object" means in uVolts is left
to the voltage layer. upper layers (or users of voltage layer) are not
aware of the system conditions relevant to voltage - only voltage.c
has that view - hence we do the translation there.

[...]

Regards,
Nishanth Menon
