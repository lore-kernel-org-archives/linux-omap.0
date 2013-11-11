From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] arm: omap2: Export devconf1 bypass and acbias.
Date: Mon, 11 Nov 2013 15:34:27 -0800
Message-ID: <20131111233426.GS15154@atomide.com>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <1381784555-18344-2-git-send-email-marek@goldelico.com>
 <20131111164917.GN15154@atomide.com>
 <CAAfyv34CyviSt_Jaygr-CYSQdZOBHz14awT3U8=2ZBT14s896g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv34CyviSt_Jaygr-CYSQdZOBHz14awT3U8=2ZBT14s896g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, LKML <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [131111 14:21]:
> AFAIK it's not pinmux it's register where we update bits. Or am I
> missing something?

Most of the omap control module registers seem to affect either
external pin configuration or internal signal muxes. So a big
chunk of them can already be handled with pinctrl-single,bits
for device tree.

But some of the control module registers also have regulator
and clock like features, and those are better exposed as
regulators and clocks to the consumer drivers.

Regards,

Tony
