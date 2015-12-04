From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
Date: Fri, 4 Dec 2015 07:46:35 -0800
Message-ID: <20151204154634.GH23396@atomide.com>
References: <1449184300-15693-1-git-send-email-tony@atomide.com>
 <1449184300-15693-2-git-send-email-tony@atomide.com>
 <CAALWOA-VmW6rqhL20y65+eNz2ujV=V8+X+f652X=g5LUytvNcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA-VmW6rqhL20y65+eNz2ujV=V8+X+f652X=g5LUytvNcQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Delio Brignoli <dbrignoli@audioscience.com>, Philipp Rosenberger <ilu@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [151203 18:44]:
> On 4 December 2015 at 00:11, Tony Lindgren <tony@atomide.com> wrote:
> > We can boot dra62x j5-eco using the dm814x code as the clocks and
> > devices are mapped in the device tree. The dra62x is also known
> > as jacinto 5.
> 
> I'm pretty sure the "eco" in the name isn't optional. As far as I know:
> jacinto 5 = dra65x ~ dm814x
> jacinto 5 eco = dra62x ~ dm811x
> jacinto 5 entry = dra61x/60x ~ am335x
> 
> Here ~ means equivalence modulo efuse bits.
> 
> My knowledge of TI's automotive processors is limited however, as is
> public documentation, so perhaps someone from TI can ack or nak this.

OK I'll update to to use "jacinto 5 eco" specifically to avoid more
confusion.

Thanks,

Tony
