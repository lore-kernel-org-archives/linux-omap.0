From: Arun MURTHY <arun.murthy@stericsson.com>
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Date: Tue, 28 Sep 2010 12:53:17 +0200
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FCA8@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
          <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
          <201009281114.31223.anarsoul@gmail.com>
          <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
       <63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>
       <F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.local>
    <19145.10.24.255.18.1285666483.squirrel@dbdmail.itg.ti.com>
    <F45880696056844FA6A73F415B568C69532DC2FBF9@EXDCVYMBSTM006.EQ1STM.local>
 <48808.10.24.255.18.1285670515.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:35258 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007Ab0I1Kxb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Sep 2010 06:53:31 -0400
In-Reply-To: <48808.10.24.255.18.1285670515.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > Let me be more specific, consider an environment where there is an
> APE and Power Management subsystem(separate IC but on same
> board/platform)
> > APE has a pwm module and Power Management SubSystem also has pwm
> module. Both are part of the platform.
> > Not there exists two drivers in a single platform and both of them
> are enabled. Building such a kernel results in re-declaration build
> error.
> >
> 
> Is this something specific to ST chipsets or do you know of any other
> chips which might use this feature.
> 
It's not like specific to ST chipset. There are multi Soc systems.
You can take ST chipset as an example.

And also let continue our discussion on the new thread that I have mailed so that the mailing list also gets notified.
Sorry for inconvenience.

Thanks and Regards,
Arun R Murthy
-------------

