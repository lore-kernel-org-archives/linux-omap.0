From: David Brownell <david-b@pacbell.net>
Subject: Re: Errors on boot with 2.6.27-rc5 on omap3
Date: Wed, 3 Sep 2008 22:10:31 -0700
Message-ID: <200809032210.31687.david-b@pacbell.net>
References: <5e088bd90809032041u69a60e71h4c22cfa3ce06ec86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:41908 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755933AbYIDFKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 01:10:34 -0400
In-Reply-To: <5e088bd90809032041u69a60e71h4c22cfa3ce06ec86@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wednesday 03 September 2008, Steve Sakoman wrote:
> I get similar results for both Beagle and Overo, so the error occurs
> for both nand and onenand. =A0The boot eventually completes, of cours=
e
> without nand/onenand support.

Does this help?

  http://marc.info/?l=3Dlinux-kernel&m=3D121999823616458&w=3D2

Block layer goofage; that patch is in Jens' queue.




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
