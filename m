From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 05/15] omap: add support for oscillator setup
Date: Mon, 12 Dec 2011 11:40:22 +0200
Message-ID: <1323682822.31914.9.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-6-git-send-email-t-kristo@ti.com> <87obvhfvnq.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45870 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1LLJk0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:40:26 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBC9ePuQ003253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:40:25 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9ePtj016180
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:40:25 -0600 (CST)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBC9ePKS013833
	for <linux-omap@vger.kernel.org>; Mon, 12 Dec 2011 03:40:25 -0600 (CST)
In-Reply-To: <87obvhfvnq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

On Fri, 2011-12-09 at 10:27 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > This contains startup and shutdown times for the oscillator. By default
> > use MAX_INT. 
> 
> nit: code uses ULONG_MAX

Oops, will fix the comment.

> 
> > Oscillator setup is used for calculating and setting up
> > latencies for sleep modes that disable oscillator.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Otherwise, looks fine.
> 
> Kevin


