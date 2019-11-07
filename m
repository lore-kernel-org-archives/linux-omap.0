From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio: Add definition for GPIO direction
Date: Thu, 7 Nov 2019 09:20:15 +0100
Message-ID: <CACRpkdZm823gEkpw8hYfuLp99ssKtGQMcEcZHC34xd2kQPYH-A@mail.gmail.com>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
 <fcd51b067bafa571b3d9879a3afc31e8c764100d.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <fcd51b067bafa571b3d9879a3afc31e8c764100d.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, David Daney <david.daney@cavium.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Peter Tyser <ptyser@xes-inc.com>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Marek Vasut <marek.vasut+renesas@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Marek Behun <marek.behun@nic.cz>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Joel Stanley <joel@jms.>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 6, 2019 at 9:51 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> At least for me it is difficult to remember the meaning of GPIO
> direction values. Define GPIO_LINE_DIRECTION_IN and
> GPIO_LINE_DIRECTION_OUT so that occasional GPIO contributors would
> not need to always check the meaning of hard coded values 1 and 0.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Patch applied.

Yours,
Linus Walleij
