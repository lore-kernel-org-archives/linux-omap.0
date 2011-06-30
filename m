From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 8/9] OMAP: PM CONSTRAINTS: implement the devices
 wake-up latency constraints
Date: Thu, 30 Jun 2011 17:08:08 +0200
Message-ID: <BANLkTin0A8hYaL9-XB95vNyb8=YgPzDMBg@mail.gmail.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
	<1308926286-30445-9-git-send-email-j-pihet@ti.com>
	<20110627183345.GA6187@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47110 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1F3PII convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 11:08:08 -0400
Received: by qwk3 with SMTP id 3so1152176qwk.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 08:08:08 -0700 (PDT)
In-Reply-To: <20110627183345.GA6187@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Mon, Jun 27, 2011 at 8:33 PM, Todd Poynor <toddpoynor@google.com> wr=
ote:
> On Fri, Jun 24, 2011 at 04:38:05PM +0200, jean.pihet@newoldbits.com w=
rote:
> ...
>> + =A0 =A0 /* Find the associated omap_device for dev */
>> + =A0 =A0 od =3D container_of(pdev, struct omap_device, pdev);
>> + =A0 =A0 if (!od || (od->hwmods_cnt !=3D 1)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No unique hwmod for dev=
ice %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(pm_qos_r=
eq->dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> Check for !od can be dropped... if there's a check for !pdev needed
> can add that, but container_of() won't return NULL for a valid
> contained field.
Ok fixed in the v2 version.

Thanks!
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
