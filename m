From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/7] Integrate the twl4030 power code into new twl4030 mfd
Date: Tue, 14 Oct 2008 10:44:56 -0700
Message-ID: <200810141044.56888.david-b@pacbell.net>
References: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:34321 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751034AbYJNRqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 13:46:16 -0400
In-Reply-To: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 13 October 2008, Peter 'p2' De Schrijver wrote:
> This patchset integrates the twl4030 power code into the new
> twl4030 mfd framework. The scripts will be moved to the board
> specific data. =20

This basically looks OK, assuming the previous comments get
addressed. =20


> Peter 'p2' De Schrijver (7):
> =A0 Remove existing twl4030 power script code.
> =A0 Add defines and data types for twl4030.
> =A0 Twl4030 power code updated for new twl4030 core
> =A0 Hook twl4030 power code into twl4030 core.
> =A0 3430sdp and ldp use custom twl4030 power scripts.
> =A0 Generic twl4030 power script for 3430 based boards.
> =A0 omap3 evm, beagle and overo use the generic twl4030 script
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
