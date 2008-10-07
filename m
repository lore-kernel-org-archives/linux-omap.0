From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/3] Move twl4030 scripts to platform data
Date: Tue, 7 Oct 2008 09:05:43 -0700
Message-ID: <200810070905.43912.david-b@pacbell.net>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:20246 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752882AbYJGQFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 12:05:46 -0400
In-Reply-To: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 07 October 2008, Peter 'p2' De Schrijver wrote:
> This patch set move the twl4030 scripts to platform data
> and integrates the code to download the scripts with the
> new twl4030 codebase. =20
>=20
> Peter 'p2' De Schrijver (3):
> =A0 Add twl4030 scripts to 3430sdp platform data
> =A0 Adapt twl4030 power code to new twl4030 code
> =A0 Add twl4030 power platform device

Good. Those scripts were absolutely not in the
right kind of location before!

Your patch comments are all rather uniformly
empty though, worth fixing ...=20

=2E.. and patch #1 (add scripts) breaks compiles,
it should include the header update from #2.

And I'll suggest a patch #4 to move this from
the drivers/i2c/chips directory to someplace
more appropriate.  Not that I have a sugggestion
on where; but drivers/i2c is clearly wrong!

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
