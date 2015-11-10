From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: Minimal support for dm814x
Date: Tue, 10 Nov 2015 11:44:31 +0100
Message-ID: <CAALWOA9tn2FyZ8AawAxyS37N8B40eoMwz3frr7=N31UxUg8xCw@mail.gmail.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
 <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
 <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7933071D-84FD-4A85-8CD0-CC504CE1D9D1@audioscience.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Delio Brignoli <dbrignoli@audioscience.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 10 November 2015 at 11:23, Delio Brignoli <dbrignoli@audioscience.com> wrote:
> are you aware of section 2.1.2 of ...

I am. It seems that the digital PLLs tend to produce an asymmetrical
clock in general hence you need an even postdivider to get a 50% duty
cycle. DPLL-S however already has an implicit /2 divider integrated,
and a few peripherals seem to be fine with an asymmetrical clock (e.g.
apparently the USB subsystem which is clocked by PLL_USB / 5).

In the most recent SoCs they included a "DC corrector" in some PLLs to
be able to symmetrize the clock without the need for postdivision.
