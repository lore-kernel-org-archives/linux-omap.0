From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: Question on OPP table handling
Date: Tue, 6 Oct 2009 18:13:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB055D11@dbde02.ent.ti.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
	<4AC76810.1040206@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com>
 <87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com>
 <74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC09146@dbde02.ent.ti.com>
 <4ACB2DAD.1090200@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDC0936B@dbde02.ent.ti.com>
 <4ACB3243.409@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDCE3DA1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34619 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033AbZJFMnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 08:43:46 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE3DA1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin H <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Dasgupta, Romit
> Sent: Tuesday, October 06, 2009 5:51 PM
> To: Menon, Nishanth
> Cc: Premi, Sanjeev; Cousson, Benoit; Kevin H; linux-omap@vger.kernel.org
> Subject: RE: Question on OPP table handling
> 
> Typo I meant Put all the OPP tables for different CPUs (instead ofOPPs) in
> __initdata. Copy the run time detected CPU's OPP table in memory. Others
> get discarded!"
This is a good idea. Or if we want to save the _Copy_ effort, then make all these opp table structures as 'const' so that it get moved to *.RO section. In that case all data is still available.
