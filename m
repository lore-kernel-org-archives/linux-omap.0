From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 00/62] Add definition for GPIO direction
Date: Tue, 5 Nov 2019 15:59:46 +0100
Message-ID: <20191105145946.2ye6ujvqzn2d6fqd@pengutronix.de>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
 <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
 <20191105133604.d2xcasxw7pwzwvh7@pengutronix.de>
 <a967c764d135ab0f96f6b1df62ac91426c935b44.camel@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <a967c764d135ab0f96f6b1df62ac91426c935b44.camel@fi.rohmeurope.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, "david.daney@cavium.com" <david.daney@cavium.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "ptyser@xes-inc.com" <ptyser@xes-inc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "marek.behun@nic.cz" <marek.behun@nic.cz>, "festevam@gmail.com" <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "jonathanh@nvidia.com" <jonathan>
List-Id: linux-omap@vger.kernel.org

Hello Matti,

On Tue, Nov 05, 2019 at 02:00:02PM +0000, Vaittinen, Matti wrote:
> On Tue, 2019-11-05 at 14:36 +0100, Uwe Kleine-K=F6nig wrote:
> Thanks Uwe! That was kind! I'm on Fedora but I guess I can find the
> multiarch binutils :) I'll try that tomorrow when I'm back at the
> office. Let's see what kind of results I can get from it.
> =

> Unfortunately bunch of the GPIOs depend on x86 - so I need to see what
> I can compile in with decent effort. For my compile test I just hacked
> the Makefile to force all in and added some dummy macros to fix few
> missing functions :| But I guess I can get some results.

Enable CONFIG_COMPILE_TEST and then you should be able to compile most
drivers also on the wrong architecture.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
