From: "Romantic, William" <wromantic@vocollect.com>
Subject: HSMMC block transfer (CMD53) doesn't complete
Date: Mon, 18 Aug 2008 13:11:54 -0400
Message-ID: <CDADC90344D4F540AE43CFF18CCEA01C087264E4@ex01.vocollect.int>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx4.vocollect.com ([64.212.175.114]:2499 "EHLO
	mx4.vocollect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYHRRnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 13:43:52 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org



Hi all,

I'm having a problem with the HSMMC driver.  If I attempt to send data
that amounts to less than the current SDIO block size, the transfer
never completes.  If set my block size to a value that's less than the
smallest amount of data that I intend to send, the driver properly
breaks it into blocks, sends them, and completes.

I did see a couple e-mails in the archives that look like they may be
talking about the same issue.  As far as I can tell though, they haven't
been resolved.

I'm using the OMAP35x evm, the Libertas driver, and a Marvel sd8686 WiFi
radio.  I currently have everything running with some workarounds and
I'm looking to properly resolve the issues.

Thank - You
William Romantic
