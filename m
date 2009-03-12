From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] i2c: i2c-omap: Call request_irq with IRQF_DISABLED
Date: Thu, 12 Mar 2009 02:25:46 +0200
Message-ID: <20090312002545.GE19038@gandalf>
References: <cover.1236345858.git.Ext-Ari.Kauppi@nokia.com> <7d7e7dd1a4c64c732a21bdfcf2bd42556be708c3.1236345858.git.Ext-Ari.Kauppi@nokia.com> <20090310005222.GE19758@fluff.org.uk> <alpine.DEB.2.00.0903111741270.26959@utopia.booyaka.com> <20090311235908.GC19038@gandalf> <94a0d4530903111711r7728aeabo8aad5ccd51a33d38@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58661 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZCLA0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 20:26:05 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530903111711r7728aeabo8aad5ccd51a33d38@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: me@felipebalbi.com, Paul Walmsley <paul@pwsan.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Ben Dooks <ben@fluff.org.uk>, ben-linux@fluff.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, Mar 12, 2009 at 02:11:17AM +0200, Felipe Contreras wrote:
> That's my understanding too, but I think it has always been true:
> http://marc.info/?l=linux-kernel&m=123607685804562&w=2

sure, not merged yet though. And still the threaded irq support can't
handle twl4030 where the irq demuxing logic has to run in a thread due
to the need of communicating via i2c.

-- 
balbi
