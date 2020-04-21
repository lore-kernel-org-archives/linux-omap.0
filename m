Return-Path: <SRS0=Pap7=6F=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C186C55181
	for <linux-omap@archiver.kernel.org>; Tue, 21 Apr 2020 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E05720722
	for <linux-omap@archiver.kernel.org>; Tue, 21 Apr 2020 18:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="BMaiqDXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUSZN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUSZN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2020 14:25:13 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ED5C0610D5;
        Tue, 21 Apr 2020 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BnkBEcCOY/SxIpBs+cGPNLYWEpUlNsRB+sDsZ7uNMkw=; b=BMaiqDXAmYXQxiG/ApT09nz0ds
        7LCJI3YMBCWYeaeSaO1xxbGwIzvksb3ImIrTp40VYAKQlsQGq9Rtq6XpC2+i+5NkG/pFuHjLv8WC5
        weHy1qfOdnF8O87sh/rlMHiHtpN6syI11JjEU8hm/H5PkmFViaRCheDaeEuwGhaANIQI=;
Received: from p5dcc322a.dip0.t-ipconnect.de ([93.204.50.42] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jQxZt-0003bi-MR; Tue, 21 Apr 2020 20:25:03 +0200
Date:   Tue, 21 Apr 2020 20:24:59 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>,
        "Andrew F . Davis" <afd@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCHv3] w1: omap-hdq: Simplify driver with PM runtime
 autosuspend
Message-ID: <20200421202459.659ed1bf@aktux>
In-Reply-To: <20200421182017.GC37466@atomide.com>
References: <3197C3F0-DEB9-4221-AFBD-4F2A08C84C4C@goldelico.com>
        <20200417164340.3d9043d1@aktux>
        <6430AF54-849E-456B-8DB0-B4478BBDB78D@goldelico.com>
        <20200417150721.GL37466@atomide.com>
        <8E062482-5D5D-4837-9980-D6C708DD24D4@goldelico.com>
        <20200420150802.GR37466@atomide.com>
        <D1A77603-11FB-407F-B480-82C57E742C51@goldelico.com>
        <20200421085336.32cf8ffe@aktux>
        <20200421180220.GB37466@atomide.com>
        <70F19A6E-7B36-4873-9364-F284A14EE3A0@goldelico.com>
        <20200421182017.GC37466@atomide.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Tue, 21 Apr 2020 11:20:17 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * H. Nikolaus Schaller <hns@goldelico.com> [200421 18:14]:
> > > Am 21.04.2020 um 20:02 schrieb Tony Lindgren <tony@atomide.com>:
> > > This is 37xx though, maybe you have 35xx and there's some errata
> > > that we're not handling? =20
> >=20
> > No, it is dm3730 on three different units I have tried.
> >  =20
> > > I'm only seeing "2.7. HDQTM/1-Wire=C2=AE Communication Constraints"
> > > for external pull-up resitor in 34xx errata at [0].
> > >=20
> > > I wonder if wrong external pull could cause flakyeness after
> > > enabling the hdq module? =20
> >=20
> > I have checked and we have 10 kOhm pullup to 1.8 V and a 470 Ohm
> > series resistor. =20
>=20
> OK
>=20
> > > If nothing else helps, you could try to block idle for hdq
> > > module, but I have a feeling that's a workaround for something
> > > else. =20
> >=20
> > Well, what helps is reverting the patch and using the old driver
> > (which did work for several years). So I would not assume that
> > there is a hardware influence. It seems to be something the new
> > driver is doing differently. =20
>=20
> Well earlier hdq1w.c did not idle, now it does. If you just want
> to keep it enabled like earlier, you can just add something like:
>=20
> &hdqw1w {
> 	ti,no-idle;
> };
>=20
> > I need more time to understand and trace this issue on what it
> > depends... It may depend on the sequence some other modules are
> > loaded and what the user-space (udevd) is doing in the meantime. =20
>=20
> Yes would be good to understand what goes wrong here before we
> apply the ti,no-idle as that will block SoC deeper idle states.
>

hmm, he is testing without idling uarts, so I am a bit confused here,
the problem only seems to occur when more things are *active*.
Is something not handled in time.

Regards,
Andreas
