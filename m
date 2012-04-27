From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Fri, 27 Apr 2012 08:37:14 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA007DC@DBDE01.ent.ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
	<1335260749-25877-4-git-send-email-hvaibhav@ti.com>	<87aa1ybaxf.fsf@ti.com>
 <CA+Bv8XYG2heeWKMt-gdWkPD3_1kkcZspP_XgvCAdwynXzTA3AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36994 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab2D0IhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 04:37:24 -0400
In-Reply-To: <CA+Bv8XYG2heeWKMt-gdWkPD3_1kkcZspP_XgvCAdwynXzTA3AQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dill, Russ" <russ.dill@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Fri, Apr 27, 2012 at 02:13:10, Dill, Russ wrote:
> On Thu, Apr 26, 2012 at 11:33 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> >
> >
> > If so, please reply with your Tested-by.
> 
> Tested-by: Russ Dill <Russ.Dill@ti.com>
> 
> All three patches in series boot tested on:
> Beagleboard xM
> Beagleboard B4
> Mistral AM37X-EVM
> 

Thanks Russ, helping me out in validating this. I have also tested it on 
AM37xEVM platform and can conform that this fixes the issue.

Thanks,
Vaibhav
