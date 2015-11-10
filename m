From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Minimal support for dm814x
Date: Tue, 10 Nov 2015 09:50:00 +0100
Message-ID: <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151109150602.GR3199@atomide.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Delio Brignoli <dbrignoli@audioscience.com>
List-Id: linux-omap@vger.kernel.org

On 9 November 2015 at 16:06, Tony Lindgren <tony@atomide.com> wrote:
> The PLL support is still missing, so it relies on the bootloader
> configured PLL values for now. I'm hoping to post PLL support patches over
> next few weeks and then we can have that and more devices working for v4.5.

Ah, yes, configuring a DPLL-LJ is fun.. figuring out how to write the
desired ratio as M/(M2*(1+N)) while simultaneously satisfying all
constraints on M, N, M2, refclk, and dco. :-)
