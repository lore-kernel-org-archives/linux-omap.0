From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 08/14] Input: twl4030-vibra: Support for
 DT booted kernel
Date: Fri, 07 Sep 2012 16:35:21 +0300
Message-ID: <5049F819.1080101@ti.com>
References: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
 <1346933541-21547-9-git-send-email-peter.ujfalusi@ti.com>
 <20120906161933.GA18562@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120906161933.GA18562@core.coreip.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

On 09/06/2012 07:19 PM, Dmitry Torokhov wrote:
> In patch 6 you added a stub for of_find_node_by_name(), so do you really
> need this #ifdef?

True. I'll resend the series since I left the #ifdef also in other patch.

> Otherwise it looks good.
> =

> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thank you,
P=E9ter
