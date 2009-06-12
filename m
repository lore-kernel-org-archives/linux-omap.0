From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Which directory should OMAP-L137/L138's code in ?
Date: Fri, 12 Jun 2009 17:56:31 +0800
Message-ID: <4A32264F.6050609@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63137 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933646AbZFLJwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jun 2009 05:52:12 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n5C9qFu8017772
	for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 02:52:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am developing on the board OMAP-L137/L138, which is similar with 
Davinci series board.  Should I put its platform file in the directory 
arch/arm/mach-davinci ? or create a new direcory arch/arch/mach-L1xx for 
it ?

Any suggestions ?

Thanks
Stanley.
