From: "Paul Chiha" <paul.chiha@greyinnovation.com>
Subject: Help with interfacing to OMAP2+: McBSP
Date: Wed, 19 Oct 2011 17:18:54 +1100
Message-ID: <51A4F524D105AA4C93787F33E2C90E62EE5B4D@greysvr02.GreyInnovation.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eth1683.vic.adsl.internode.on.net ([150.101.217.146]:41225 "EHLO
	greyinnovation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752028Ab1JSGdI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 02:33:08 -0400
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I need to write a simple driver sends and receives packets over McBSP3
on the DM3730 processor, and was wondering if anyone has already this.
I understand that the functions in arch/arm/plat-omap/mcbsp.c need to be
used, and so I would like to see an example driver which uses them that
I can base mine one.
Any help would be appreciated.

Thanks,
Paul
