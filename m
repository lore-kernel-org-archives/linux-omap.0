From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2/4] net: cpsw: Add parent<->child relation support between cpsw and mdio
Date: Tue, 30 Oct 2012 22:34:32 +0100
Message-ID: <87390vhcev.fsf@macbook.be.48ers.dk>
References: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
	<1351498881-32482-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44203 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934279Ab2J3Veg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 17:34:36 -0400
In-Reply-To: <1351498881-32482-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Mon, 29 Oct 2012 13:51:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: netdev@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> CPGMAC SubSystem consist of various sub-modules, like, mdio,
 Vaibhav> cpdma, cpsw, etc... These sub-modules are also used in some of
 Vaibhav> Davinci family of devices. Now based on requirement, use-case
 Vaibhav> and available technology nodes the integration of these
 Vaibhav> sub-modules varies across devices.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
