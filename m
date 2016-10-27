From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 0/5] Minimal cpuidle fixes for omap5 and dra7
Date: Thu, 27 Oct 2016 09:43:14 +0200
Message-ID: <629EF372-C3B5-4D55-AF88-3DB72C065687@goldelico.com>
References: <20161026151703.24730-1-tony@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Pau Pajuel <ppajuel@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


> Am 26.10.2016 um 17:16 schrieb Tony Lindgren <tony@atomide.com>:
> 
> Hi all,
> 
> Here are some fixes to get minimal cpuidle support working with omap5
> and dra7. Not sure if there are still some unsorted issues on enabling
> this on dra7, but at least omap5 has been behving for me for few
> weeks with these.

Seems to work on Pyra, but I could not really test.
At least it has no adverse effect.

BR,
Nikolaus
