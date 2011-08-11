From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power domains next state
Date: Thu, 11 Aug 2011 17:09:59 +0200
Message-ID: <CAORVsuWHc=ybjTAXe7=Dqj4Pnme6q29eqN0t3AHVkZE5CL+RpA@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-9-git-send-email-j-pihet@ti.com>
	<20110729075942.GA26959@google.com>
	<CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
	<20110729180047.GA14228@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62947 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab1HKPKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:10:00 -0400
Received: by qyk38 with SMTP id 38so3540019qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:09:59 -0700 (PDT)
In-Reply-To: <20110729180047.GA14228@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Jean Pihet <j-pihet@ti.com>

Hi Todd,

On Fri, Jul 29, 2011 at 8:00 PM, Todd Poynor <toddpoynor@google.com> wr=
ote:
> On Fri, Jul 29, 2011 at 10:47:43AM +0200, Jean Pihet wrote:
>> On Fri, Jul 29, 2011 at 9:59 AM, Todd Poynor <toddpoynor@google.com>=
 wrote:
> ...
>> > All min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
>> > free_new_user =3D 1.
>> free_new_user =3D 1 is only needed if no existing constraint has bee=
n
>> found, i.e. user stays at NULL. This is implemented in the check for
>> an existing constraint (plist_for_each_entry(...)).
>
> Oops, I meant to say it applies in all cases where min_latency =3D=3D
> PM_QOS_DEV_LAT_DEFAULT_VALUE, since the new node is only used for
> adding a constraint (and no existing constraint found). =A0I'd sugges=
t
> something like:
>
> =A0 =A0 =A0 =A0if (min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_user =3D kzalloc(sizeof(struct pwr=
dm_wkup_constraints_entry),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<check NULL return>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_new_user =3D 1;
> =A0 =A0 =A0 =A0}
>
> and then set free_new_user =3D 0 only if no existing constraint is fo=
und
> for the add case. =A0Because it's easy to miss cases where the
> allocated memory needs to be freed when that's not the default, and y=
ou
> might as well skip the allocate on a constraint removal. =A0Pretty mi=
nor
> point, though.

This has been addressed in the latest patch set (v4).

Regards,
Jean

>
>
> Todd
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
