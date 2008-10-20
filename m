From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/6] Integrate the twl4030 power code into new twl4030 mfd
Date: Mon, 20 Oct 2008 02:02:16 -0700
Message-ID: <200810200202.17033.david-b@pacbell.net>
References: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:37316 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751464AbYJTJCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 05:02:19 -0400
In-Reply-To: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 20 October 2008, Peter 'p2' De Schrijver wrote:
> This patchset integrates the twl4030 power code into the new twl4030 =
mfd framework.
> The scripts will be moved to the board specific data.
>=20
> Peter 'p2' De Schrijver (6):
> =A0 Add defines and data types for twl4030.
> =A0 Move existing TWL4030 code to drivers/mfd
> =A0 Hook twl4030 power code into twl4030 core.
> =A0 3430sdp and ldp use custom twl4030 power scripts.
> =A0 Generic twl4030 power script for 3430 based boards.
> =A0 omap3 evm, beagle and overo use the generic twl4030 script

Seems OK to me ... any reason this shouldn't go to mainline?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
