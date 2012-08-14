From: Peter Barada <peter.barada@logicpd.com>
Subject: OMAP34xx HW 1-bit ECC algorithm
Date: Tue, 14 Aug 2012 12:59:54 -0400
Message-ID: <502A840A.4000106@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:36757
	"HELO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1753061Ab2HNREo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 13:04:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter Barada <peter.barada@logicpd.com>

Is there any source for code that generates a 3-byte subpage ECC that
matches the ECC the bootrom is expecting when reading bootloader code
out of the first block of NAND?

I'm dealing with a problem of the Micron MT46H256M32L4K1-5 that has a
in-chip BCH ECC engine on our boards where a reset doesn't clear the
in-chip ECC.  The in-chip ECC resides at bytes 8-15, 24-31, 40-47, 56-63
of the OOB, and the first half-page ECC overlaps the 3rd and 4th page HW
1-bit ECC.  I need to synthesize data in the 3rd/4th subpages for the
code loaded from the bootloader that matches bytes 8-12 of the Micron
in-chip ECC.

Thanks in advance!

-- 
Peter Barada
peter.barada@logicpd.com

