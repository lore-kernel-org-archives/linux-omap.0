From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: hwmod: add syss reset done flags to omap2, omap3
 hwmods
Date: Sat, 26 Mar 2011 13:38:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1103261300570.1437@utopia.booyaka.com>
References: <1298542123-3654-1-git-send-email-avinashhm@ti.com> <alpine.DEB.2.00.1103031427580.10981@utopia.booyaka.com> <20110314161609.GA10506@avinash-laptop> <alpine.DEB.2.00.1103242336410.21987@utopia.booyaka.com> <20110325062534.GA25480@avinash-laptop>
 <20110325072035.GB25480@avinash-laptop> <alpine.DEB.2.00.1103251124040.21987@utopia.booyaka.com> <20110326113538.GB3668@avinash-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49041 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1CZTis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Mar 2011 15:38:48 -0400
In-Reply-To: <20110326113538.GB3668@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M." <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Sat, 26 Mar 2011, Avinash.H.M. wrote:

> Which boards are you testing? 

GPIO softreset warnings don't show up on either N800 or BeagleBoard 35xx 
as of commit 4047185.


- Paul
