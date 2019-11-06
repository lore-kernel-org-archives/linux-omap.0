From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 0/2] Add definition for GPIO direction
Date: Wed, 6 Nov 2019 17:28:51 +0000
Message-ID: <c333eb18eec9adf333e1b3cca2ff7ccacb2a863b.camel@fi.rohmeurope.com>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
 <20191106143938.GA3176@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191106143938.GA3176@icarus>
Content-Language: de-DE
Content-ID: <18FFF0DF279DD94B9327FC374E716AF8@de.rohmeurope.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "marek.behun@nic.cz" <marek.behun@nic.cz>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>"bgolaszewski@baylibre.com" <b>
List-Id: linux-omap@vger.kernel.org


On Wed, 2019-11-06 at 09:39 -0500, William Breathitt Gray wrote:
> On Wed, Nov 06, 2019 at 10:51:06AM +0200, Matti Vaittinen wrote:
> > The patch series adds definitions for GPIO line directions.

...snip...

> > This patch series is based on GPIO tree devel branch.
> 
> Just a tip for future patchsets in case you didn't know, you case
> specify the base of your patchset by using the "--base" option:
> https://git-scm.com/docs/git-format-patch#_base_tree_information
> 
> This will append a "base-commit" line with the commit hash at the end
> of
> the first message so that it's unabiguous which base you're using
> (useful in case the branch changes before your patch is reviewed).

Tanks William! I didn't know about the --base. It's nice to learn
something new every day :]

> > -- 
> > Matti Vaittinen, Linux device drivers
> > ROHM Semiconductors, Finland SWDC
> > Kiviharjunlenkki 1E
> > 90220 OULU
> > FINLAND
> > 
> > ~~~ "I don't think so," said Rene Descartes. Just then he vanished
> > ~~~
> > Simon says - in Latin please.
> > ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> > Thanks to Simon Glass for the translation =] 
