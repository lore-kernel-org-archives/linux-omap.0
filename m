From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v3] printk: add option to print cpu id
Date: Fri, 3 Aug 2012 23:08:22 +0300
Message-ID: <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
 <m2628z6euk.fsf@firstfloor.org>
 <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:55998 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2HCUIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 16:08:30 -0400
Content-Disposition: inline
In-Reply-To: <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Andi Kleen <andi@firstfloor.org>, gregkh@linuxfoundation.org, kay@vrfy.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>

Hi,

On Fri, Aug 03, 2012 at 11:25:37AM -0700, Pandita, Vikram wrote:
> > And really: Wasting 1/3 of the 80 character line is too much.
> 
> You _WASTE_ 4 chars only if you are interested in this info by
> enabling: CONFIG_PRINTK_CPUID

I guess you waste 4 + 3 chars? You could optimize the length by checking
CONFIG_NR_CPUS?

A.
