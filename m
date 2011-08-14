From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 04/15] PM QoS: re-organize data structs
Date: Sun, 14 Aug 2011 10:29:43 +0200
Message-ID: <CAORVsuWHCf3EuQfpCGGSxxUc-K5e1dM2KDf8z5avPpQ=+V1DFw@mail.gmail.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<1313075212-8366-5-git-send-email-j-pihet@ti.com>
	<20110813025629.GD639@gvim.org>
	<201108132258.49283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63453 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1HNI3o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Aug 2011 04:29:44 -0400
Received: by qwk3 with SMTP id 3so2095061qwk.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Aug 2011 01:29:43 -0700 (PDT)
In-Reply-To: <201108132258.49283.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, markgross@thegnar.org
Cc: Jean Pihet <j-pihet@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>

Rafael, Mark,

On Sat, Aug 13, 2011 at 10:58 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
> On Saturday, August 13, 2011, mark gross wrote:
>> On Thu, Aug 11, 2011 at 05:06:41PM +0200, jean.pihet@newoldbits.com =
wrote:
>> > From: Jean Pihet <j-pihet@ti.com>
>> >
>> > In preparation for the per-device constratins support, re-organize
>> > the data strctures:
>> > - add a struct pm_qos_constraints which contains the constraints
>> > related data
>> > - update struct pm_qos_object contents to the PM QoS internal obje=
ct
>> > data. Add a pointer to struct pm_qos_constraints
>> > - update the internal code to use the new data structs.
>> >
>> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> > ---
>> > =A0include/linux/pm_qos.h | =A0 19 ++++++++++
>> > =A0kernel/power/qos.c =A0 =A0 | =A0 90 ++++++++++++++++++++++-----=
--------------------
>> > =A02 files changed, 61 insertions(+), 48 deletions(-)
>> >
>> > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> > index 6b0968f..9772311 100644
>> > --- a/include/linux/pm_qos.h
>> > +++ b/include/linux/pm_qos.h
>> > @@ -25,6 +25,25 @@ struct pm_qos_request {
>> > =A0 =A0 int pm_qos_class;
>> > =A0};
>> >
>> > +enum pm_qos_type {
>> > + =A0 PM_QOS_UNITIALIZED,
>> what is this for?
>
> I seem to remember discussing that previously, but I can't recall wha=
t
> it's for. =A0Jean?
>

Sorry it is a left over from the previous version, it has been used to
detect non initialized data structs.
It is still used to detect an error in pm_qos_get_value and so by its
callers pm_qos_update_target and pm_qos_power_read. I have to admit
the usefulness is quite limited.

Is the removal of PM_QOS_UNITIALIZED needed? I would say no.

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
