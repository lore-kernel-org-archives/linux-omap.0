From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Fri, 24 Apr 2009 11:31:35 +0530
Message-ID: <5d5443650904232301wb01150eu33e65074cf6223e8@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
	 <20090404000531.GE8840@atomide.com>
	 <5d5443650904230630v454c2c7ft526b020731278010@mail.gmail.com>
	 <200904231517.11338.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:58397 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbZDXGBh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 02:01:37 -0400
Received: by qyk16 with SMTP id 16so1921399qyk.33
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 23:01:35 -0700 (PDT)
In-Reply-To: <200904231517.11338.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi David,

On Fri, Apr 24, 2009 at 3:47 AM, David Brownell <david-b@pacbell.net> w=
rote:
> On Thursday 23 April 2009, Trilok Soni wrote:
>> Any updates on tps65023 regulator driver? Could you please submit th=
e
>> WIP patches to the list?
>
> FWIW, here's the last version I saw ... it includes a
> build hack for the regulator_register() call. =A0I haven't
> build-tested it since that API change went to mainline.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> From: Manikandan Pillai <mani.pillai@ti.com>
> Subject: regulator: add support for TPS6235x
>
> The patch has been fixed for comments given by David Brownell
> and Mark Brown for adding TPS6235x support on OMAP3 EVM.
> Comments fixed include
> moving Makefile changes to this patch
> dev_err used
> removed the extra configuration option from Kconfig

Thanks but I was requesting tps 6 5 0 2 3 not tps 6 2 3 5 x  :).

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
