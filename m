From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/7][RFC] OMAP4: Update common omap platform common
 sources.
Date: Tue, 21 Apr 2009 19:04:32 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A9A64323@dbde02.ent.ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CCA996D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbZDUNel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 09:34:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LDYZgG019888
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 08:34:41 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3LDYY0J021061
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 19:04:34 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CCA996D4@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Tuesday, April 21, 2009 6:51 PM
> To: Shilimkar, Santosh; linux-omap@vger.kernel.org
> Cc: Shilimkar, Santosh
> Subject: RE: [PATCH 4/7][RFC] OMAP4: Update common omap 
> platform common sources.
> 
> Any specific reason to use omap2 structures?

These are not actually the omap2 structures. Most of the common omap code uses something like 
'omap2_xxxxx_xxx'.
