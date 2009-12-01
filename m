From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: DSS2 Switch between multiple displays
Date: Tue, 1 Dec 2009 08:01:00 -0500
Message-ID: <1f11a5490912010501y4268c63qe77bf3de90d5ae37@mail.gmail.com>
References: <1f11a5490911301126p1444f93dga1821a67479d0c7e@mail.gmail.com>
	 <1259660728.14667.12.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58432 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbZLANAy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:00:54 -0500
Received: by yxe17 with SMTP id 17so4522957yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 01 Dec 2009 05:01:00 -0800 (PST)
In-Reply-To: <1259660728.14667.12.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Dec 1, 2009 at 4:45 AM, Tomi Valkeinen <tomi.valkeinen@nokia.co=
m> wrote:
> Hi,
>
> On Mon, 2009-11-30 at 20:26 +0100, ext Ashwin Bihari wrote:
>> My system is going to have to support multiple display panels and
>> switch between them using runtime checks. I've got two displays
>> currently registered and confirmed with:
>>
>> # cat displays
>> lcd e:1 u:1 t:0 h:480/2/2/41 v:272/2/6/10 p:10000 r:0 i:0
>> lcd e:0 u:1 t:0 h:480/2/2/41 v:800/2/6/10 p:10000 r:0 i:0
>>
>> Short of adding a new module parameter for me to key off the
>> panel_name to make the choice, is there some other way already
>> implemented for me to indicate which display the DSS2 system should
>> use as the default display panel?
>
> You are using an old version of DSS2. With later versions you can use
> omapdss.def_disp kernel parameter (see DSS documentation), or
> default_device field in omap_dss_board_info.
>
> =A0Tomi
>

Hi Tomi,

Ahh Ok.. I was using the Kernel within Android 1.6 which is
2.6.29-rc3, good to know that there is a scheme for this in the later
version. Hopefully when we make the jump to Android 2.0 and 2.6.31,
we'll pick up the DSS2 changes as well.

Regards
-- Ashwin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
