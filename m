From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/5] omap: mailbox: add omap_device latency information
Date: Tue, 9 Nov 2010 21:03:08 -0600
Message-ID: <AANLkTin206xbPBf_LbS_vEXkXdG5XPaS9O0wrtEaz=yi@mail.gmail.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-4-git-send-email-omar.ramirez@ti.com>
	<87hbfqf491.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47914 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350Ab0KJDDJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 22:03:09 -0500
Received: by iwn6 with SMTP id 6so213401iwn.29
        for <linux-omap@vger.kernel.org>; Tue, 09 Nov 2010 19:03:09 -0800 (PST)
In-Reply-To: <87hbfqf491.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

On Tue, Nov 9, 2010 at 5:48 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>> =A0#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK=
_MODULE)
>> +static struct omap_device_pm_latency mbox_latencies[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =3D omap_device_enable_cloc=
ks,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .activate_lat =3D 50000, /* FIXME random v=
alue */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_enable_cl=
ocks,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_lat =3D 50000, /* FIXME random=
 value */
>> + =A0 =A0 },
>> +};
>
> hmm, I'm hoping you're not expecting this to merge when using random =
values.

This was changed on the second iteration of the patch [1], and is
still a WIP as some more comments have been made. I'll keep your
current comments though.

Regards,

Omar

---
[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38169.htm=
l
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
