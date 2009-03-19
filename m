From: David Brownell <david-b@pacbell.net>
Subject: Re: PM branch rebased to 2.6.29
Date: Thu, 19 Mar 2009 15:20:55 -0700
Message-ID: <200903191520.55565.david-b@pacbell.net>
References: <87bprz9zju.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:45351 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751159AbZCSWU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2009 18:20:58 -0400
In-Reply-To: <87bprz9zju.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 17 March 2009, Kevin Hilman wrote:
> - Beagle: MMC regulator: unbalanced disables. =A0This happens on boot
> =A0 and during suspend/resume. I don't think this is related to the P=
M
> =A0 branch, but is probably in linux-omap HEAD also, but didn't test.

It is.  Other boards may see that too.  Two fixes:

 * Least hassle ... I think all these should merge to the
   linux-omap tree in any case (and thence linux-pm):

    http://marc.info/?l=3Dlinux-omap&m=3D123699264117846&w=3D2
    http://marc.info/?l=3Dlinux-omap&m=3D123699340818395&w=3D2
    http://marc.info/?l=3Dlinux-omap&m=3D123705919713239&w=3D2

 * Or there are a number of regulator-framework patches
   floating around, all of which fix the bug there...

The root cause of this is that u-boot leaves VMMC1 active,
and the regulator framework doesn't cope with that yet.
The stackdump is basically caused by self-inconsistencies
in that framework.

The first fix lets the twl4030-power driver (not yet on
track for mainline merge) undo that, so the regulator
framework will no longer be confused.  That presumes a
bunch of board-specific patches fix that issue.  (As
well as setting up other power resources, e.g. so that
CLKREQ behaves, which is the real goal of that patch.)

The second fix -- in some flavor -- is IMO still needed,
since the first fix is just avoiding regulator framework
bugs. =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
