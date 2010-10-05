From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] omap: Ptr "isr_reg" tracked as NULL was
 dereferenced
Date: Tue, 5 Oct 2010 14:48:39 +0300
Message-ID: <20101005114839.GC2977@legolas.emea.dhcp.ti.com>
References: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
 <131d16236d19895323fca2f058d65f1f116bacad.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
 <20101005093206.GB2977@legolas.emea.dhcp.ti.com>
 <1286272519.24366.33.camel@ekuznets-lx-nokia>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab0JELtZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 07:49:25 -0400
Content-Disposition: inline
In-Reply-To: <1286272519.24366.33.camel@ekuznets-lx-nokia>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "zmc@lurian.net" <zmc@lurian.net>, "a.j.buxton@gmail.com" <a.j.buxton@gmail.com>

Hi,

(don't top post)

On Tue, Oct 05, 2010 at 04:55:19AM -0500, Evgeny Kuznetsov wrote:
>Yes, but no log in that case.

what do you call the stack dump BUG() shows ??

-- 
balbi
