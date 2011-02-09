From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH 2/2] OMAP4: add clk32kg data to omap4panda and blaze board file
Date: Wed, 9 Feb 2011 22:15:56 +0530
Message-ID: <AANLkTikj6kipoipkvLxLg31w6LSGcKUWadvV3F=gqvUn@mail.gmail.com>
References: <1297265851-21999-1-git-send-email-balajitk@ti.com>
	<20110209154509.GH24042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49382 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752105Ab1BIQp6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 11:45:58 -0500
Received: by mail-qy0-f182.google.com with SMTP id 36so280482qyk.20
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 08:45:57 -0800 (PST)
In-Reply-To: <20110209154509.GH24042@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, sameo@linux.intel.com

On Wed, Feb 9, 2011 at 9:15 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Feb 09, 2011 at 09:07:31PM +0530, Balaji T K wrote:
>
>> + =A0 =A0 .constraints =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGULATO=
R_MODE_NORMAL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_MODE_STANDBY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REGULA=
TOR_CHANGE_MODE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | REGULATOR_CHANGE_STATUS,
>
> Does this really support mode setting?
>

No, It didn't support mode setting.
will update valid_ops_mask for REGULATOR_CHANGE_STATUS only
and remove valid_modes_mask
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
