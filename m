From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 0/6] Integrate the twl4030 power code into new twl4030
	mfd
Date: Fri, 24 Oct 2008 12:21:01 +0300
Message-ID: <20081024092101.GA4819@codecarver.research.nokia.com>
References: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com> <200810200202.17033.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64210 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYJXJVe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 05:21:34 -0400
Content-Disposition: inline
In-Reply-To: <200810200202.17033.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 20, 2008 at 02:02:16AM -0700, ext David Brownell wrote:
> On Monday 20 October 2008, Peter 'p2' De Schrijver wrote:
> > This patchset integrates the twl4030 power code into the new twl403=
0 mfd framework.
> > The scripts will be moved to the board specific data.
> >=20
> > Peter 'p2' De Schrijver (6):
> > =A0 Add defines and data types for twl4030.
> > =A0 Move existing TWL4030 code to drivers/mfd
> > =A0 Hook twl4030 power code into twl4030 core.
> > =A0 3430sdp and ldp use custom twl4030 power scripts.
> > =A0 Generic twl4030 power script for 3430 based boards.
> > =A0 omap3 evm, beagle and overo use the generic twl4030 script
>=20
> Seems OK to me ... any reason this shouldn't go to mainline?
>=20

I don't see any reason.

Cheers,

Peter.

--=20
goa is a state of mind
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
