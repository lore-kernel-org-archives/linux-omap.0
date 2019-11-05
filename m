From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 14:20:42 +0200
Message-ID: <20191105122042.GO32742@smile.fi.intel.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Semi Malinen <semi.malinen@ge.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-aspeed@lists.ozlabs.org, David Daney <david.daney@cavium.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Peter Tyser <ptyser@xes-inc.com>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Marek Vasut <marek.vasut+renesas@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Marek Behun <marek.behun@nic.cz>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, bcm-kernel-feedback-list@broadcom.com, Joel Stanley <joel@jms.id.au>, Uwe
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 05, 2019 at 12:09:10PM +0200, Matti Vaittinen wrote:
> The patch series adds definitions for GPIO line directions.
> 
> For occasional GPIO contributor like me it is always a pain to remember
> whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging the
> fact that I removed few comments like:
> 
> /* Return 0 if output, 1 if input */
> /* This means "out" */
> return 1; /* input */
> return 0; /* output */
> 
> it seems at least some others may find it hard to remember too. Adding
> defines for these values helps us who really have good - but short
> duration - memory :]
> 
> Please also see the last patch. It adds warning prints to be emitted
> from gpiolib if other than defined values are used. This patch can be
> dropped out if there is a reason for that to still be allowed.
> 
> This idea comes from RFC series for ROHM BD71828 PMIC and was initially
> discussed with Linus Walleij here:
> https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.camel@fi.rohmeurope.com/
> but as this has no dependencies to BD71828 work (which probably takes a
> while) I decided to make it independent series.
> 
> Patches are compile-tested only. I have no HW to really test them. Thus I'd
> appreciate carefull review. This work is mainly about converting zeros
> and ones to the new defines but it wouldn't be first time I get it wrong
> in one of the patches :)

For all patches I have been Cc'ed to, NAK.

I don't see the advantages now since all known hardware uses the single bit to
describe direction (even for Intel where we have separate gating for in and out
buffers the direction we basically rely on the bit that enables out buffer).

So, that said the direction is always 1 bit and basically 0/1 value. Which one
is in and which one is out just a matter of an agreement we did.

I would also like to see bloat-o-meter statistics before and after your patch.
My guts tell me that the result will be not in the favour of yours solution.

-- 
With Best Regards,
Andy Shevchenko
