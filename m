From: TAO HU <tghk48@motorola.com>
Subject: Re: Peripheral Power Management
Date: Fri, 4 Dec 2009 13:19:19 +0800
Message-ID: <5f4a33680912032119p24fae84drbef5331d26ba91ad@mail.gmail.com>
References: <82cfbe860912020129l63da6721ubeac01c9e131853e@mail.gmail.com>
	 <82cfbe860912020132n5e0c01adn64a3c1bd85f96df6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:42908 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbZLDFTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 00:19:13 -0500
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id nB45JlMk004904
	for <linux-omap@vger.kernel.org>; Thu, 3 Dec 2009 22:19:47 -0700 (MST)
Received: from mail-pw0-f52.google.com (mail-pw0-f52.google.com [209.85.160.52])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id nB45InOn004798
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Thu, 3 Dec 2009 22:19:47 -0700 (MST)
Received: by mail-pw0-f52.google.com with SMTP id 8so1442977pwi.31
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 21:19:19 -0800 (PST)
In-Reply-To: <82cfbe860912020132n5e0c01adn64a3c1bd85f96df6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarek attia <tarek.m.attia@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

You can use so called "auto idle".
I.e. Disable clocks (iclk, fclk) when there is no activities for
certain period of time

- Hu Tao

On Wed, Dec 2, 2009 at 5:32 PM, tarek attia <tarek.m.attia@gmail.com> w=
rote:
>
> I'm not talking about full chip off in suspend ,,but I'm talking abou=
t
> tern off some modules while they aren't in use however the cpu is
> running in normal mode not in idle
>
> On Wed, Dec 2, 2009 at 11:29 AM, tarek attia <tarek.m.attia@gmail.com=
> wrote:
> > Hi All,
> >
> > I know that CPU have power management through CPUFREQ,,but what abo=
ut
> > the peripherals like =A0(DVI-D) does it have a power management for=
 it
> > as well??,,and the rest of peripherals also ?
> >
> >
> >
> > Appreciate your response,
> >
> > Best Regards,
> > tarek
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
