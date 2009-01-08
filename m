From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: About to tag v2.6.28-omap1 on Friday
Date: Thu, 08 Jan 2009 12:22:33 +0200
Message-ID: <1231410153.13843.46.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32252 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbZAHKZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 05:25:20 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n08AP695017149
	for <linux-omap@vger.kernel.org>; Thu, 8 Jan 2009 12:25:16 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n08AOLTx001071
	for <linux-omap@vger.kernel.org>; Thu, 8 Jan 2009 12:24:21 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> Looks like we now have some McBSP clock issue probably related
> to the custom clock:

Could you please try:
http://marc.info/?l=linux-omap&m=122597514326263&w=2

And possibly ack the patch?

McBSP has a known spin-lock deadlock, why carry it around?

- Eero

