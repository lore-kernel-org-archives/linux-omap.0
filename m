From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Tue, 2 Sep 2008 07:51:48 -0700
Message-ID: <200809020751.48357.david-b@pacbell.net>
References: <1220276228.2680.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:30035 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751259AbYIBOvv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 10:51:51 -0400
In-Reply-To: <1220276228.2680.9.camel@localhost>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stanley.miao@windriver.com
Cc: linux-omap@vger.kernel.org

On Monday 01 September 2008, stanley.miao wrote:
> +=A0=A0=A0=A0=A0=A0=A0if(!is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {

But checkpatch.pl rejected that, yes?  Fixed in a later
version I see.

=2E.. and in "static int sdp2430_panel_enable(...)" this would
seem to be wrong.  But for that matter, lcd_2430sdp.c should
not be relevant for any 3430 board anyway...

If that file is, oddly, being shared between two boards ...
then put that code in the "if (machine_is_omap_3430sdp())"
block.  And someone should consider renaming the file if
it's not specific to the 2430 SDP.



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
