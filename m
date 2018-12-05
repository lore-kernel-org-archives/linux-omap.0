From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: dts: am437x: Move l4 child devices to probe
 them with ti-sysc
Date: Wed, 5 Dec 2018 11:00:19 -0800
Message-ID: <20181205190019.GG6707@atomide.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-3-tony@atomide.com>
 <f890f989-bfd0-47eb-66e0-5a8573e398b7@ti.com>
 <20181204181121.GC6707@atomide.com>
 <20181204231833.GF6707@atomide.com>
 <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3feb7078-5690-abf6-2a9d-a65807ee701a@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181205 06:12]:
> On 05/12/2018 1.18, Tony Lindgren wrote:
> > After applying " drm/omap: fix bus_flags for panel-dpi" LCD
> > works again. But modprobe of snd-soc-davinci-mcasp and
> > snd-soc-tlv320aic3x still does not show anything with aplay -l.
> 
> Hrm, why they are not loaded automatically?

Hmm I guess I'm missing some piece of software I've
removed from my system years ago already? :)

> > Do I need some other patch or codec driver?
> 
> snd-soc-edma
> snd-soc-davinci-mcasp
> snd-soc-tlv320aic3x
> snd-soc-simple-card

Oh I thought I tried that but maybe I tried with graph card.
Got it working now thanks.

I think we're missing the top level ranges for mcasp l3 port
and the translation goes wrong there, I'll fix it hopefully
today.

Regards,

Tony
