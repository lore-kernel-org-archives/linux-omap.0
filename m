From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 0/1] Group and resource assignments for TWL4030
Date: Sun, 15 Feb 2009 18:48:51 +0200
Message-ID: <20090215164851.GA19407@codecarver.research.nokia.com>
References: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com> <200902131255.21379.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59532 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZBOQtI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2009 11:49:08 -0500
Content-Disposition: inline
In-Reply-To: <200902131255.21379.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 13, 2009 at 09:55:21PM +0100, ext David Brownell wrote:
> On Tuesday 10 February 2009, Peter 'p2' De Schrijver wrote:
> >
> > This patch introduces support for board specific group assignments of TWL4030
> > resources. The resource type and type2 fields can also be specified.
> 
> Do we have any real examples yet of needing to assign
> resources to anything other than P1 (processor)?
> 

Yes. On our custom hardware we use it to assign CLKEN to P3.

Cheers,

Peter.

-- 
goa is a state of mind
