From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 10/11] OMAP: GPIO: Implement GPIO as a platform
 device
Date: Tue, 7 Dec 2010 14:07:25 -0800
Message-ID: <20101207220725.GB17435@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <1290689318-10191-11-git-send-email-charu@ti.com>
 <AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
 <AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
 <AANLkTikPey17e6wTHJ2zq8N=r_pNKXV4YjVbTK5e+tYt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:44790 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab0LGWHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 17:07:32 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikPey17e6wTHJ2zq8N=r_pNKXV4YjVbTK5e+tYt@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com, Rajendra Nayak <rnayak@ti.com>

* Varadarajan, Charulatha <charu@ti.com> [101206 22:58]:
> On Tue, Dec 7, 2010 at 11:05, Varadarajan, Charulatha <charu@ti.com> =
wrote:
> >
> > On Tue, Dec 7, 2010 at 10:49, Cory Maccarrone <darkstar6262@gmail.c=
om> wrote:
> >>
> >> =C2=A0 =C2=A0omap_gpio omap_gpio.5: Could not get gpio dbck
> >> =C2=A0 =C2=A0omap_gpio omap_gpio.6: Could not get gpio dbck
> >>
> >> I think that 'if' should be:
> >>
> >> =C2=A0 =C2=A0if (bank->dbck_flag && !bank->dbck) {
> >
> > You are right. Will send a patch now.

Looks like if that's a warning no need to merge it into the
earlier patches.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
