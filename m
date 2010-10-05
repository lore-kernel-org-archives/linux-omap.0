From: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Subject: Re: [PATCH 1/1] omap: Ptr "isr_reg" tracked as NULL was
 dereferenced
Date: Tue, 05 Oct 2010 13:55:19 +0400
Message-ID: <1286272519.24366.33.camel@ekuznets-lx-nokia>
References: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
	 <131d16236d19895323fca2f058d65f1f116bacad.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
	 <20101005093206.GB2977@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22421 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802Ab0JEJ7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 05:59:16 -0400
In-Reply-To: <20101005093206.GB2977@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "zmc@lurian.net" <zmc@lurian.net>, "a.j.buxton@gmail.com" <a.j.buxton@gmail.com>

Hi,

Yes, but no log in that case.

Regards,
Evgeny

On Tue, 2010-10-05 at 12:32 +0300, ext Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 05, 2010 at 03:42:10AM -0500, Evgeny Kuznetsov wrote:
> >+	if (!isr_reg) {
> >+		printk(KERN_ERR "FATAL: Incorrect GPIO method %i\n",
> >+				bank->method);
> >+		BUG();
> >+		}
> 
> this could be simply:
> 
> BUG_ON(!isr_reg);
> 


