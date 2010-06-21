From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
Date: Mon, 21 Jun 2010 20:00:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032358ED7B@dbde02.ent.ti.com>
References: <4C1F429E.40107@gmail.com>
 <80021.96115.qm@web180310.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50773 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab0FUObB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 10:31:01 -0400
In-Reply-To: <80021.96115.qm@web180310.mail.gq1.yahoo.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

David,

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Monday, June 21, 2010 7:51 PM
> To: DebBarma, Tarun Kanti; Nishanth Menon
> Cc: linux-omap@vger.kernel.org; R, Sricharan
> Subject: Re: [PATCH v2] OMAP:GPTIMER:1ms tick generation correction
> 
> Doesn't the generic clock code have logic
> to handle such rounding issues?  I'm pretty
> sure I remember dealing with that issue for
> 32K timers on AT91 processors.  If so that
> means the setup is done wrong, and is fixable.
> 
I am not sure. But let me have look again.
