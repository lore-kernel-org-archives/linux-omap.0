From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH 2/5] OMAP SSI driver interface
Date: Mon, 6 Oct 2008 18:03:06 -0700
Message-ID: <200810061803.06731.david-b@pacbell.net>
References: <1223034606.32631.156.camel@groo.research.nokia.com> <1223034750-18690-2-git-send-email-carlos.chinea@nokia.com> <20081006232931.GE8273@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:38882 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759069AbYJGBDK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 21:03:10 -0400
In-Reply-To: <20081006232931.GE8273@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Carlos Chinea <carlos.chinea@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 06 October 2008, Felipe Balbi wrote:
> looks much better and much easier to type: #include <linux/ssi.h>

Does this work on non-OMAP kernels?  If not, <mach/ssi.h> or
similar would seem more sensible ...

Agreed about there being way too many headers, too.
