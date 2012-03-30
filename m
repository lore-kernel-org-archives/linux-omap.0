From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 17:54:04 +0530
Message-ID: <4F75A5E4.4080507@ti.com>
References: <1333094862.1932.15.camel@deskari> <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com> <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com> <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com> <4F758B15.1040905@ti.com> <4F75915D.9050205@ti.com> <CAMQu2gzXoqwdmd6xMs+Rp6TQDJtjQf+ydtRb3AL6+APnmfHzHA@mail.gmail.com> <4F75963C.2000508@ti.com> <CAMQu2gx0uOV9Kr=eQe_3e93RfE8L5txLsV4bvYOgAnjxQZr-GA@mail.gmail.com> <4F75A06A.80201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59840 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760346Ab2C3MYM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 08:24:12 -0400
Received: by obbta17 with SMTP id ta17so936139obb.3
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 05:24:10 -0700 (PDT)
In-Reply-To: <4F75A06A.80201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On Friday 30 March 2012 05:30 PM, Cousson, Benoit wrote:
> On 3/30/2012 1:20 PM, Shilimkar, Santosh wrote:

[..]

> Playing with clock domain state from the driver is just not acceptable.
>

Sorry for small digration but the clock-domain/power domain APIs
were coming in between CPUIDLE code movement to drivers/idle/*

How do we deal with that code which is today lying under platform
code.

Regards
Santosh

