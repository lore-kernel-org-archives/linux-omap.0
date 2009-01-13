From: "Anuj Aggarwal" <anuj.aggarwal@gmail.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Tue, 13 Jan 2009 21:07:34 +0530
Message-ID: <2ee9e08d0901130737k74448d8fua04881f374b227cc@mail.gmail.com>
References: <20090112145051.GL9373@atomide.com>
	 <B5CEECBB-9939-46B9-BEDB-D8D9879DB63E@student.utwente.nl>
	 <20090112161514.GP9373@atomide.com>
	 <20090113090801.3a575b89.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:24563 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbZAMPhg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 10:37:36 -0500
Received: by yw-out-2324.google.com with SMTP id 9so26900ywe.1
        for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 07:37:35 -0800 (PST)
In-Reply-To: <20090113090801.3a575b89.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

I tried ASoC by removing the commit "ARM: OMAP3: Mask interrupts when
disabling interrupts" (023ae898bbbed8c2bc4d38bfbd05d2fee91c3468) and
audio worked fine for me.

Regards,
Anuj

On Tue, Jan 13, 2009 at 12:38 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
>
> On Mon, 12 Jan 2009 18:15:20 +0200
> "ext Tony Lindgren" <tony@atomide.com> wrote:
>
> > >> - According to Jarkko Nikula, ASoC does not currently work because of
> > >>  some recent clock changes.
> > >
> > > Confirmed on omap3evm.
> >
> > Thanks, can you try to git-bisect the breaking commit?
> >
> I did very short test on sunday and it was working at least when
> checkouting into 12081fce83c10221ccd1b282e3e2fbe56f742e21, i.e. commit
> before 60b8b431e47d8c5b8c02a2e4fa9af388aae20790 which was mentioned in
> the commit 818862e11bad091dc635baedace58265a126b5c8 :-)
>
> Paul was going to take a look tomorrow.
>
>
> Jarkko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Best Regards,
Anuj Aggarwal
