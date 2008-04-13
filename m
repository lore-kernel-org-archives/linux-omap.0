From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: RE: Problems with 2430 NAND prefetch engine
Date: Sun, 13 Apr 2008 17:52:35 +0530
Message-ID: <AC2D475575504148943F5EB0938951C40236341E@dbde01.ent.ti.com>
References: <a46a26fd0804081733i469936d4m3315f3bb3270ff5@mail.gmail.com> <20080411192227.GH7717@atomide.com> <a46a26fd0804111410x2b2e580cw833480139ec2e666@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:46292 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406AbYDMMWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Apr 2008 08:22:55 -0400
Content-class: urn:content-classes:message
In-Reply-To: <a46a26fd0804111410x2b2e580cw833480139ec2e666@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

> Yes, GPMC access without prefetch engine works fine so clocks are on.
> 
> I was able to solve this problem though. U-boot configured CS0 mapping
> to be 128MB. If I change this to 64MB it works.
> Very strange indeed.
> 

Normally this sort of problem would happen if the start address for the NAND map is not aligned to 128MB boundary. 

Regards,
Rohit
