From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: Inconsistent lock state caused by omap_mbox_msg_send() called from tidspbridge
Date: Mon, 13 Dec 2010 17:45:54 +0100
Message-ID: <201012131745.54766.laurent.pinchart@ideasonboard.com>
References: <201012121344.51245.laurent.pinchart@ideasonboard.com> <1292163339.2375.2.camel@atlantis.mindbit.ro> <AANLkTimKQmrk+zw_kO2pjYY_6Oz3DW8EQQhfUCYRkpNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45147 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0LMQpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 11:45:05 -0500
In-Reply-To: <AANLkTimKQmrk+zw_kO2pjYY_6Oz3DW8EQQhfUCYRkpNa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Ionut Nicu <ionut.nicu@mindbit.ro>, linux-omap@vger.kernel.org

Hi Ionut and Ohad,

On Sunday 12 December 2010 15:22:38 Ohad Ben-Cohen wrote:
> On Sun, Dec 12, 2010 at 4:15 PM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> > I noticed this too, but this patch should fix it:
> > 
> > https://patchwork.kernel.org/patch/365292/
> 
> True. And in this patch the move to spin_lock_bh() is justifiable,
> too, since it adds a sending path which is parallel to the mailbox
> tasklet.

Is this patch set ready for inclusion in the mainline kernel, or does it need 
to be reworked ?

-- 
Regards,

Laurent Pinchart
