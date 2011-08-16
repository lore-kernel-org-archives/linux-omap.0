From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/15] PM QoS: add a global notification mechanism for the
 device constraints
Date: Tue, 16 Aug 2011 11:58:38 +0200
Message-ID: <CAORVsuUNxCN7+KZnpJT5Urd07cB+raX6e23ah_9Mp8M07SAyLw@mail.gmail.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<1313075212-8366-8-git-send-email-j-pihet@ti.com>
	<201108142350.42260.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55857 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab1HPJ6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 05:58:39 -0400
Received: by qwk3 with SMTP id 3so2879941qwk.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 02:58:39 -0700 (PDT)
In-Reply-To: <201108142350.42260.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Rafael,

2011/8/14 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> There is some code duplication in this patch that should better be
> avoided (details below).
>
> On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Add a global notification chain that gets called upon changes to the
>> aggregated constraint value for any device.
>> The notification callbacks are passing the full constraint request d=
ata
>> in order for the callees to have access to it. The current use is fo=
r the
>> platform low-level code to access the target device of the constrain=
t.
>>
=2E..

>
> The following code:
>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Update constraints list and call the per-device callb=
acks if needed
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ret =3D pm_qos_update_target(dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&re=
q->node, PM_QOS_ADD_REQ, value);
>> +
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Call the global callbacks if needed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 curr_value =3D pm_qos_read_value(req->dev-=
>power.constraints);
>> + =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&dev_pm_notif=
iers,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(unsigned long)curr_value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0req);
>> + =A0 =A0 }
>
> is used in dev_pm_qos_update_request() and dev_pm_qos_remove_request(=
)
> with the only difference being the command given to pm_qos_update_tar=
get().
> This asks for a common function, eg. dev_pm_qos_update_target(), cont=
aining
> that code that will be called by all of them (and, apparently, by
> dev_pm_qos_constraints_destroy()).
Ok that makes the code cleaner.

>
> ...
>> @@ -250,9 +329,18 @@ void dev_pm_qos_constraints_destroy(struct devi=
ce *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Update constraints =
list and call the per-device
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* callbacks if needed
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_update_target(req->=
dev->power.constraints,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&req->node, PM_QOS_REMOVE_REQ,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0PM_QOS_DEFAULT_VALUE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D pm_qos_update_tar=
get(req->dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &req->node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PM_QOS_REMOVE_REQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PM_QOS_DEFAULT_VALUE);
>
> I'm not sure why you're using the binary or operator here. =A0Shouldn=
't that be
> a simple assignment?
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Call the global callbac=
ks if needed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_value =3D dev->power.=
constraints->default_value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_cha=
in(&dev_pm_notifiers,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long)curr_value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
In the sake of optimization I had a single return value that
aggregates the return values of the calls target_value and calls the
global notifier callbacks _only once_.

As you suggested it is better to use the common update code, which
makes the code cleaner but also removes this optimization.

>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev->power.constraints->notifiers)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev->power.constraints);
>
> Thanks,
> Rafael
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
