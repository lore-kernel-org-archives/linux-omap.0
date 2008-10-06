From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 1/10] HDQ driver: Remove global pointer
Date: Mon, 6 Oct 2008 15:05:32 +0530
Message-ID: <04e801c92796$e3a32f70$LocalHost@wipultra1303>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EAA@dbde02.ent.ti.com> <20080925114057.GB31477@2ka.mipt.ru> <20081006091705.GA2806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50750 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbYJFJiq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 05:38:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>; <felipe.balbi@nokia.com>; <linux-omap@vger.kernel.org>; "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Sent: Monday, October 06, 2008 2:47 PM
Subject: Re: [PATCH 1/10] HDQ driver: Remove global pointer


>* Evgeniy Polyakov <johnpol@2ka.mipt.ru> [080925 14:41]:
>> Hi.
>> 
>> On Thu, Sep 25, 2008 at 12:19:44PM +0530, Gadiyar, Anand (gadiyar@ti.com) wrote:
>> > From: Madhusudhan Chikkature <madhu.cr@ti.com>
>> > 
>> > This patch provides the necessary modifications to the driver to
>> > remove the global ptr hdq_data.
>> > 
>> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
>> 
>> Looks ok, IA ck the whole serie.
> 
> Great, pushing to linux-omap tree.
> 
> Evgeniy, are these already in your queue for upstream?

Tony,
These patches are against the L-o tree. We need to send the complete driver patches against the LKML kernel tree to Evgeniy.

Regards,
Madhu
> 
> Tony
> 
>
