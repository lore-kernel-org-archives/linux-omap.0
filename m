From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Fri, 5 Feb 2016 16:43:54 +0200
Message-ID: <56B4B52A.4060102@gmail.com>
References: <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
 <20160108075913.GN11364@pali> <569052FE.1040008@gmail.com>
 <20160121091437.GT7192@pali> <56B077D4.3030902@gmail.com>
 <20160202233911.GB19432@atomide.com> <20160203000045.GE19432@atomide.com>
 <56B1A654.1060905@gmail.com> <56B22FC3.3050900@gmail.com>
 <20160205061021.GS19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160205061021.GS19432@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org



On  5.02.2016 08:10, Tony Lindgren wrote:

> This seems to fix things here for legacy booting and booting the
> maemo zImage after dts image. Care to give it a try?
>
> Basically onenand after reset is in wrong state, have not looked
> up the bits yet. Will post a better patch when I get a chance
> over next few days.
>
> Regards,
>
> Tony

Yep, that looks to fix the things, I submitted a patch "[PATCH] ARM: 
OMAP2+: Fix onenand initialization to avoid filesystem corruption" (it 
was supposed to be a reply to this mail, but my git-send-mail-fu failed 
on me as always :) )

Thanks,
Ivo
