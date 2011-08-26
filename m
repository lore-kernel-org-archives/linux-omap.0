From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Fri, 26 Aug 2011 11:25:13 +0900
Message-ID: <CAJ0PZbRCvoh8-rJAR92Ak_JPk4FyR0dp_OeKOUkWtD5AdFsPCw@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35895 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab1HZCZP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 22:25:15 -0400
Received: by bke11 with SMTP id 11so2185476bke.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Aug 2011 19:25:13 -0700 (PDT)
In-Reply-To: <1309446685-17502-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jul 1, 2011 at 12:11 AM,  <jean.pihet@newoldbits.com> wrote:
> @@ -129,19 +146,19 @@ static const struct file_operations pm_qos_powe=
r_fops =3D {
> =A0/* unlocked internal variant */
> =A0static inline int pm_qos_get_value(struct pm_qos_object *o)
> =A0{
> - =A0 =A0 =A0 if (plist_head_empty(&o->requests))
> + =A0 =A0 =A0 if (plist_head_empty(o->requests))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return o->default_value;
>
> =A0 =A0 =A0 =A0switch (o->type) {
> - =A0 =A0 =A0 case PM_QOS_MIN:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(&o->requests)->prio;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MIN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(o->r=
equests)->prio;
>
> - =A0 =A0 =A0 case PM_QOS_MAX:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(&o->requests)->prio;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MAX:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(o->re=
quests)->prio;
>
> - =A0 =A0 =A0 default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for not using enum */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for no=
t using enum */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> =A0 =A0 =A0 =A0}
> =A0}

Hello,


Sorry to jump in this late, but, I've got a question in choosing QoS
value from the list with pm_qos_get_value function and pm_qos_type.

=46or QoS objects such as network throughput, wouldn't "PM_QOS_ADD" be
more appropriate than PM_QOS_MAX?
If A is requesting 10MB/s on NIC-X and B is requesting 5MB/s on NIC-X,
I guess PM QOS should say NIC-X that it needs to provide 15MB/s, not
10MB/s. Or, are we assuming that A and B will never put streams at the
same time?


Thanks,
MyungJoo

--=20
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
