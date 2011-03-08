From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 5/9] OMAP4 : DSS2 : HDMI: HDMI driver header file addition
Date: Tue, 8 Mar 2011 13:47:11 +0530
Message-ID: <AANLkTinLWp6T86ah7b=2-tYtNaya5F38e6e1BSmF-Qfh@mail.gmail.com>
References: <1299224907-11354-1-git-send-email-mythripk@ti.com>
	<1299224907-11354-6-git-send-email-mythripk@ti.com>
	<1299491185.2281.144.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42430 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459Ab1CHIRM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 03:17:12 -0500
Received: by mail-vw0-f44.google.com with SMTP id 6so5262249vws.31
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 00:17:11 -0800 (PST)
In-Reply-To: <1299491185.2281.144.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Mon, Mar 7, 2011 at 3:16 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Fri, 2011-03-04 at 01:48 -0600, K, Mythri P wrote:
>> Adding the hdmi interface driver header file (hdmi.h) to the dss dri=
ver.
>> Register and timing declaration to be used by the corresponding c fi=
le
>> is added in this file.
>
> The subject and description are wrong. Always before sending patches =
do
> a quick sanity check, by check the subjects, looking at the stats in =
the
> intro letter, etc.
My bad ,will reread.
>
>> Signed-off-by: Mythri P K <mythripk@ti.com>

<snip>

>> +const u8 header[8] =3D {0x0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x=
0};
>
> Bad variable name, use something more descriptive.
>
will rename to edid_header.
>> +

<snip>
>> +static int hdmi_wait_phy_pwr(int val)
>
> These comments apply also to the function below.
>
> The parameter should be an enum.
>
> The function is misnamed. This doesn't wait for the power mode to
> change, as the name implies. This sets the power mode.
>

will make refsel an enum and add other option , also make all these
functions to take enum as a parameter.

<snip>

>> + =A0 =A0 =A0 =A0* SW HACK : DDC needs time to stablize else it some=
times reads 0 values
>> + =A0 =A0 =A0 =A0* or right shifted values.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 usleep_range(800, 1000);
>
> This is still unclear. Is it an OMAP HW problem? OMAP HW feature? A
> feature in HDMI TVs? A HDMI spec delay? Or unknown reason?
>
there is an internal DDC (i2c bus) , without this delay I have
sometimes seen that while reading EDID
we sometimes (Not always and only with some TV's , even with a
particular TV it is not consistent)
read a shifted value or EDID value is 0. I can clarify with the h/w
team , but  can we add this as a s/w hack for time being?

<snip>

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
